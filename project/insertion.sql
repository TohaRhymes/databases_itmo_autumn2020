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

INSERT INTO ethnoscience_to_diseases VALUES (2, 1);
INSERT INTO ethnoscience_to_diseases VALUES (1, 3);


INSERT INTO companies(name, specialization) VALUES('RosVitro', 'viruses');
UPDATE companies SET (market_cap, net_profit_margin_pct_annual) = (10, 100) where name='RosVitro';
UPDATE companies SET (name, specialization, market_cap, net_profit_margin_pct_annual)=('RosVitro', 'viruses', 50, 34);
INSERT INTO companies(name, specialization, market_cap, net_profit_margin_pct_annual) VALUES('Grindex', 'synthetic', 1000, 2130);


INSERT INTO development(company_id,pathogen_id, testing_stage, failed) VALUES(1, 2, 'Phase III', true);
INSERT INTO development(company_id,pathogen_id, testing_stage, failed) VALUES(1, 2, 'Preclinical phase', false);
INSERT INTO development(company_id,pathogen_id, testing_stage, failed) VALUES(2, 1, 'Phase IV', false);

INSERT INTO patents(distribution, start_date) VALUES('free-to-use', '2010-1-1');
INSERT INTO patents(distribution) VALUES('restricted-to-use');
INSERT INTO patents(distribution, start_date) VALUES('free-to-use', '2012-12-10');
INSERT INTO patents(distribution, start_date) VALUES('free-to-use', '2019-05-04');

INSERT INTO pharmacies(name, price_mul, price_plus) VALUES ('Stolichki', 1.05, 3);
INSERT INTO pharmacies(name, price_mul, price_plus) VALUES ('Stolichki-2', 1.15, 3);
INSERT INTO pharmacies(name, price_mul, price_plus) VALUES ('Stolichki-3', 1.0, 15);

INSERT INTO trademarks(name, doze, release_price, drug_id, company_id, patent_id) VALUES ('Anaferon', 3, 158, 2, 1, 1);
INSERT INTO trademarks(name, doze, release_price, drug_id, company_id, patent_id) VALUES ('Anaferon-beta', 3, 358, 2, 2, 4);
INSERT INTO trademarks(name, doze, release_price, drug_id, company_id, patent_id) VALUES ('prostaden', 200, 35, 1, 2, 2);


INSERT INTO stock(pharmacy_id, trademark_id, availability) VALUES (1, 1, 100);
INSERT INTO stock(pharmacy_id, trademark_id) VALUES (1, 2);
INSERT INTO stock(pharmacy_id, trademark_id, availability) VALUES (3, 1, 0);

