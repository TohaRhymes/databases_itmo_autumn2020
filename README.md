# Информационные системы и Базы Данных
## ИТМО. 3 курс. СППО

### <a href="lab1">Лабораторная работа 1.</a>
__Задание__
* На основе предложенной предметной области (текста) составить ее описание. Из
полученного описания выделить сущности, их атрибуты и связи.
* Составить инфологическую модель.

* Составить даталогическую модель. При описании типов данных для атрибутов должны
использоваться типы из СУБД PostgreSQL.

* Реализовать даталогическую модель в PostgreSQL. При описании и реализации
даталогической модели должны учитываться ограничения целостности, которые
характерны для полученной предметной области.

* Заполнить созданные таблицы тестовыми данными.

__Текст__:
```
Словно лосось, преодолевающий водопад, он за считанные секунды поднялся по
электрической реке, соединяющей Ио с Юпитером, и достиг корабля, который принес его
сюда с родной планеты. Тот казался карликом рядом с произведением технической мысли
великой цивилизации.
```

### <a href="lab2">Лабораторная работа 2.</a>

__Задание__

По варианту, выданному преподавателем, составить и выполнить запросы к базе данных
"Учебный процесс".
Команда для подключения к базе данных `ucheb`:
`psql -h pg -d ucheb`
Составить запросы на языке SQL (пункты 1-7).

_1._ Сделать запрос для получения атрибутов из указанных таблиц, применив фильтры по
указанным условиям:
```
Таблицы: Н_ОЦЕНКИ, Н_ВЕДОМОСТИ.
Вывести атрибуты: Н_ОЦЕНКИ.ПРИМЕЧАНИЕ, Н_ВЕДОМОСТИ.ЧЛВК_ИД.
Фильтры (AND):
a) Н_ОЦЕНКИ.КОД > осв.
b) Н_ВЕДОМОСТИ.ДАТА > 2010-06-18.
Вид соединения: RIGHT JOIN.
```
_2._ Сделать запрос для получения атрибутов из указанных таблиц, применив фильтры по
указанным условиям:
```
Таблицы: Н_ЛЮДИ, Н_ВЕДОМОСТИ, Н_СЕССИЯ.
Вывести атрибуты: Н_ЛЮДИ.ОТЧЕСТВО, Н_ВЕДОМОСТИ.ИД, Н_СЕССИЯ.ДАТА.
Фильтры (AND):
a) Н_ЛЮДИ.ИД = 100012.
b) Н_ВЕДОМОСТИ.ДАТА = 2022-06-08.
c) Н_СЕССИЯ.ДАТА > 2002-01-04.
Вид соединения: INNER JOIN.
```
_3._ Вывести число студентов вечерней формы обучения, которые младше 20 лет.
Ответ должен содержать только одно число.

_4._ В таблице `Н_ГРУППЫ_ПЛАНОВ` найти номера планов, по которым обучается
(обучалось) более 2 групп ФКТИУ.
Для реализации использовать соединение таблиц.

_5._ Выведите таблицу со средним возрастом студентов во всех группах (Группа, Средний
возраст), где средний возраст больше минимального возраста в группе 3100.

_6._ Получить список студентов, зачисленных ровно первого сентября 2012 года на первый
курс очной или заочной формы обучения (специальность: Программная инженерия). В
результат включить:
```
номер группы;
номер, фамилию, имя и отчество студента;
номер и состояние пункта приказа;
```
Для реализации использовать подзапрос с `EXISTS`.

_7._ Сформировать запрос для получения числа в группе No 3100 отличников.


### <a href="lab3">Лабораторная работа 3.</a>

__Задание__