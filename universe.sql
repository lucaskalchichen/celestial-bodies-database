

CREATE DATABASE universe;

-- Step 2: Connect to the database
\c universe


-- Create galaxy table
CREATE TABLE galaxy (
    galaxy_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    type TEXT NOT NULL,
    number_of_stars INT NOT NULL CHECK (number_of_stars >= 0),
    age_in_billions_of_years NUMERIC NOT NULL CHECK (age_in_billions_of_years >= 0),
    habitable BOOLEAN NOT NULL
);

-- Create star table
CREATE TABLE star (
    star_id SERIAL PRIMARY KEY,
    galaxy_id INT REFERENCES galaxy(galaxy_id) NOT NULL,
    name VARCHAR(255) UNIQUE NOT NULL,
    type TEXT NOT NULL,
    age_in_millions_of_years INT NOT NULL CHECK (age_in_millions_of_years >= 0),
    has_planets BOOLEAN NOT NULL
);

-- Create planet table
CREATE TABLE planet (
    planet_id SERIAL PRIMARY KEY,
    star_id INT REFERENCES star(star_id) NOT NULL,
    name VARCHAR(255) UNIQUE NOT NULL,
    type TEXT NOT NULL,
    mass NUMERIC CHECK (mass >= 0),
    habitable BOOLEAN NOT NULL
);

-- Create moon table
CREATE TABLE moon (
    moon_id SERIAL PRIMARY KEY,
    planet_id INT REFERENCES planet(planet_id) NOT NULL,
    name VARCHAR(255) UNIQUE NOT NULL,
    size INT CHECK (size >= 0),
    has_atmosphere BOOLEAN NOT NULL,
    distance_from_planet NUMERIC CHECK (distance_from_planet >= 0)
);

-- Create space_station table
CREATE TABLE station (
    station_id SERIAL PRIMARY KEY,
    name VARCHAR(255) UNIQUE NOT NULL,
    operational BOOLEAN NOT NULL,
    capacity INT NOT NULL CHECK (capacity >= 0),
    distance_from_earth NUMERIC CHECK (distance_from_earth >= 0)
);

-- Insert into galaxy
INSERT INTO galaxy (name, type, number_of_stars, age_in_billions_of_years, habitable) VALUES
('Milky Way', 'Spiral', 10000, 13.51, TRUE),
('Andromeda', 'Spiral', 100000, 10.0, FALSE),
('Triangulum', 'Spiral', 400, 10.3, FALSE),
('Whirlpool', 'Spiral', 1000, 6.0, FALSE),
('Large Magellanic Cloud', 'Dwarf', 300, 1.0, FALSE),
('Small Magellanic Cloud', 'Dwarf', 7, 1.0, FALSE);

-- Insert into star
INSERT INTO star (galaxy_id, name, type, age_in_millions_of_years, has_planets) VALUES
(1, 'Sun', 'G-type', 4600, TRUE),
(1, 'Alpha Centauri', 'G-type', 5500, TRUE),
(1, 'Sirius', 'A-type', 242, TRUE),
(2, 'Betelgeuse', 'M-type', 8700, TRUE),
(3, 'Proxima Centauri', 'M-type', 4800, TRUE),
(4, 'Vega', 'A-type', 455, TRUE);

-- Insert into planet
INSERT INTO planet (star_id, name, type, mass, habitable) VALUES
(1, 'Earth', 'Terrestrial', 1.0, TRUE),
(1, 'Mars', 'Terrestrial', 0.107, FALSE),
(1, 'Jupiter', 'Gas Giant', 317.8, FALSE),
(2, 'Proxima b', 'Terrestrial', 1.27, TRUE),
(3, 'Kepler-442b', 'Terrestrial', 2.36, TRUE),
(4, 'Rigel b', 'Gas Giant', 432.2, FALSE),
(5, 'Kepler-22b', 'Super-Earth', 36, TRUE),
(5, 'Kepler-69c', 'Super-Earth', 5.7, TRUE),
(5, 'Gliese 581c', 'Terrestrial', 5.6, TRUE),
(5, 'Gliese 581d', 'Terrestrial', 6.4, TRUE),
(6, 'Tau Ceti e', 'Terrestrial', 4.3, TRUE),
(6, 'Tau Ceti f', 'Terrestrial', 6.6, TRUE);

-- Insert into moon
INSERT INTO moon (planet_id, name, size, has_atmosphere, distance_from_planet) VALUES
(1, 'Moon', 3474, FALSE, 384400),
(3, 'Europa', 3121, FALSE, 671100),
(3, 'Io', 3643, FALSE, 421700),
(3, 'Ganymede', 5268, TRUE, 1070400),
(3, 'Callisto', 4821, FALSE, 1882700),
(4, 'Proxima Centauri b Moon', 2500, FALSE, 150000),
(5, 'Kepler-442b Moon', 3500, FALSE, 100000),
(6, 'Rigel b Moon', 1000, FALSE, 50000),
(7, 'Kepler-22b Moon', 3200, FALSE, 90000),
(8, 'Kepler-69c Moon', 3000, FALSE, 95000),
(9, 'Gliese 581c Moon', 2500, FALSE, 70000),
(10, 'Gliese 581d Moon', 2000, FALSE, 80000),
(11, 'Tau Ceti e Moon', 1500, FALSE, 120000),
(12, 'Tau Ceti f Moon', 1400, FALSE, 130000),
(1, 'Luna 2', 1200, FALSE, 350000),
(1, 'Luna 3', 1300, FALSE, 350500),
(2, 'Mars Moon 1', 1000, FALSE, 50000),
(2, 'Mars Moon 2', 1100, FALSE, 50500),
(2, 'Mars Moon 3', 1050, FALSE, 51000),
(3, 'Europa 2', 3100, FALSE, 670500);

-- Insert into space_station
INSERT INTO station (name, operational, capacity, distance_from_earth) VALUES
('ISS', TRUE, 6, 408),
('Tiangong', TRUE, 3, 370),
('Mir', FALSE, 6, 390);
