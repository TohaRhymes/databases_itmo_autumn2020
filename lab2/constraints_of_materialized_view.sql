-- Создадим основу для примера:
CREATE TABLE IF NOT EXISTS students
(
    id SERIAL,
    name text,
    age integer
);

INSERT INTO students(name, age) VALUES ('Тоха', 19);
INSERT INTO students(name, age) VALUES ('Леха', 20);
INSERT INTO students(name, age) VALUES ('Серега', 18);
INSERT INTO students(name, age) VALUES ('Витя', 20);
INSERT INTO students(name, age) VALUES ('Маша', 21);

CREATE MATERIALIZED VIEW mv_studs_names as select id, name from students;
CREATE VIEW v_studs_names as select id, name from students;

select * from mv_studs_names;
select * from v_studs_names;


-- Можем обновить значения, используя вью
update v_studs_names set name='ТОХАТОХА' where id=1;


select * from mv_studs_names;
select * from v_studs_names;
select * from students;
-- Сама таблица и вью - обновленные, а материалайзд вью - нет
refresh materialized view mv_studs_names;
select * from mv_studs_names;

-- Но для материалайзд вью будет ошибка/
-- ПРИМЕР (ошибочка будет)
update mv_studs_names set name='ЛехаЛеха' where id=2;



-- Еще можно с инсертами тоже так же куралесить:
INSERT INTO v_studs_names(name) VALUES ('Никита');

select * from mv_studs_names;
select * from v_studs_names;
select * from students;


-- Удалять тоже из MV нельзя (ща буит ошибка)
DELETE FROM mv_studs_names where id >= 5;
-- Из V - можно
DELETE FROM v_studs_names where id >= 5;

select * from mv_studs_names;
select * from v_studs_names;
select * from students;

refresh materialized view mv_studs_names;
select * from mv_studs_names;


drop view v_studs_names;
drop materialized view mv_studs_names;
drop table students;