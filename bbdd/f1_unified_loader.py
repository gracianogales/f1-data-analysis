"""
Unified F1 Loader for Oracle
============================
Unifica:
- f1_oracle_loader.py (creacion de esquema + carga base)
- f1_advanced_loader.py (migracion avanzada + enriquecimiento)

Credenciales seguras:
- Usuario/DSN por argumentos o variables de entorno.
- Password solo por variable de entorno o prompt interactivo (no por CLI).

Variables de entorno soportadas:
- F1_DB_USER
- F1_DB_DSN
- F1_DB_PASSWORD
- F1_DB_WALLET_ZIP
"""

from __future__ import annotations

import argparse
import getpass
import os
from typing import List, Tuple

import fastf1

import f1_oracle_loader as base_loader
import f1_advanced_loader as advanced_loader


DEFAULT_SESSIONS: List[Tuple[int, str, str]] = [
    (2025, "Australia", "R"),
    (2025, "Australia", "Q"),
    (2025, "China", "R"),
    (2025, "Japan", "R"),
    (2025, "Bahrain", "R"),
    (2025, "Saudi Arabia", "R"),
    (2025, "Miami", "R"),
    (2025, "Emilia Romagna", "R"),
    (2025, "Monaco", "R"),
    (2025, "Spain", "R"),
]


def parse_session(value: str) -> Tuple[int, str, str]:
    """Parsea --session con formato YEAR|GP|TYPE."""
    parts = [p.strip() for p in value.split("|")]
    if len(parts) != 3:
        raise argparse.ArgumentTypeError(
            "Formato de --session invalido. Usa YEAR|GP|TYPE, por ejemplo 2025|Spain|R"
        )

    year_str, gp_name, session_type = parts
    if not year_str.isdigit():
        raise argparse.ArgumentTypeError(f"YEAR invalido en --session: {year_str}")

    year = int(year_str)
    if year < 1950 or year > 2100:
        raise argparse.ArgumentTypeError(f"YEAR fuera de rango: {year}")

    if not gp_name:
        raise argparse.ArgumentTypeError("GP no puede estar vacio")

    if not session_type:
        raise argparse.ArgumentTypeError("TYPE no puede estar vacio")

    return year, gp_name, session_type


def resolve_password(args: argparse.Namespace) -> str:
    """Obtiene password de env var o prompt interactivo."""
    password = None

    if args.db_password_env:
        password = os.getenv(args.db_password_env)

    if not password and args.prompt_password:
        password = getpass.getpass("Oracle password: ")

    if not password:
        raise SystemExit(
            "No se encontro password de BD. Usa una de estas opciones:\n"
            f"1) Exporta {args.db_password_env} con la clave\n"
            "2) Ejecuta con --prompt-password"
        )

    return password


def build_db_config(args: argparse.Namespace) -> dict:
    user = args.db_user or os.getenv("F1_DB_USER")
    dsn = args.dsn or os.getenv("F1_DB_DSN")

    if not user:
        raise SystemExit("Falta usuario. Usa --db-user o F1_DB_USER")
    if not dsn:
        raise SystemExit("Falta DSN. Usa --dsn o F1_DB_DSN")

    password = resolve_password(args)

    return {
        "user": user,
        "password": password,
        "dsn": dsn,
    }


def resolve_wallet(args: argparse.Namespace) -> str | None:
    if args.no_wallet:
        return None
    return args.wallet_zip or os.getenv("F1_DB_WALLET_ZIP")


def apply_runtime_config(
    db_config: dict,
    wallet_zip: str | None,
    cache_dir: str,
    sessions: List[Tuple[int, str, str]],
) -> None:
    """Inyecta configuracion en ambos modulos reutilizados."""
    base_loader.ORACLE_CONFIG = db_config.copy()
    advanced_loader.ORACLE_CONFIG = db_config.copy()

    base_loader.WALLET_ZIP_PATH = wallet_zip
    advanced_loader.WALLET_ZIP_PATH = wallet_zip

    base_loader.CACHE_DIR = cache_dir
    advanced_loader.CACHE_DIR = cache_dir

    base_loader.SESSIONS_TO_DOWNLOAD = sessions


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Carga unificada F1 completa en Oracle (base + avanzado)"
    )

    parser.add_argument("--db-user", help="Usuario Oracle (o F1_DB_USER)")
    parser.add_argument("--dsn", help="DSN Oracle (o F1_DB_DSN)")
    parser.add_argument(
        "--db-password-env",
        default="F1_DB_PASSWORD",
        help="Nombre de variable de entorno que contiene la password",
    )
    parser.add_argument(
        "--prompt-password",
        action="store_true",
        help="Pedir password por prompt interactivo si no existe en entorno",
    )

    parser.add_argument(
        "--wallet-zip",
        help="Ruta al wallet zip (o F1_DB_WALLET_ZIP). Ignorado con --no-wallet",
    )
    parser.add_argument(
        "--no-wallet",
        action="store_true",
        help="Forzar conexion sin wallet (TLS/DSN directo)",
    )

    parser.add_argument(
        "--cache-dir",
        default="./f1_cache",
        help="Directorio de cache para FastF1",
    )

    parser.add_argument(
        "--session",
        action="append",
        type=parse_session,
        help="Sesion a cargar con formato YEAR|GP|TYPE. Repetible.",
    )

    return parser.parse_args()


def run_base_pipeline(conn, sessions: List[Tuple[int, str, str]]) -> None:
    print("\n[BASE] Creando esquema...")
    base_loader.create_f1_schema(conn)

    print(f"\n[BASE] Precargando pilotos de {len(sessions)} sesiones...")
    try:
        base_loader.preload_all_drivers(conn, sessions)
    except Exception as exc:
        print(f"[BASE] Aviso en precarga de pilotos: {exc}")
        print("[BASE] Continuando con carga de sesiones")

    loaded = 0
    failed = 0

    print(f"\n[BASE] Cargando {len(sessions)} sesiones...")
    for year, gp_name, session_type in sessions:
        try:
            session_id = base_loader.load_session_without_drivers(
                conn, year, gp_name, session_type
            )
            if session_id:
                loaded += 1
            else:
                failed += 1
        except Exception as exc:
            print(f"[BASE] Error en {gp_name} {year} {session_type}: {exc}")
            conn.rollback()
            failed += 1

    print(f"[BASE] Resultado: {loaded} cargadas, {failed} fallidas")


def run_advanced_pipeline(conn) -> None:
    print("\n[ADVANCED] Migrando esquema avanzado...")
    advanced_loader.migrate_schema(conn)

    print("[ADVANCED] Procesando sesiones existentes...")
    advanced_loader.process_sessions(conn, reload_telemetry=True)

    print("[ADVANCED] Estadisticas finales:")
    advanced_loader.print_stats(conn)


def main() -> None:
    args = parse_args()

    db_config = build_db_config(args)
    wallet_zip = resolve_wallet(args)
    sessions = args.session if args.session else DEFAULT_SESSIONS

    apply_runtime_config(
        db_config=db_config,
        wallet_zip=wallet_zip,
        cache_dir=args.cache_dir,
        sessions=sessions,
    )

    os.makedirs(args.cache_dir, exist_ok=True)
    fastf1.Cache.enable_cache(args.cache_dir)

    print("\n=== Unified F1 Loader ===")
    print(f"User: {db_config['user']}")
    print(f"DSN: {db_config['dsn']}")
    print(f"Wallet: {'disabled' if wallet_zip is None else wallet_zip}")
    print(f"Cache: {args.cache_dir}")
    print(f"Sessions: {len(sessions)}")

    conn = base_loader.get_oracle_connection()

    try:
        run_base_pipeline(conn, sessions)
        run_advanced_pipeline(conn)
    finally:
        base_loader.cleanup_wallet(conn)
        conn.close()

    print("\nDone.")


if __name__ == "__main__":
    main()
