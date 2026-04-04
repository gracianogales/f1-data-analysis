# F1 Dataset Loader for Oracle

Carga y enriquece datos de Formula 1 (FastF1) en Oracle Database con un pipeline unificado:

- `f1_oracle_setup.sql`: Crea usuario y esquema de base de datos
- `f1_unified_loader.py`: orquestador unico (base + avanzado) con credenciales parametrizables de forma segura

## Requisitos

- Python 3.11+
- Oracle Database accesible
- Wallet Oracle (opcional, recomendado para ADB)

## Preparar usuario en Oracle (obligatorio)

Antes de cargar datos, crea el usuario y privilegios ejecutando el script SQL:

```sql
@f1_oracle_setup.sql
```

Este script crea/configura el usuario de la BD usado por `f1_unified_loader.py`.

Instalacion:

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

## Configuracion segura de credenciales

No guardes credenciales en el codigo ni en argumentos CLI.

Variables recomendadas:

```bash
export F1_DB_USER='f1_user'
export F1_DB_DSN='oracle26ai_medium'
export F1_DB_PASSWORD='TU_PASSWORD'
export F1_DB_WALLET_ZIP='/ruta/Wallet_oracle.zip'
```

Notas:
- `F1_DB_PASSWORD` es leida por `f1_unified_loader.py`.
- Alternativamente, puedes usar `--prompt-password` para introducirla en consola sin dejarla en historial.
- Si usas TLS sin wallet, ejecuta con `--no-wallet`.

## Uso rapido (script unificado)

Carga completa (base + avanzado, incluyendo telemetria avanzada XY/Z):

```bash
python3 f1_unified_loader.py
```

Sin variable de password (prompt interactivo):

```bash
python3 f1_unified_loader.py --db-user f1_user --dsn oracle26ai_medium --prompt-password
```

Cargar sesiones concretas (repetible):

```bash
python3 f1_unified_loader.py \
  --session "2025|Spain|R" \
  --session "2025|Monaco|R"
```

## Argumentos principales de `f1_unified_loader.py`

- `--db-user`: usuario Oracle (fallback `F1_DB_USER`)
- `--dsn`: DSN Oracle (fallback `F1_DB_DSN`)
- `--db-password-env`: nombre de env var de password (default `F1_DB_PASSWORD`)
- `--prompt-password`: pide password por terminal
- `--wallet-zip`: ruta wallet (fallback `F1_DB_WALLET_ZIP`)
- `--no-wallet`: fuerza conexion sin wallet
- `--cache-dir`: cache de FastF1 (default `./f1_cache`)
- `--session "YEAR|GP|TYPE"`: define sesiones a cargar

## Estructura de datos (resumen)

Tablas base:
- `f1_circuits`
- `f1_drivers`
- `f1_sessions`
- `f1_results`
- `f1_laps`
- `f1_telemetry`
- `f1_pitstops`
- `f1_weather`

Extension avanzada:
- `f1_race_control`
- Nuevas columnas en `f1_laps` (speed traps, stint, pit/lap times)
- Nuevas columnas en `f1_telemetry` (`z_position`, `session_time_ms`)


```bash
rm -rf ./f1_cache
python3 f1_unified_loader.py
```

