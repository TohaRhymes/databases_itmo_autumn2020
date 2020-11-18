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
    answer = []
    for _ in range(length):
        first_id = randint(1, first_reps)
        second_id = randint(1, second_reps)
        while (first_id, second_id) in cur_set:
            first_id = randint(1, first_reps)
            second_id = randint(1, second_reps)
        cur_set.add((first_id, second_id))
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
stock_availability_values = ['available', 'in other shops', 'ended']
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

development_stage = ArrayRandomGetter(development_stage_values)
stock_availability = ArrayRandomGetter(stock_availability_values)
patent_distribution = ArrayRandomGetter(patent_distribution_values)

pathogen_reps = 100
disease_reps = 400
poison_reps = 300
ethno_reps = 450
drugs_reps = 200
d_t_p = min(1000, drugs_reps * poison_reps)
d_t_d = min(1203, drugs_reps * disease_reps)
e_t_d = min(2000, ethno_reps * disease_reps)

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


print(script)
