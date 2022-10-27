-- kill other connections
SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE pg_stat_activity.datname = 'my_pumps' AND pid <> pg_backend_pid();


-- connect via psql
\c my_pumps

-- (re)create the tables
DROP TABLE IF EXISTS vendors CASCADE;
DROP TABLE IF EXISTS pumps CASCADE;
DROP TABLE IF EXISTS pump_models CASCADE;
DROP TABLE IF EXISTS vendors_pump_models CASCADE;
DROP TABLE IF EXISTS flow_sensors CASCADE;
DROP TABLE IF EXISTS motors CASCADE;
DROP TABLE IF EXISTS speed_sensors CASCADE;

-- database configuration
SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET default_tablespace = '';
SET default_with_oids = false;

-- Create tables

CREATE TABLE vendors (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);

CREATE TABLE pump_models(
    id SERIAL PRIMARY KEY,
    make TEXT NOT NULL,
    model TEXT NOT NULL,
    max_flow REAL
);

CREATE TABLE pumps(
    id SERIAL PRIMARY KEY,
    tag_name TEXT NOT NULL UNIQUE,
    model_id INT NOT NULL
);

CREATE TABLE vendors_pump_models(
    vendor_id INT NOT NULL,
    model_id INT NOT NULL,
    pump_price REAL NOT NULL,
    PRIMARY KEY (vendor_id, model_id)
);

CREATE TABLE motors(
    id SERIAL PRIMARY KEY,
    tag_name TEXT NOT NULL UNIQUE,
    model TEXT,
    max_speed REAL,
    pump_id INT NOT NULL UNIQUE
);

CREATE TABLE flow_sensors(
    id SERIAL PRIMARY KEY,
    tag_name TEXT NOT NULL UNIQUE,
    model TEXT,
    min_range REAL,
    max_range REAL,
    current_value REAL NOT NULL,
    pump_id INT
);

CREATE TABLE speed_sensors(
    id SERIAL PRIMARY KEY,
    tag_name TEXT NOT NULL UNIQUE,
    type TEXT,
    current_value REAL NOT NULL,
    motor_id INT
);

-- add FKs

ALTER TABLE vendors_pump_models
ADD CONSTRAINT fk_vendors_pump_models_vendors
FOREIGN KEY (vendor_id)
REFERENCES vendors;

ALTER TABLE vendors_pump_models
ADD CONSTRAINT fk_vendors_pump_models_pumps
FOREIGN KEY (model_id)
REFERENCES pump_models;

ALTER TABLE pumps
ADD CONSTRAINT fk_pumps_pump_models
FOREIGN KEY (model_id)
REFERENCES pump_models;

ALTER TABLE flow_sensors
ADD CONSTRAINT fk_flow_sensors_pumps
FOREIGN KEY (pump_id)
REFERENCES pumps;

ALTER TABLE speed_sensors
ADD CONSTRAINT fk_speed_sensors_motors
FOREIGN KEY (motor_id)
REFERENCES motors;

ALTER TABLE motors
ADD CONSTRAINT fk_motors_pumps
FOREIGN KEY (pump_id)
REFERENCES pumps;

--insert vendor data

INSERT INTO vendors (name)
VALUES ('24hr Supply');

INSERT INTO vendors (name)
VALUES ('Pump Products');

INSERT INTO vendors (name)
VALUES ('Supply House');


--insert pump model data

INSERT INTO pump_models (make, model, max_flow)
VALUES ('Sulzer', 'CZ 150-251', 420);

INSERT INTO pump_models (make, model, max_flow)
VALUES ('Goulds', 'WS5032D4', 550);

INSERT INTO pump_models (make, model, max_flow)
VALUES ('Grundfos', '59896343', 17);

--insert pumps data

INSERT INTO pumps (tag_name, model_id)
VALUES ('40P1001A', 
    (SELECT(id) FROM pump_models p WHERE p.model = 'CZ 150-251') 
    );

INSERT INTO pumps (tag_name, model_id)
VALUES ('27P2004', 
    (SELECT(id) FROM pump_models p WHERE p.model = 'WS5032D4') 
    );
    
INSERT INTO pumps (tag_name, model_id)
VALUES ('63P2017A', 
    (SELECT(id) FROM pump_models p WHERE p.model = '59896343') 
    );

--insert vendors_pump_models data

INSERT INTO vendors_pump_models (vendor_id, model_id, pump_price)
VALUES (
    (SELECT(id) FROM vendors WHERE vendors.name = '24hr Supply'),
    (SELECT(id) FROM pump_models WHERE pump_models.model = 'CZ 150-251'),
    1600
);

INSERT INTO vendors_pump_models (vendor_id, model_id, pump_price)
VALUES (
    (SELECT(id) FROM vendors WHERE vendors.name = '24hr Supply'),
    (SELECT(id) FROM pump_models WHERE pump_models.model = 'WS5032D4'),
    2200
);

INSERT INTO vendors_pump_models (vendor_id, model_id, pump_price)
VALUES (
    (SELECT(id) FROM vendors WHERE vendors.name = 'Pump Products'),
    (SELECT(id) FROM pump_models WHERE pump_models.model = 'CZ 150-251'),
    1650
);

INSERT INTO vendors_pump_models (vendor_id, model_id, pump_price)
VALUES (
    (SELECT(id) FROM vendors WHERE vendors.name = 'Pump Products'),
    (SELECT(id) FROM pump_models WHERE pump_models.model = '59896343'),
    1600
);

INSERT INTO vendors_pump_models (vendor_id, model_id, pump_price)
VALUES (
    (SELECT(id) FROM vendors WHERE vendors.name = 'Supply House'),
    (SELECT(id) FROM pump_models WHERE pump_models.model = '59896343'),
    1800
);

INSERT INTO vendors_pump_models (vendor_id, model_id, pump_price)
VALUES (
    (SELECT(id) FROM vendors WHERE vendors.name = 'Supply House'),
    (SELECT(id) FROM pump_models WHERE pump_models.model = 'CZ 150-251'),
    1500
);

-- insert flow sensor data
INSERT INTO flow_sensors (tag_name, model, min_range, max_range, current_value, pump_id)
VALUES (
    '40FT1001A', 'OMEGA FTB600B', 0, 30, 15,
    (SELECT(id) FROM pumps WHERE pumps.tag_name = '40P1001A')
);

INSERT INTO flow_sensors (tag_name, model, min_range, max_range, current_value, pump_id)
VALUES (
    '40FT1001B', 'OMEGA FTB600B', 0, 30, 15,
    (SELECT(id) FROM pumps WHERE pumps.tag_name = '40P1001A')
);

INSERT INTO flow_sensors (tag_name, model, current_value, pump_id)
VALUES (
    '27FT2004', 'Fill-Rite TT10AN', 25,
    (SELECT(id) FROM pumps WHERE pumps.tag_name = '27P2004')
);

INSERT INTO flow_sensors (tag_name, min_range, max_range, current_value, pump_id)
VALUES (
    '63FT2017A', 0, 1920, 25,
    (SELECT(id) FROM pumps WHERE pumps.tag_name = '63P2017A')
);

-- insert motor data

INSERT INTO motors (tag_name, model, max_speed, pump_id)
VALUES('40M1001A', 'AMT 2851-96', 900,
    (SELECT(id) FROM pumps WHERE pumps.tag_name = '40P1001A')
);

INSERT INTO motors (tag_name, model, max_speed, pump_id)
VALUES('27M2004', 'AMT 2851-96', 1800,
    (SELECT(id) FROM pumps WHERE pumps.tag_name = '27P2004')
);

INSERT INTO motors (tag_name, model, max_speed, pump_id)
VALUES('63M2017A', 'MARCH MDXT-3', 3600,
    (SELECT(id) FROM pumps WHERE pumps.tag_name = '63P2017A')
);

-- insert speed sensor data

INSERT INTO speed_sensors (tag_name, type, current_value, motor_id)
VALUES ('27ST2004', 'Photo', 1780, 
    (SELECT(id) FROM motors WHERE motors.tag_name = '27M2004')
);

INSERT INTO speed_sensors (tag_name, type, current_value, motor_id)
VALUES ('63ST2017A', 'Magnetic', 3561, 
    (SELECT(id) FROM motors WHERE motors.tag_name = '63M2017A')
);

INSERT INTO speed_sensors (tag_name, type, current_value, motor_id)
VALUES ('63ST2017B', 'Magnetic', 3558, 
    (SELECT(id) FROM motors WHERE motors.tag_name = '63M2017A')
);
