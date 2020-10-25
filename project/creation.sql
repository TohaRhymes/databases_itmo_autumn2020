CREATE TABLE pathogens
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(80) NOT NULL,
    type       VARCHAR(80) NOT NULL,
    action     VARCHAR(80) NOT NULL,
    antibiotic VARCHAR(80) NOT NULL
);
CREATE TABLE diseases
(
    id          SERIAL PRIMARY KEY,
    pathogen_id SERIAL
        CONSTRAINT fk_pathogens_id REFERENCES pathogens (id),
    mortality   DECIMAL NOT NULL
        DEFAULT 0 CHECK ( mortality >= 0 and mortality <= 1 )
);
CREATE TABLE companies
(
    id                    SERIAL PRIMARY KEY,
    name                  VARCHAR(80) UNIQUE NOT NULL,
    specialization        VARCHAR(80)        NOT NULL,
    share_stock_existence BOOLEAN            NOT NULL
);
CREATE TABLE company_info
(
    id                           SERIAL PRIMARY KEY,
    company_id                   SERIAL
        CONSTRAINT fk_companies_id REFERENCES companies (id),
    market_cap                   DECIMAL,
    net_profit_margin_pct_annual DECIMAL
);
CREATE TABLE drugs
(
    id               SERIAL PRIMARY KEY,
    active_substance VARCHAR(80) UNIQUE NOT NULL,
    homeopathy       BOOLEAN            NOT NULL,
    drugs_group      VARCHAR(80)        NOT NULL
);
CREATE TABLE poisons
(
    id                    SERIAL PRIMARY KEY,
    active_substance      VARCHAR(80) UNIQUE NOT NULL,
    poison_type_by_action VARCHAR(80)        NOT NULL,
    poison_type_by_origin VARCHAR(80)        NOT NULL,
    mortality             DECIMAL            NOT NULL
        DEFAULT 0 CHECK ( mortality >= 0 and mortality <= 1 )
);

CREATE TABLE development
(
    id            SERIAL PRIMARY KEY,
    company_name  VARCHAR(80)
        CONSTRAINT fk_companies_name
            REFERENCES companies (name) NOT NULL,
    pathogen_id   SERIAL
        CONSTRAINT fk_pathogens_id
            REFERENCES pathogens (id)   NOT NULL,
    testing_stage VARCHAR(80)           NOT NULL,
    success       VARCHAR(80)           NOT NULL
);
CREATE TABLE patents
(
    patent_id    SERIAL PRIMARY KEY,
    distribution VARCHAR(80) NOT NULL
);
CREATE TABLE trademarks
(
    id               SERIAL PRIMARY KEY,
    name             VARCHAR(80) UNIQUE           NOT NULL,
    active_substance VARCHAR(80)
        CONSTRAINT fk_drugs_active_substance
            REFERENCES drugs (active_substance),
    company_name     VARCHAR(80)
        CONSTRAINT fk_companies_name
            REFERENCES companies (name)           NOT NULL,
    doze             DECIMAL                      NOT NULL,
    avg_price        DECIMAL                      NOT NULL,
    patent_id        SERIAL
        CONSTRAINT fk_patents_patent_id
            REFERENCES patents (patent_id) UNIQUE NOT NULL
);
CREATE TABLE pharmacies
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(80) NOT NULL
);
CREATE TABLE stock
(
    id           SERIAL PRIMARY KEY,
    pharmacy_id  SERIAL
        CONSTRAINT fk_pharmacy_id REFERENCES pharmacies (id),
    trademark_id SERIAL
        CONSTRAINT fk_trademarks_id REFERENCES trademarks (id),
    availability VARCHAR(80) --in stock, pharmacy_id, null
);
CREATE TABLE ethnoscience
(
    id     SERIAL PRIMARY KEY,
    name   VARCHAR(80) NOT NULL,
    origin VARCHAR(80) NOT NULL
);
CREATE TABLE drugs_to_diseases
(
    drugs_id   SERIAL
        CONSTRAINT fk_drugs_id REFERENCES drugs (id),
    disease_id SERIAL
        CONSTRAINT fk_diseases_id REFERENCES diseases (id)
);
CREATE TABLE drugs_to_poisons
(
    drugs_id  SERIAL
        CONSTRAINT fk_drugs_id REFERENCES drugs (id),
    poison_id SERIAL
        CONSTRAINT fk_poisons_id REFERENCES poisons (id)
);
CREATE TABLE ethnoscience_to_diseases
(
    ethnoscience_id SERIAL
        CONSTRAINT fk_ethnoscience_id REFERENCES ethnoscience (id),
    disease_id      SERIAL
        CONSTRAINT fk_diseases_id REFERENCES diseases (id)
);
