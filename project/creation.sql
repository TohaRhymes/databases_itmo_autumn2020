CREATE TYPE pathogen_type AS ENUM ('virus', 'bacterium', 'protozoan', 'prion', 'viroid', 'fungus', 'small animal');
CREATE TYPE drugs_groups AS ENUM ('Group A (prohibited substances)', 'Group B (limited turnover)', 'Group C (free circulation)');
CREATE TYPE poison_origin AS ENUM ('nature', 'chemicals');
CREATE TYPE development_stage AS ENUM ('Preclinical phase', 'Phase 0', 'Phase I', 'Phase II', 'Phase III', 'Phase IV');
CREATE TYPE stock_availability AS ENUM ('available', 'in other shops', 'ended');


CREATE TABLE pathogens
(
    id     SERIAL PRIMARY KEY,
    name   VARCHAR(80)   NOT NULL,
    type   pathogen_type NOT NULL,
    action VARCHAR(80)   NOT NULL
);
CREATE TABLE diseases
(
    id          SERIAL PRIMARY KEY,
    pathogen_id INTEGER
        CONSTRAINT fk_pathogens_id REFERENCES pathogens (id) ON DELETE CASCADE,
    mortality   DECIMAL NOT NULL
        DEFAULT 0 CHECK ( mortality >= 0 and mortality <= 1 )
);
CREATE TABLE companies
(
    id                           SERIAL PRIMARY KEY,
    name                         VARCHAR(80) UNIQUE NOT NULL,
    specialization               VARCHAR(80)        NOT NULL,
    share_stock_existence        BOOLEAN            NOT NULL,
    market_cap                   DECIMAL CHECK ( market_cap >= 0 ),
    net_profit_margin_pct_annual DECIMAL CHECK ( net_profit_margin_pct_annual >= 0 ) -- ЧЕ это?))))
);
CREATE TABLE company_info
(
    id                           SERIAL PRIMARY KEY,
    company_id                   INTEGER
        CONSTRAINT fk_companies_id REFERENCES companies (id) ON DELETE CASCADE
        UNIQUE NOT NULL,
    restore_date                 TIMESTAMP,
    market_cap                   DECIMAL CHECK ( market_cap >= 0 ),
    net_profit_margin_pct_annual DECIMAL CHECK ( net_profit_margin_pct_annual >= 0 )
);
CREATE TABLE drugs
(
    id               SERIAL PRIMARY KEY,
    active_substance VARCHAR(80) UNIQUE NOT NULL,
    homeopathy       BOOLEAN            NOT NULL
        DEFAULT false,
    drugs_group      drugs_groups       NOT NULL
);
CREATE TABLE poisons
(
    id               SERIAL PRIMARY KEY,
    active_substance VARCHAR(80) UNIQUE NOT NULL,
    type_by_action   VARCHAR(80)        NOT NULL,
    type_by_origin   poison_origin,
    mortality        DECIMAL            NOT NULL
        DEFAULT 0 CHECK ( mortality >= 0 and mortality <= 1 )
);

CREATE TABLE development
(
    id            SERIAL PRIMARY KEY,
    company_id    INTEGER
        CONSTRAINT fk_companies_id
            REFERENCES companies (id) ON DELETE CASCADE NOT NULL,
    pathogen_id   INTEGER
        CONSTRAINT fk_pathogens_id
            REFERENCES pathogens (id) ON DELETE CASCADE NOT NULL,
    testing_stage development_stage                     NOT NULL,
    failed        BOOLEAN                               NOT NULL DEFAULT false
);
CREATE TABLE patents
(
    patent_id    SERIAL PRIMARY KEY,
    distribution VARCHAR(80) NOT NULL
);
CREATE TABLE trademarks
(
    id            SERIAL PRIMARY KEY,
    name          VARCHAR(80) UNIQUE NOT NULL,
    doze          DECIMAL            NOT NULL CHECK ( doze > 0 ),
    release_price DECIMAL            NOT NULL check ( release_price > 0 ),
    drug_id       INTEGER
        CONSTRAINT fk_drugs_id
            REFERENCES drugs (id) ON DELETE CASCADE,
    company_id    INTEGER
        CONSTRAINT fk_companies_id
            REFERENCES companies (id) ON DELETE CASCADE
                                     NOT NULL,
    patent_id     INTEGER
        CONSTRAINT fk_patents_patent_id
            REFERENCES patents (patent_id) ON DELETE CASCADE
        UNIQUE
);
CREATE TABLE pharmacies
(
    id         SERIAL PRIMARY KEY,
    name       VARCHAR(80) NOT NULL,
    price_mul  DECIMAL     NOT NULL CHECK ( price_mul >= 1 ),
    price_plus DECIMAL     NOT NULL CHECK ( price_plus >= 0 )
);

CREATE TABLE stock
(
    id           SERIAL PRIMARY KEY,
    pharmacy_id  INTEGER
        CONSTRAINT fk_pharmacy_id REFERENCES pharmacies (id) ON DELETE CASCADE
                                   NOT NULL,
    trademark_id INTEGER
        CONSTRAINT fk_trademarks_id REFERENCES trademarks (id) ON DELETE CASCADE
                                   NOT NULL,
    availability stock_availability,
    amount       INTEGER default 0 NOT NULL CHECK ( amount >= 0 ),
    price        DECIMAL           NOT NULL check ( price > 0 )
);
CREATE TABLE ethnoscience
(
    id     SERIAL PRIMARY KEY,
    name   VARCHAR(80) NOT NULL,
    origin VARCHAR(80) NOT NULL
);
CREATE TABLE drugs_to_diseases
(
    drugs_id   INTEGER
        CONSTRAINT fk_drugs_id REFERENCES drugs (id) ON DELETE CASCADE
        NOT NULL,
    disease_id INTEGER
        CONSTRAINT fk_diseases_id REFERENCES diseases (id) ON DELETE CASCADE
        NOT NULL
);
CREATE TABLE drugs_to_poisons
(
    drugs_id  INTEGER
        CONSTRAINT fk_drugs_id REFERENCES drugs (id) ON DELETE CASCADE
        NOT NULL,
    poison_id INTEGER
        CONSTRAINT fk_poisons_id REFERENCES poisons (id) ON DELETE CASCADE
        NOT NULL
);
CREATE TABLE ethnoscience_to_diseases
(
    ethnoscience_id INTEGER
        CONSTRAINT fk_ethnoscience_id REFERENCES ethnoscience (id) ON DELETE CASCADE
        NOT NULL,
    disease_id      INTEGER
        CONSTRAINT fk_diseases_id REFERENCES diseases (id) ON DELETE CASCADE
        NOT NULL
);
