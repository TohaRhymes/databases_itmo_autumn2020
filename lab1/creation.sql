CREATE TABLE planetary_system
(
    id           SERIAL PRIMARY KEY,
    name         VARCHAR(80) UNIQUE NOT NULL,
    central_star VARCHAR(80)        NOT NULL
);

CREATE TABLE planet
(
    id                  SERIAL PRIMARY KEY,
    name                VARCHAR(80)                                        NOT NULL,
    planetary_system_id SERIAL
        CONSTRAINT fk_planetary_system_id REFERENCES planetary_system (id) NOT NULL,
    mass                DECIMAL CHECK ( mass >= 0 ),
    radius              DECIMAL CHECK ( radius >= 0 ),
    orbital_radius      DECIMAL CHECK ( orbital_radius >= 0 ),
    chemicals           VARCHAR(80)

);

CREATE TABLE satellite
(
    id             SERIAL PRIMARY KEY,
    name           VARCHAR(80) NOT NULL,
    planet_id      SERIAL
        CONSTRAINT fk_planet_id REFERENCES planet (id),
    mass           DECIMAL CHECK ( mass >= 0 ),
    radius         DECIMAL CHECK ( radius >= 0 ),
    orbital_radius DECIMAL CHECK ( orbital_radius >= 0 ),
    chemicals      VARCHAR(80)
);

CREATE TABLE bodies
(
    id                  SERIAL PRIMARY KEY,
    name                VARCHAR(80)                                        NOT NULL,
    planetary_system_id SERIAL
        CONSTRAINT fk_planetary_system_id REFERENCES planetary_system (id) NOT NULL,
    type                VARCHAR(80),
    chemicals           VARCHAR(80)
);

CREATE TABLE river
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(80) NOT NULL,
    type VARCHAR(80)
);

CREATE TABLE river_to_planet
(
    river_id  SERIAL
        CONSTRAINT fk_river_id REFERENCES river (id)   NOT NULL,
    planet_id SERIAL
        CONSTRAINT fk_planet_id REFERENCES planet (id) NOT NULL
);

CREATE TABLE starship
(
    id       SERIAL PRIMARY KEY,
    name     VARCHAR(80) NOT NULL,
    velocity DECIMAL CHECK ( velocity >= 0 )
);

CREATE TABLE river_to_starship
(
    river_id    SERIAL
        CONSTRAINT fk_river_id REFERENCES river (id)       NOT NULL,
    starship_id SERIAL
        CONSTRAINT fk_starship_id REFERENCES starship (id) NOT NULL
);

