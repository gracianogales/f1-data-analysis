-- ============================================
-- 🏎️ SETUP RÁPIDO DE BASE DE DATOS F1 EN ORACLE
-- ============================================
-- Ejecutar en SQL*Plus, SQLcl o SQL Developer
-- Compatible con Oracle 23ai, 21c, 19c

-- 1. CREAR USUARIO (ejecutar como SYSDBA)
-- ============================================
/*
ALTER SESSION SET CONTAINER = FREEPDB1;

CREATE USER f1_user IDENTIFIED BY "F1_Demo_2026#"
    DEFAULT TABLESPACE USERS
    QUOTA UNLIMITED ON USERS;

GRANT CREATE SESSION TO f1_user;
GRANT CREATE TABLE TO f1_user;
GRANT CREATE VIEW TO f1_user;
GRANT CREATE SEQUENCE TO f1_user;
GRANT CREATE PROCEDURE TO f1_user;
*/

-- 2. CREAR TABLAS (ejecutar como f1_user)
-- ============================================

-- Tabla de Circuitos
CREATE TABLE f1_circuits (
    circuit_id VARCHAR2(50) PRIMARY KEY,
    circuit_name VARCHAR2(200),
    country VARCHAR2(100),
    location VARCHAR2(200),
    latitude NUMBER,
    longitude NUMBER,
    track_length_km NUMBER
);

-- Tabla de Equipos
CREATE TABLE f1_teams (
    team_id VARCHAR2(50) PRIMARY KEY,
    team_name VARCHAR2(200),
    team_color VARCHAR2(20),
    country VARCHAR2(100),
    base_location VARCHAR2(200)
);

-- Tabla de Pilotos
CREATE TABLE f1_drivers (
    driver_code VARCHAR2(10) PRIMARY KEY,
    first_name VARCHAR2(100),
    last_name VARCHAR2(100),
    full_name VARCHAR2(200),
    nationality VARCHAR2(100),
    team_id VARCHAR2(50),
    driver_number NUMBER,
    CONSTRAINT fk_driver_team FOREIGN KEY (team_id) REFERENCES f1_teams(team_id)
);

-- Tabla de Sesiones
CREATE TABLE f1_sessions (
    session_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    season_year NUMBER NOT NULL,
    round_number NUMBER,
    gp_name VARCHAR2(200) NOT NULL,
    session_type VARCHAR2(20) NOT NULL,
    session_date DATE,
    circuit_id VARCHAR2(50),
    CONSTRAINT fk_session_circuit FOREIGN KEY (circuit_id) REFERENCES f1_circuits(circuit_id)
);

-- Tabla de Resultados
CREATE TABLE f1_results (
    result_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    session_id NUMBER NOT NULL,
    driver_code VARCHAR2(10) NOT NULL,
    position NUMBER,
    grid_position NUMBER,
    points NUMBER,
    status VARCHAR2(100),
    total_time_ms NUMBER,
    fastest_lap NUMBER(1),
    CONSTRAINT fk_result_session FOREIGN KEY (session_id) REFERENCES f1_sessions(session_id)
);

-- Tabla de Vueltas
CREATE TABLE f1_laps (
    lap_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    session_id NUMBER NOT NULL,
    driver_code VARCHAR2(10) NOT NULL,
    lap_number NUMBER NOT NULL,
    lap_time_seconds NUMBER,
    sector1_time NUMBER,
    sector2_time NUMBER,
    sector3_time NUMBER,
    compound VARCHAR2(20),
    tyre_life NUMBER,
    is_personal_best NUMBER(1) DEFAULT 0,
    position NUMBER,
    CONSTRAINT fk_lap_session FOREIGN KEY (session_id) REFERENCES f1_sessions(session_id)
);

-- Tabla de Telemetría
CREATE TABLE f1_telemetry (
    telemetry_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    session_id NUMBER NOT NULL,
    driver_code VARCHAR2(10) NOT NULL,
    lap_number NUMBER,
    distance_m NUMBER,
    speed_kmh NUMBER,
    throttle_pct NUMBER,
    brake NUMBER,
    gear NUMBER,
    rpm NUMBER,
    drs NUMBER,
    x_pos NUMBER,
    y_pos NUMBER,
    CONSTRAINT fk_telemetry_session FOREIGN KEY (session_id) REFERENCES f1_sessions(session_id)
);

-- Tabla de Pit Stops
CREATE TABLE f1_pitstops (
    pitstop_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    session_id NUMBER NOT NULL,
    driver_code VARCHAR2(10) NOT NULL,
    lap_number NUMBER,
    stop_number NUMBER,
    duration_seconds NUMBER,
    CONSTRAINT fk_pitstop_session FOREIGN KEY (session_id) REFERENCES f1_sessions(session_id)
);

-- 3. CREAR ÍNDICES
-- ============================================
CREATE INDEX idx_laps_session ON f1_laps(session_id);
CREATE INDEX idx_laps_driver ON f1_laps(driver_code);
CREATE INDEX idx_laps_compound ON f1_laps(compound);
CREATE INDEX idx_telemetry_session ON f1_telemetry(session_id);
CREATE INDEX idx_telemetry_driver ON f1_telemetry(driver_code);
CREATE INDEX idx_telemetry_distance ON f1_telemetry(distance_m);
CREATE INDEX idx_results_session ON f1_results(session_id);

-- 4. INSERTAR DATOS DE EJEMPLO
-- ============================================

-- Equipos 2024
INSERT INTO f1_teams VALUES ('red_bull', 'Oracle Red Bull Racing', '#3671C6', 'Austria', 'Milton Keynes, UK');
INSERT INTO f1_teams VALUES ('ferrari', 'Scuderia Ferrari', '#E80020', 'Italy', 'Maranello, Italy');
INSERT INTO f1_teams VALUES ('mercedes', 'Mercedes-AMG Petronas', '#27F4D2', 'Germany', 'Brackley, UK');
INSERT INTO f1_teams VALUES ('mclaren', 'McLaren F1 Team', '#FF8000', 'UK', 'Woking, UK');
INSERT INTO f1_teams VALUES ('aston_martin', 'Aston Martin Aramco', '#229971', 'UK', 'Silverstone, UK');
INSERT INTO f1_teams VALUES ('alpine', 'BWT Alpine F1 Team', '#FF87BC', 'France', 'Enstone, UK');
INSERT INTO f1_teams VALUES ('williams', 'Williams Racing', '#64C4FF', 'UK', 'Grove, UK');
INSERT INTO f1_teams VALUES ('haas', 'MoneyGram Haas F1 Team', '#B6BABD', 'USA', 'Kannapolis, USA');
INSERT INTO f1_teams VALUES ('rb', 'Visa Cash App RB', '#6692FF', 'Italy', 'Faenza, Italy');
INSERT INTO f1_teams VALUES ('sauber', 'Stake F1 Team Kick Sauber', '#52E252', 'Switzerland', 'Hinwil, Switzerland');

-- Pilotos 2024
INSERT INTO f1_drivers VALUES ('VER', 'Max', 'Verstappen', 'Max Verstappen', 'Dutch', 'red_bull', 1);
INSERT INTO f1_drivers VALUES ('PER', 'Sergio', 'Pérez', 'Sergio Pérez', 'Mexican', 'red_bull', 11);
INSERT INTO f1_drivers VALUES ('LEC', 'Charles', 'Leclerc', 'Charles Leclerc', 'Monegasque', 'ferrari', 16);
INSERT INTO f1_drivers VALUES ('SAI', 'Carlos', 'Sainz', 'Carlos Sainz', 'Spanish', 'ferrari', 55);
INSERT INTO f1_drivers VALUES ('HAM', 'Lewis', 'Hamilton', 'Lewis Hamilton', 'British', 'mercedes', 44);
INSERT INTO f1_drivers VALUES ('RUS', 'George', 'Russell', 'George Russell', 'British', 'mercedes', 63);
INSERT INTO f1_drivers VALUES ('NOR', 'Lando', 'Norris', 'Lando Norris', 'British', 'mclaren', 4);
INSERT INTO f1_drivers VALUES ('PIA', 'Oscar', 'Piastri', 'Oscar Piastri', 'Australian', 'mclaren', 81);
INSERT INTO f1_drivers VALUES ('ALO', 'Fernando', 'Alonso', 'Fernando Alonso', 'Spanish', 'aston_martin', 14);
INSERT INTO f1_drivers VALUES ('STR', 'Lance', 'Stroll', 'Lance Stroll', 'Canadian', 'aston_martin', 18);

-- Circuitos
INSERT INTO f1_circuits VALUES ('monaco', 'Circuit de Monaco', 'Monaco', 'Monte Carlo', 43.7347, 7.4206, 3.337);
INSERT INTO f1_circuits VALUES ('barcelona', 'Circuit de Barcelona-Catalunya', 'Spain', 'Barcelona', 41.57, 2.2611, 4.657);
INSERT INTO f1_circuits VALUES ('silverstone', 'Silverstone Circuit', 'UK', 'Silverstone', 52.0786, -1.0169, 5.891);
INSERT INTO f1_circuits VALUES ('monza', 'Autodromo Nazionale Monza', 'Italy', 'Monza', 45.6156, 9.2811, 5.793);
INSERT INTO f1_circuits VALUES ('spa', 'Circuit de Spa-Francorchamps', 'Belgium', 'Spa', 50.4372, 5.9714, 7.004);

COMMIT;

-- 5. VISTAS ÚTILES PARA DEMOS
-- ============================================

-- Vista de clasificación general
CREATE OR REPLACE VIEW v_championship_standings AS
SELECT 
    d.driver_code,
    d.full_name,
    t.team_name,
    SUM(r.points) as total_points,
    COUNT(CASE WHEN r.position = 1 THEN 1 END) as wins,
    COUNT(CASE WHEN r.position <= 3 THEN 1 END) as podiums
FROM f1_drivers d
JOIN f1_teams t ON d.team_id = t.team_id
LEFT JOIN f1_results r ON d.driver_code = r.driver_code
GROUP BY d.driver_code, d.full_name, t.team_name
ORDER BY total_points DESC;

-- Vista de mejores vueltas por sesión
CREATE OR REPLACE VIEW v_fastest_laps AS
SELECT 
    s.gp_name,
    s.season_year,
    s.session_type,
    l.driver_code,
    l.lap_number,
    l.lap_time_seconds,
    l.compound
FROM f1_laps l
JOIN f1_sessions s ON l.session_id = s.session_id
WHERE l.lap_time_seconds = (
    SELECT MIN(lap_time_seconds) 
    FROM f1_laps l2 
    WHERE l2.session_id = l.session_id
);

-- Vista de análisis de telemetría por piloto
CREATE OR REPLACE VIEW v_telemetry_summary AS
SELECT 
    s.gp_name,
    t.driver_code,
    t.lap_number,
    MAX(t.speed_kmh) as max_speed,
    ROUND(AVG(t.speed_kmh), 2) as avg_speed,
    ROUND(AVG(t.throttle_pct), 2) as avg_throttle,
    COUNT(*) as data_points
FROM f1_telemetry t
JOIN f1_sessions s ON t.session_id = s.session_id
GROUP BY s.gp_name, t.driver_code, t.lap_number;

-- 6. PROCEDIMIENTO PARA COMPARAR PILOTOS
-- ============================================

CREATE OR REPLACE PROCEDURE compare_drivers(
    p_session_id IN NUMBER,
    p_driver1 IN VARCHAR2,
    p_driver2 IN VARCHAR2,
    p_cursor OUT SYS_REFCURSOR
) AS
BEGIN
    OPEN p_cursor FOR
    SELECT 
        t1.distance_m,
        t1.speed_kmh as speed_driver1,
        t2.speed_kmh as speed_driver2,
        t1.speed_kmh - t2.speed_kmh as speed_diff,
        t1.throttle_pct as throttle_driver1,
        t2.throttle_pct as throttle_driver2,
        t1.brake as brake_driver1,
        t2.brake as brake_driver2,
        t1.gear as gear_driver1,
        t2.gear as gear_driver2
    FROM f1_telemetry t1
    JOIN f1_telemetry t2 ON t1.distance_m = t2.distance_m 
                         AND t1.session_id = t2.session_id
    WHERE t1.session_id = p_session_id
      AND t1.driver_code = p_driver1
      AND t2.driver_code = p_driver2
    ORDER BY t1.distance_m;
END;
/

COMMIT;

-- 7. VERIFICAR INSTALACIÓN
-- ============================================

SELECT 'Equipos: ' || COUNT(*) as info FROM f1_teams
UNION ALL
SELECT 'Pilotos: ' || COUNT(*) FROM f1_drivers
UNION ALL
SELECT 'Circuitos: ' || COUNT(*) FROM f1_circuits;

-- ============================================
-- ✅ SETUP COMPLETADO
-- Ahora ejecuta el script Python para cargar datos reales
-- ============================================
