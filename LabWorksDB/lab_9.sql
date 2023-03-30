CREATE DATABASE Lab_work_9;

create table tip_klienta
(
    id_tip_klienta serial      not null primary key,
    tip_klienta    varchar(50) not null
);

create table rayon
(
    id_rayon serial      not null primary key,
    rayon    varchar(50) not null
);

create table klient
(
    id_klient         serial      not null primary key,
    familiya_klienta  varchar(50) not null,
    imya_klienta      varchar(50) not null,
    otchestvo_klienta varchar(50) not null,
    passport_klienta  varchar(50) not null,
    password          varchar(50) not null,
    login             varchar(50) not null,
    mesto_raboty      varchar(50) not null,
    skidka            int         not null,
    id_tip_klienta    int         not null,
    id_rayon          int         not null,
    constraint fk_tip_klienta
        foreign key (id_tip_klienta)
            references tip_klienta (id_tip_klienta),
    constraint fk_rayon
        foreign key (id_rayon)
            references rayon (id_rayon)
);

create table tip_kontaktov
(
    id_tip_kontaktov serial      not null,
    tip_kontaktov    varchar(50) not null,
    primary key (id_tip_kontaktov)
);

create table kontakty
(
    id_kontakty      serial      not null,
    kontakty         varchar(50) not null,
    id_klient        int         not null,
    id_tip_kontaktov int         not null,
    primary key (id_kontakty),
    constraint fk_klient
        foreign key (id_klient)
            references klient (id_klient),
    constraint fk_tip_kontaktov
        foreign key (id_tip_kontaktov)
            references tip_kontaktov (id_tip_kontaktov)
);

create table tip_zakaza
(
    id_tip_zakaza serial      not null primary key,
    tip_zakaza    varchar(50) not null
);

create table tip_prodaj
(
    id_tip_prodaj serial      not null primary key,
    tip_prodaj    varchar(50) not null
);

create table sostoyanie
(
    id_sostoyanie serial      not null primary key,
    sostoyanie    varchar(50) not null
);

create table doljnost
(
    id_doljnost serial      not null primary key,
    doljnost    varchar(50) not null
);

create table sotrudnik
(
    id_sotrudnik         serial      not null primary key,
    familiya_sotrudnika  varchar(50) not null,
    imya_sotrudnika      varchar(50) not null,
    otchestvo_sotrudnika varchar(50) not null,
    id_doljnost          int         not null,
    constraint fk_doljnost
        foreign key (id_doljnost)
            references doljnost (id_doljnost)
);

create table zakaz
(
    id_zakaz      serial      not null primary key,
    data          date        not null,
    nomer_doc     varchar(50) not null,
    comments      varchar(50) not null,
    id_klient     int         not null,
    id_tip_zakaza int         not null,
    id_sostoyanie int         not null,
    id_tip_prodaj int         not null,
    id_sotrudnik  int         not null,
    foreign key (id_klient)
        references klient (id_klient)
        on delete cascade
        on update cascade,
    foreign key (id_tip_zakaza)
        references tip_zakaza (id_tip_zakaza)
        on delete cascade
        on update cascade,
    foreign key (id_sostoyanie)
        references sostoyanie (id_sostoyanie)
        on delete cascade
        on update cascade,
    foreign key (id_tip_prodaj)
        references tip_prodaj (id_tip_prodaj)
        on delete cascade
        on update cascade,
    foreign key (id_sotrudnik)
        references sotrudnik (id_sotrudnik)
        on delete cascade
        on update cascade
);

create table vid_oplaty
(
    id_vid_oplaty serial      not null primary key,
    vid_oplaty    varchar(50) not null
);

create table oplata
(
    id_oplata     serial      not null primary key,
    data          date        not null,
    summa         int         not null,
    comments      varchar(50) not null,
    id_zakaz      int         not null,
    id_vid_oplaty int         not null,

    foreign key (id_zakaz)
        references zakaz (id_zakaz)
        on delete cascade
        on update cascade,
    foreign key (id_vid_oplaty)
        references vid_oplaty (id_vid_oplaty)
        on delete cascade
        on update cascade
);

create table tip_tovara
(
    id_tip_tovara serial      not null primary key,
    tip_tovara    varchar(50) not null
);

create table tovar
(
    id_tovar      serial      not null primary key,
    comments      varchar(50) not null,
    photo         varchar(50) not null,
    id_tip_tovara int         not null,
    foreign key (id_tip_tovara)
        references tip_tovara (id_tip_tovara)
        on delete cascade
        on update cascade
);
create table tip_postavki
(
    id_tip_postavki serial      not null primary key,
    tip_postavki    varchar(50) not null
);

create table tip_postavshika
(
    id_tip_postavshika serial      not null primary key,
    tip_postavshika    varchar(50) not null
);

create table postavshik
(
    id_postavshik         serial      not null primary key,
    nazvaniye             varchar(50) not null,
    familiya_postavshika  varchar(50) not null,
    imya_postavshika      varchar(50) not null,
    otchestvo_postavshika varchar(50) not null,
    id_tip_postavshika    int         not null,
    foreign key (id_tip_postavshika)
        references tip_postavshika (id_tip_postavshika)
        on delete cascade
        on update cascade
);

create table postavki
(
    id_postavki     serial      not null primary key,
    numer_doc       int         not null,
    data            date        not null,
    comments        varchar(50) not null,
    id_postavshik   int         not null,
    id_tip_postavki int         not null,
    foreign key (id_postavshik)
        references postavshik (id_postavshik)
        on delete cascade
        on update cascade,
    foreign key (id_tip_postavki)
        references tip_postavki (id_tip_postavki)
        on delete cascade
        on update cascade
);

create table spisok_postavki
(
    id_spisok_postavki serial not null primary key,
    id_postavki        int    not null,
    cena               int    not null,
    kolichestvo        int    not null,
    srok_godnosti      date   not null,
    foreign key (id_postavki)
        references postavki (id_postavki)
        on delete cascade
        on update cascade

);

create table spisok_tovarov
(
    id_spisok_tovarov  serial not null primary key,
    cena               int    not null,
    kolichestvo        int    not null,
    id_zakaz           int    not null,
    id_tovar           int    not null,
    id_spisok_postavki int    not null,
    foreign key (id_zakaz)
        references zakaz (id_zakaz)
        on delete cascade
        on update cascade,
    foreign key (id_tovar)
        references tovar (id_tovar)
        on delete cascade
        on update cascade,
    foreign key (id_spisok_postavki)
        references spisok_postavki (id_spisok_postavki)
        on delete cascade
        on update cascade
);

create table price_list
(
    id_price_list serial      not null primary key,
    cena          int         not null,
    data          date        not null,
    comments      varchar(50) not null,
    id_tovar      int         not null,
    foreign key (id_tovar)
        references tovar (id_tovar)
        on delete cascade
        on update cascade
);

create table oplata2
(
    id_oplata   serial      not null primary key,
    data        date        not null,
    summa       int         not null,
    comments    varchar(50) not null,
    id_postavki int         not null,
    foreign key (id_postavki)
        references postavki (id_postavki)
        on delete cascade
        on update cascade
);

INSERT INTO vid_oplaty(vid_oplaty)
VALUES ('Electronic money'),
       ('By bank card through the terminal'),
       ('Transfer via internet bank'),
       ('Payment via mobile phone'),
       ('Calculation using bank card details');

INSERT INTO tip_kontaktov(tip_kontaktov)
VALUES ('Address'),
       ('Phone'),
       ('E-Mail'),
       ('Web-Page'),
       ('Other');

INSERT INTO rayon(rayon)
VALUES ('Aksy'),
       ('Ala-Buka'),
       ('Toktogul'),
       ('Nooken'),
       ('Bazar-Korgon');

INSERT INTO tip_klienta(tip_klienta)
VALUES ('Purposeful'),
       ('Know-it-all'),
       ('Talker'),
       ('Indecisive'),
       ('Uncommunicative');

INSERT INTO tip_prodaj(tip_prodaj)
VALUES ('To corporative clients'),
       ('Individuals'),
       ('State institutions'),
       ('Active'),
       ('Passive');

INSERT INTO sostoyanie(sostoyanie)
VALUES ('Accepted'),
       ('In work'),
       ('Done'),
       ('Discontinued');

INSERT INTO tip_zakaza(tip_zakaza)
VALUES ('Regular order'),
       ('Rush order');

INSERT INTO doljnost(doljnost)
VALUES ('Director'),
       ('Chief Accountant'),
       ('Chief dispatcher'),
       ('Chief Engineer'),
       ('Chief designer'),
       ('Chief metallurgist'),
       ('Chief metrologist');

INSERT INTO tip_postavki(tip_postavki)
VALUES ('DAF'),
       ('DDP'),
       ('DDU'),
       ('DES'),
       ('DEQ');

INSERT INTO tip_postavshika(tip_postavshika)
VALUES ('Manufacturers'),
       ('Distributors'),
       ('Importers');

INSERT INTO tip_tovara(tip_tovara)
VALUES ('Wholesale goods'),
       ('Consumer goods'),
       ('Industrial goods'),
       ('Services');

INSERT INTO tovar (tovar, comments, photo, id_tip_tovara)
VALUES ('iPhone', 'Latest model with great camera', 'iPhone.jpg', 1),
       ('Shirt', 'Stylish and comfortable', 'Shirt.jpg', 2),
       ('Sofa', 'Comfortable and spacious', 'Sofa.jpg', 3),
       ('Blender', 'Powerful and easy to use', 'Blender.jpg', 4);

INSERT INTO price_list (cena, data, comments, id_tovar)
VALUES (999.99, '2022-12-01', 'Launch price', 1),
       (39.99, '2022-06-01', 'Summer collection', 2),
       (499.99, '2022-08-01', 'Limited offer', 3),
       (79.99, '2022-09-01', 'Fall collection', 4);


INSERT INTO postavshik (nazvaniye, familiya_postavshika, imya_postavshika, otchestvo_postavshika, id_tip_postavshika)
VALUES ('Apple Inc.', 'Steve', 'P', 'Jobs', 1),
       ('Best Buy', 'Hubert', 'J', 'Whitmore', 2),
       ('Samsung', 'Lee', 'Byung-chul', 'P', 3);


INSERT INTO postavki (numer_doc, data, comments, id_postavshik, id_tip_postavki)
VALUES ('P0001', '2022-01-01', 'First shipment from Apple Inc.', 5, 1),
       ('P0002', '2022-02-01', 'Monthly shipment from Best Buy', 6, 2),
       ('P0003', '2022-03-01', 'Weekly shipment from Samsung', 7, 3);

INSERT INTO oplata2(data, summa, comments, id_postavki)
VALUES ('2022-01-05', 1000, 'Payment for shipment P0001', 10),
       ('2022-02-01', 2000, 'Payment for shipment P0002', 11),
       ('2022-03-10', 1500, 'Payment for shipment P0003', 12);

INSERT INTO spisok_postavki (id_postavki, cena, kolichestvo, srok_godnosti)
VALUES (10, 20, 50, '2022-12-31'),
       (11, 30, 40, '2023-05-31'),
       (12, 25, 60, '2023-07-31');


INSERT INTO klient(familiya_klienta, imya_klienta, otchestvo_klienta, passport_klienta, password, login, mesto_raboty,
                   skidka, id_tip_klienta, id_rayon)
VALUES ('John', 'A', 'Doe', '123456789', 'password1', 'johndoe', 'Microsoft', 10, 1, 1),
       ('Jane', 'B', 'Doe', '987654321', 'password2', 'janedoe', 'Google', 20, 2, 2),
       ('Jim', 'C', 'Smith', '111222333', 'password3', 'jimsmith', 'Apple', 30, 3, 3);


INSERT INTO kontakty(kontakty, id_klient, id_tip_kontaktov)
VALUES ('chingiz.kartanbaev@gmail.com', 1, 1),
       ('0555261203', 2, 2),
       ('Chingiz@skype', 3, 3);



INSERT INTO sotrudnik (familiya_sotrudnika, imya_sotrudnika, otchestvo_sotrudnika, id_doljnost)
VALUES ('Бирюкова', 'Дарья', 'Даниэльевна', 1),
       ('Зотов', 'Александр', 'Данилович', 3),
       ('Мещеряков', 'Марк', 'Владимирович', 4);

INSERT INTO zakaz (data, nomer_doc, comments, id_klient, id_tip_zakaza, id_sostoyanie, id_tip_prodaj, id_sotrudnik)
VALUES ('2023-02-11', '0001', 'Комментарий 1', 1, 1, 1, 1, 1),
       ('2023-02-12', '0002', 'Комментарий 2', 2, 2, 2, 2, 2);

INSERT INTO oplata (data, summa, comments, id_zakaz, id_vid_oplaty)
VALUES ('2022-01-01', 1000, 'Payment for order 1', 5, 1),
       ('2022-02-01', 500, 'Payment for order 2', 4, 2);

INSERT INTO spisok_tovarov(cena, kolichestvo, id_zakaz, id_tovar, id_spisok_postavki)
VALUES (100, 2, 4, 1, 6),
       (200, 3, 5, 2, 6);

-- ⦁	Список поставки за период  по товарам
SELECT *
FROM spisok_postavki
WHERE id_spisok_postavki in (SELECT id_spisok_postavki
                             FROM spisok_tovarov
                             WHERE id_tovar in (SELECT id_tovar
                                                FROM tovar
                                                WHERE id_tovar in
                                                      (SELECT id_tovar FROM price_list WHERE data = '2022-06-01')));

SELECT *
FROM spisok_postavki
WHERE id_spisok_postavki in (SELECT id_spisok_postavki
                             FROM spisok_tovarov
                             WHERE id_tovar in (SELECT id_tovar
                                                FROM tovar
                                                WHERE id_tovar in
                                                      (SELECT id_tovar FROM price_list WHERE data = '2022-06-01')));
--                                                       ⦁	Список товаров поставленных по поставщику
SELECT *
FROM spisok_tovarov
WHERE id_spisok_postavki in (SELECT id_spisok_postavki
                             FROM spisok_postavki
                             WHERE id_postavki in (SELECT id_postavki
                                                   FROM postavki
                                                   WHERE id_postavshik in
                                                         (SELECT id_postavshik FROM postavshik WHERE nazvaniye = 'Best Buy')));
--                                                          ⦁	Список товаров поставленных по типу товара
SELECT *
FROM spisok_postavki
WHERE id_spisok_postavki in (SELECT id_spisok_postavki
                             FROM spisok_tovarov
                             WHERE id_tovar in (SELECT id_tovar FROM tovar WHERE tovar = 'iPhone'));


-- ⦁	Поставки по товарам за период
SELECT *
FROM postavki
WHERE id_postavki in (SELECT id_postavki
                      FROM spisok_postavki
                      WHERE id_spisok_postavki in (SELECT id_spisok_postavki
                                                   FROM spisok_tovarov
                                                   WHERE id_tovar in (SELECT id_tovar FROM tovar WHERE tovar = 'iPhone')));
--                                                    ⦁	Изменение цен на товары, поставленные за период
UPDATE price_list
SET cena = 134
WHERE data >= '2022-09-01'
  and data <= '2022-12-01';


-- ⦁	Оплата по поставкам (журнал) за период
SELECT *
FROM oplata
WHERE id_zakaz in (SELECT id_zakaz
                   FROM zakaz
                   WHERE id_zakaz in (SELECT id_zakaz
                                      FROM spisok_tovarov
                                      WHERE id_spisok_postavki IN (SELECT id_spisok_postavki
                                                                   FROM spisok_postavki
                                                                   WHERE id_postavki in (SELECT id_postavki
                                                                                         FROM postavki
                                                                                         WHERE data BETWEEN ('2022-01-01') and ('2022-03-01')))));


-- ⦁	Заказы по типу продаж за период
DO
$$
    DECLARE
        id_zaka int;
    BEGIN
        SELECT id_zakaz
        INTO id_zaka
        FROM zakaz
        WHERE id_sostoyanie = (SELECT id_sostoyanie FROM sostoyanie WHERE sostoyanie = 'inactive')
          and data >= '2023-02-11'
          and data <= '2023-02-13';

        SELECT id_tovar,kolichestvo
        FROM spisok_tovarov
        WHERE id_zakaz = id_zaka;
    END
$$;

DO $$
DECLARE
  id_zaka INT;
BEGIN
  SELECT id_zakaz INTO id_zaka
  FROM zakaz
  WHERE id_sostoyanie = (SELECT id_sostoyanie FROM sostoyanie WHERE sostoyanie = 'inactive')
    AND data >= '2023-02-11'
    AND data <= '2023-02-13';

  PERFORM FROM spisok_tovarov
  WHERE id_zakaz = id_zaka;
END $$;

-- ⦁	Заказы клиента за период
SELECT *
FROM zakaz
WHERE id_klient in (SELECT id_klient FROM klient WHERE id_klient = 1)
  and data BETWEEN ('2023-02-11') and ('2023-02-12');


-- ⦁	Изменение цен на товары, поставленные за период
UPDATE price_list
SET cena = 134
WHERE data >= '2022-09-01'
  and data <= '2022-12-01';


-- ⦁	Актуальный прайс-лист
SELECT *
FROM price_list;


-- ⦁	Оплата по продажам (журнал) за период
SELECT id_oplata, summa, id_zakaz
FROM oplata
WHERE data >= '2022-01-01'
  and data <= '2022-03-01';


-- ⦁	Оплата по виду оплаты за период
SELECT summa
FROM oplata
WHERE id_vid_oplaty = (SELECT id_vid_oplaty from vid_oplaty WHERE vid_oplaty = 'cash')
  and data >= '2022-01-01'
  and data <= '2022-03-01';


-- ⦁	Продажи по сотрудникам статистика
SELECT *
FROM zakaz
WHERE id_sotrudnik = 1;


-- ⦁	Продажи по району за период
SELECT *
FROM zakaz
WHERE id_klient in
      (SELECT id_klient FROM klient WHERE id_rayon in (SELECT id_rayon FROM rayon WHERE rayon = 'Central'));


-- ⦁	Контакты клиентов
SELECT kontakty
FROM kontakty
WHERE id_klient = (SELECT id_klient FROM klient WHERE id_klient = 2);


-- ⦁	Заказы по типу продаж за период
SELECT id_zakaz, id_tip_prodaj
FROM zakaz;


-- ⦁	Заказы по типу заказа за период
SELECT id_zakaz, id_tip_zakaza
FROM zakaz;


-- ⦁	Остаток товара за период (в одной выборке отразить поставки и продажи)
DO
$$
    DECLARE
        id_kol  int;
        id_koll int;
    BEGIN
        SELECT kolichestvo
        INTO id_kol
        FROM spisok_tovarov
        WHERE id_spisok_tovarov = 8;

        SELECT kolichestvo
        INTO id_koll
        FROM spisok_postavki
        WHERE id_spisok_postavki = 5;

        RAISE NOTICE '%',id_koll - id_kol;
    END
$$;




-- -- -- -- -- -- -- Lab 11

CREATE OR REPLACE FUNCTION sum_or_rollback(a INT, b INT, c INT) RETURNS VOID AS $$
BEGIN
    IF c >= 0 THEN
        -- Если сумма неотрицательна, то вычисляем ее
        RAISE NOTICE 'Сумма % = %', c, a + b;
    ELSE
        -- Иначе откатываем транзакцию
        RAISE EXCEPTION 'Отрицательная сумма';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT sum_or_rollback(10, 15, 7); -- Сумма 22
SELECT sum_or_rollback(10, 15, -7); -- Ошибка "Отрицательная сумма"

-- task 2
CREATE OR REPLACE FUNCTION check_user_name() RETURNS TRIGGER AS $$
BEGIN
  IF NEW.last_name IS NULL THEN
    RAISE EXCEPTION 'Last name cannot be empty';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_customer
BEFORE INSERT ON users
FOR EACH ROW
EXECUTE FUNCTION check_user_name();

-- Создание таблицы заказов
CREATE TABLE orders (
  order_id SERIAL PRIMARY KEY,
  customer_id INTEGER,
  order_date DATE,
  order_amount NUMERIC(10, 2),
  CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES users (id)
);

-- Создание триггера для проверки задолженности
CREATE OR REPLACE FUNCTION check_customer_debt() RETURNS TRIGGER AS $$
DECLARE
  total_debt NUMERIC(10, 2);
BEGIN
  SELECT SUM(order_amount) INTO total_debt FROM orders WHERE customer_id = NEW.customer_id;

  IF total_debt > 0 THEN
    RAISE EXCEPTION 'Cannot place new order. Customer has unpaid balance of %', total_debt;
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_customer_debt
  BEFORE INSERT ON orders
  FOR EACH ROW
  EXECUTE FUNCTION check_customer_debt();

