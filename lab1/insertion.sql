INSERT INTO planetary_system (id, name, central_star)
VALUES (0, 'Солнечная система', 'Солнце');

INSERT INTO planetary_system (id, name, central_star)
VALUES (1, 'Альфас системс', 'Альфа центавра');

INSERT INTO bodies (id, name, planetary_system_id, type, chemicals)
VALUES (0, 'Церера', 0, 'карликовая планета', NULL);

INSERT INTO bodies (id, name, planetary_system_id, type, chemicals)
VALUES (1, 'Пояс Кеплера', 0, 'Область', NULL);

INSERT INTO planet (id, name, planetary_system_id, mass, radius, orbital_radius, chemicals)
VALUES (0, 'Земля', 0, 5.972E24, 6000, NULL, 'КАМЕНЬ');

INSERT INTO planet (id, name, planetary_system_id, mass, radius, orbital_radius, chemicals)
VALUES (1, 'Сатурн', 0, NULL, NULL, NULL, 'ГАЗ');

INSERT INTO planet (id, name, planetary_system_id, mass, radius, orbital_radius, chemicals)
VALUES (2, 'Уникус', 1, NULL, NULL, NULL, 'ЭФИР');

INSERT INTO satellite (id, name, planet_id)
VALUES (0, 'ЛУНА', 1);

INSERT INTO river (id, name, type)
VALUES (0, 'КРЭЙЗИ', 'Электрическая');

INSERT INTO river (id, name, type)
VALUES (1, 'МЕГА', 'Водяная');

INSERT INTO river_to_planet (river_id, planet_id)
VALUES (0, 0);

INSERT INTO river_to_planet (river_id, planet_id)
VALUES (0, 1);

INSERT INTO river_to_planet (river_id, planet_id)
VALUES (1, 1);

INSERT INTO river_to_planet (river_id, planet_id)
VALUES (1, 2);

INSERT INTO starship (id, name, velocity)
VALUES (0, 'Карл Маркс', 10000);

INSERT INTO starship (id, name, velocity)
VALUES (1, 'Викинг', 15000);

INSERT INTO starship (id, name, velocity)
VALUES (2, 'Принцесса Виктория', 5000);

INSERT INTO river_to_starship (river_id, starship_id)
VALUES (0, 1);

INSERT INTO river_to_starship (river_id, starship_id)
VALUES (0, 2);

INSERT INTO river_to_starship (river_id, starship_id)
VALUES (1, 0);