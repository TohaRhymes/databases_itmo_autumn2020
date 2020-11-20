from random import randint
import random
import string


def get_random_string(a, b):
    length = randint(a, b)
    letters = string.ascii_lowercase
    result_str = ''.join(random.choice(letters) for i in range(length))
    return result_str


def get_bool():
    return bool(randint(0, 1))


def make_many_to_many(length, first_reps, second_reps):
    cur_set = set()
    for _ in range(length):
        first_id = randint(1, first_reps)
        second_id = randint(1, second_reps)
        while (first_id, second_id) in cur_set:
            first_id = randint(1, first_reps)
            second_id = randint(1, second_reps)
        cur_set.add((first_id, second_id))
    return cur_set


def make_many_to_many_to_many(length, first_reps, second_reps, third_reps):
    cur_set = set()
    third_set = set()
    for _ in range(length):
        f_id = randint(1, first_reps)
        s_id = randint(1, second_reps)
        t_id = randint(1, third_reps)
        while (f_id, s_id, t_id) in cur_set:
            f_id = randint(1, first_reps)
            s_id = randint(1, second_reps)
            t_id = randint(1, third_reps)
        cur_set.add((f_id, s_id, t_id))
        third_set.add(t_id)
    return cur_set


class ArrayRandomGetter:
    def __init__(self, array):
        self.array = array
        self.n = len(array) - 1

    def __next__(self):
        return self.array[randint(0, self.n)]

    def __iter__(self):
        return self


script_name = 'generated_insertion.sql'
script = ''

# ENUM VALUES
pathogen_type_values = ['virus', 'bacterium', 'protozoan', 'prion', 'viroid', 'fungus', 'small animal']
drugs_groups_values = ['Group A (prohibited substances)', 'Group B (limited turnover)', 'Group C (free circulation)']
poison_origin_values = ['nature', 'chemicals', 'synthetic']
development_stage_values = ['Preclinical phase', 'Phase 0', 'Phase I', 'Phase II', 'Phase III', 'Phase IV']
patent_distribution_values = ['free-to-use', 'usage with some constraints', 'restricted-to-use']
# FOR RANDOM VALUES
pathogen_name_endings_values = ['ium', 'us', 'cokk', 'tronus', 'dedekus']
pathogen_action_verb_values = ['harm', 'dissolve', 'oxidize', 'destroy', 'infect', 'parasitize on',
                               'form connections in', 'intoxicate', 'interfere with processes in',
                               'start other processes in', 'violate the functions of', ]
pathogen_action_target_values = ['brains', 'head', 'legs', 'arms', 'brain', 'lips', 'trachea', 'fingernails',
                                 'testicles', 'bladder', 'fallopian tubes', 'ovaries', 'stomach', 'liver', 'spleen',
                                 'lungs', ]

disease_name_values = ['Ott\'\'s', 'Moor\'\'s', 'Alzgeimer\'\'s', 'Sheiduhen\'\'s', 'Toff\'\'s', 'Glottos\'\'s',
                       'Newton\'\'s',
                       "Morgen\'\'s", "Davydov\'\'s"]

poison_name_endings_values = ['um', 'ava', 'um', 'ava', 'um', 'ava', ' by T']

ethnoscience_verb_values = ['meditate on', 'sniff', 'eat', 'drink', 'break', 'cry on', 'look at', 'marry on']
ethnoscience_noun_values = ['potato', 'cards', 'tomato', 'stone', 'redlight', 'fire', 'paper', 'dirt']
ethnoscience_origin_values = ['granny', 'daddy', 'black magic', 'white magic', 'books', 'witcher', 'Yaga', 'Leshiy']

active_substance_ends_values = ['ea', 'on', 'ol', 'rol', 'off', 'ium', 'to', 'nat', 'an', 'id']
active_substance_beginnings_values = ['pheno', 'buto', 'alpha-', 'keno', 'amo', 'poly', 'oxy']

company_specialization_values = ['sequencing', 'viruses', 'retroviruses', 'alcohol', 'synthetic', 'chemicals',
                                 'natural',
                                 'vitamins']
company_names_values = ['silico', 'vitro', 'hemo', 'rhoto', 'ex', 'isk']

pharmacies_name_values = ['Stolichki', 'Nevis', "P and G", "S and F", "W#M", "Ozerki", "Rechki"]

trade_name_start_values = ["Mik", 'LEU', "Com", "Ros", "Hetero", "Anti"]
trade_name_end_values = ["ous", 'preus', "vit", 'uci', 'stormo']

pathogen_reps = 120
disease_reps = 130
poison_reps = 70
ethno_reps = 400
drugs_reps = 340
d_t_p = min(500, drugs_reps * poison_reps)
d_t_d = min(230, drugs_reps * disease_reps)
e_t_d = min(230, ethno_reps * disease_reps)
company_reps = 100
c_info_reps = 25
dev_reps = min(200, company_reps * pathogen_reps)
patent_reps = 50
pharm_reps = 230
tradem_reps = min(200, drugs_reps * patent_reps * company_reps)
stock_rep = min(500, pharm_reps * tradem_reps)

# PATHOGENS
pathogen_name_endings = ArrayRandomGetter(pathogen_name_endings_values)
pathogen_type = ArrayRandomGetter(pathogen_type_values)
pathogen_action_verb = ArrayRandomGetter(pathogen_action_verb_values)
pathogen_action_target = ArrayRandomGetter(pathogen_action_target_values)
for _ in range(pathogen_reps):
    name = get_random_string(3, 10) + next(pathogen_name_endings) + ' ' + str(randint(0, 100)) + '__' + str(
        randint(0, 10000))
    path_type = next(pathogen_type)
    action = next(pathogen_action_verb) + ' ' + next(pathogen_action_target)
    script += f"INSERT INTO pathogens(name, type, action) VALUES ('{name}', '{path_type}', '{action}');\n"

# DISEASES
disease_name = ArrayRandomGetter(disease_name_values)
for _ in range(disease_reps):
    p_id = randint(1, pathogen_reps)
    name = next(disease_name) + ' ' + get_random_string(3, 6)
    mortal = random.random()
    script += f"INSERT INTO diseases(pathogen_id, name, mortality) VALUES ({p_id}, '{name}', {mortal});\n"

# POISONS
poison_origin = ArrayRandomGetter(poison_origin_values)
poison_name_endings = ArrayRandomGetter(poison_name_endings_values)
for _ in range(poison_reps):
    active_substance = get_random_string(6, 8) + next(poison_name_endings)
    t_act = next(pathogen_action_verb) + ' ' + next(pathogen_action_target)
    t_or = next(poison_origin)
    mortal = random.random()
    script += f"INSERT INTO poisons(active_substance, type_by_action, type_by_origin, mortality) " \
              f"VALUES ('{active_substance}', '{t_act}', '{t_or}', {mortal});\n"

# ETHNOSCIENCE
ethnoscience_verb = ArrayRandomGetter(ethnoscience_verb_values)
ethnoscience_noun = ArrayRandomGetter(ethnoscience_noun_values)
ethnoscience_origin = ArrayRandomGetter(ethnoscience_origin_values)
for _ in range(ethno_reps):
    e_act = next(ethnoscience_verb) + ' ' + next(ethnoscience_noun)
    e_or = next(ethnoscience_origin)
    script += f"INSERT INTO ethnoscience(name, origin) VALUES ('{e_act}', '{e_or}');\n"

# DRUGS
drugs_groups = ArrayRandomGetter(drugs_groups_values)
active_substance_ends = ArrayRandomGetter(active_substance_ends_values)
active_substance_beginnings = ArrayRandomGetter(active_substance_beginnings_values)
for _ in range(drugs_reps):
    act_subs = next(active_substance_beginnings) + get_random_string(0, 5) + get_random_string(1, 3) + next(
        active_substance_ends)
    homeo = get_bool()
    dr_group = next(drugs_groups)
    script += f"INSERT INTO drugs(active_substance, homeopathy, drugs_group) VALUES ('{act_subs}', '{homeo}', '{dr_group}');\n"

# DRUGS_TO_POISONS
# DRUGS_TO_DISEASE
# ETHNOSCIENCE_TO_DISEASE
dtp_set = make_many_to_many(d_t_p, drugs_reps, poison_reps)
for dr, po in dtp_set:
    script += f"INSERT INTO drugs_to_poisons VALUES ({dr}, {po});\n"

dtd_set = make_many_to_many(d_t_d, drugs_reps, disease_reps)
for dr, di in dtd_set:
    script += f"INSERT INTO drugs_to_diseases VALUES ({dr}, {di});\n"

etd_set = make_many_to_many(e_t_d, ethno_reps, disease_reps)
for et, di in etd_set:
    script += f"INSERT INTO ethnoscience_to_diseases VALUES ({et}, {di});\n"

# COMPANIES & COMPANY_INFO (history)
company_names = ArrayRandomGetter(company_names_values)
company_specialization = ArrayRandomGetter(company_specialization_values)
for _ in range(company_reps):
    com_name = get_random_string(4, 8) + next(company_names)
    specialization = next(company_specialization) + ', ' + next(company_specialization)
    script += f"INSERT INTO companies(name, specialization) VALUES ('{com_name}', '{specialization}');\n"
    for _ in range(randint(0, c_info_reps)):
        script += f"UPDATE companies SET (market_cap, net_profit_margin_pct_annual) = ({randint(0, 100000)}, {randint(0, 100000)}) where name='{com_name}';\n"

# DEVELOPMENT
development_stage = ArrayRandomGetter(development_stage_values)
dev_set = make_many_to_many(dev_reps, company_reps, pathogen_reps)
for co, pa in dev_set:
    stage = next(development_stage)
    failed = get_bool()
    script += f"INSERT INTO development(company_id,pathogen_id, testing_stage, failed) VALUES ({co}, {pa}, '{stage}', '{failed}');\n"

# PATENTS
patent_distribution = ArrayRandomGetter(patent_distribution_values)
for _ in range(patent_reps):
    distr = next(patent_distribution)
    start_date = str(randint(1900, 2021)) + '-' + str(randint(1, 12)) + '-' + str(randint(1, 28))
    script += f"INSERT INTO patents(distribution, start_date) VALUES ('{distr}', '{start_date}');\n"

# PHARMACIES
pharmacies_name = ArrayRandomGetter(pharmacies_name_values)
for _ in range(pharm_reps):
    name = next(pharmacies_name) + ' in ' + next(company_names)
    price_mul = randint(100, 500) / 100
    price_plus = randint(0, 5000) / 100
    script += f"INSERT INTO pharmacies(name, price_mul, price_plus) VALUES ('{name}', {price_mul}, {price_plus});\n"

# TRADEMARKS
trade_name_start = ArrayRandomGetter(trade_name_start_values)
trade_name_end = ArrayRandomGetter(trade_name_end_values)
trade_set = make_many_to_many_to_many(tradem_reps, drugs_reps, company_reps, patent_reps)
for a, b, c in trade_set:
    name = next(trade_name_start) + get_random_string(5, 9) + next(trade_name_end)
    doze = randint(1, 1000)
    rel_price = randint(20, 1000)
    script += f"INSERT INTO trademarks(name, doze, release_price, drug_id, company_id, patent_id) VALUES('{name}', {doze}, {rel_price}, {a}, {b}, {c});\n"

# STOCK
stock_set = make_many_to_many(stock_rep, pharm_reps, tradem_reps)
for a, b in stock_set:
    if random.random() > 0.7:
        script += f"INSERT INTO stock(pharmacy_id, trademark_id) VALUES ({a}, {b});\n"
    else:
        availability = randint(0, 100)
        script += f"INSERT INTO stock(pharmacy_id, trademark_id, availability) VALUES ({a}, {b}, {availability});\n"

print(script)
with open(script_name, 'w') as ouput_script:
    ouput_script.write(script)
