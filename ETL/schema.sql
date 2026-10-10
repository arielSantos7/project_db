CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE vehicle_kind (
    name              text,
    vehicle_kind_id   bigint PRIMARY KEY
);

CREATE TABLE fuel_type (
    name              text,
    fuel_type_id      bigint PRIMARY KEY
);

CREATE TABLE vehicle_status (
    vehicle_status_id bigint PRIMARY KEY,
    name              text
);

CREATE TABLE vehicle_type (
    vehicle_type_id   bigint PRIMARY KEY,
    vehicle_kind_id   bigint REFERENCES vehicle_kind (vehicle_kind_id),
    fuel_type_id      bigint REFERENCES fuel_type (fuel_type_id),
    emissions_rating  double precision,
    created_at        timestamp
);

CREATE TABLE vehicle (
    vehicle_id        bigint PRIMARY KEY,
    vehicle_type_id   bigint REFERENCES vehicle_type (vehicle_type_id),
    vehicle_status_id bigint REFERENCES vehicle_status (vehicle_status_id),
    plate_number      text,
    make              text,
    model             text,
    year              bigint,
    created_at        timestamp
);

CREATE TABLE driver (
    driver_id         bigint PRIMARY KEY,
    first_name        text,
    last_name         text,
    license_number    text,
    hired_at          timestamp
);

CREATE TABLE vehicle_assignment (
    assignment_id     bigint PRIMARY KEY,
    vehicle_id        bigint REFERENCES vehicle (vehicle_id),
    driver_id         bigint REFERENCES driver (driver_id),
    assigned_from     timestamp,
    assigned_to       timestamp
);

CREATE TABLE location_ping (
    ping_id           bigint PRIMARY KEY,
    vehicle_id        bigint REFERENCES vehicle (vehicle_id),
    ts                timestamp,
    geom              geometry(Point, 4326),
    speed_kph         double precision,
    heading_deg       double precision
);

CREATE TABLE trip (
    trip_id           bigint PRIMARY KEY,
    vehicle_id        bigint REFERENCES vehicle (vehicle_id),
    start_ts          timestamp,
    end_ts            timestamp,
    start_geom        geometry(Point, 4326),
    end_geom          geometry(Point, 4326),
    distance_km       double precision
);

CREATE TABLE road_segment (
    road_id           bigint PRIMARY KEY,
    name              text,
    speed_limit_kph   bigint,
    geom              geometry(LineString, 4326),
    created_at        timestamp,
    is_oneway         boolean,
    direction         text
);

CREATE TABLE parking_area (
    parking_area_id   bigint PRIMARY KEY,
    name              text,
    capacity          bigint,
    geom              geometry(Polygon, 4326),
    created_at        timestamp
);