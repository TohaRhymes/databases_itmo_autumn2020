INSERT INTO pathogens(name, type, action) VALUES ('cov2019', 'virus', 'infect lungs');
INSERT INTO pathogens(name, type, action) VALUES ('Treponema pallidum', 'bacterium', 'violate skeen');

INSERT INTO diseases(pathogen_id, name, mortality) VALUES (1, 'loss of smell', 0.001);
INSERT INTO diseases(pathogen_id, name, mortality) VALUES (1, 'coma', 0.95);
INSERT INTO diseases(pathogen_id, name, mortality) VALUES (2, 'Syphilis', 0.23);

INSERT INTO poisons(active_substance, type_by_action, type_by_origin, mortality) VALUES ('Arsenicum', 'intoxicate brains', 'synthetic', 0.74);

INSERT INTO ethnoscience(name, origin) VALUES ('подышать над картошкой', 'картофель');
INSERT INTO ethnoscience(name, origin) VALUES ('чай c ромашкой', 'ромашка');
INSERT INTO ethnoscience(name, origin) VALUES ('погадать на картах Таро', 'потусторонние силы');

INSERT INTO drugs(active_substance, homeopathy, drugs_group) VALUES ('Echinacea purpurea D3',true,'Group C (free circulation)');
INSERT INTO drugs(active_substance, homeopathy, drugs_group) VALUES ('interferon',false,'Group B (limited turnover)');
INSERT INTO drugs(active_substance, homeopathy, drugs_group) VALUES ('Phenol',false,'Group A (prohibited substances)');


INSERT INTO drugs_to_poisons VALUES (1, 1);
INSERT INTO drugs_to_poisons VALUES (2, 1);

INSERT INTO drugs_to_diseases VALUES (2, 1);
INSERT INTO drugs_to_diseases VALUES (3, 2);
INSERT INTO drugs_to_diseases VALUES (2, 1);

INSERT INTO ethnoscience_to_diseases VALUES (2, 1);
INSERT INTO ethnoscience_to_diseases VALUES (1, 3);

