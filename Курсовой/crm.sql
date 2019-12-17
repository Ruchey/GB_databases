/*
	База данных CRM системы
	Основной функционал:
		хранение базы контактов компаний и физ. лиц., среди них категории клиентов, поставщиков и партнёров
		ведение заказов
	К данным контактов contacts можно добавлять разное кол-во телефонов, email-лов, мессенджеров, реквизитов
	Так же и компаниям companys добавляются телефоны, email-лы, мессенджеры, реквизиты
*/
DROP DATABASE IF EXISTS crm;

CREATE DATABASE crm;

USE crm;
-- 
-- ТИП КОМПАНИИ: клиент, поставщик, партнёр
 DROP TABLE IF EXISTS company_types;

CREATE TABLE company_types ( id serial PRIMARY KEY,
company_type VARCHAR(20) );
-- 
-- ТИП КОНТАКТА: клиент, поставщик, партнёр
 DROP TABLE IF EXISTS contact_types;

CREATE TABLE contact_types ( id serial PRIMARY KEY,
contact_type VARCHAR(20) );
-- 
-- ТИП ТЕЛЕФОНА: домашний, рабочий...
 DROP TABLE IF EXISTS phone_types;

CREATE TABLE phone_types ( id serial PRIMARY KEY,
phone_type VARCHAR(20) );
-- ТИП ПОЧТЫ: домашняя, рабочая...
 DROP TABLE IF EXISTS email_types;

CREATE TABLE email_types ( id serial PRIMARY KEY,
email_type VARCHAR(20) );
-- 
-- ТИП МЕССЕНДЖЕРА: skype, viber, facebook. vk
 DROP TABLE IF EXISTS messendger_types;

CREATE TABLE messendger_types ( id serial PRIMARY KEY,
messendger_type VARCHAR(20) );
-- 
-- КОМПАНИИ
-- таблица содержит данные компаний
 DROP TABLE IF EXISTS companys;

CREATE TABLE companys ( id serial PRIMARY KEY,
name VARCHAR(100) comment 'название',
company_type_id BIGINT UNSIGNED NOT NULL comment 'тип компании: клиент, поставщик, конкурент, партнёр, другое',
activity VARCHAR(100) comment 'сфера деятельности',
site VARCHAR(100) NULL comment 'сайт',
source VARCHAR(200) NULL comment 'источник клиента/контакта',
description TEXT NULL comment 'описание',
FOREIGN KEY (company_type_id) REFERENCES company_types(id) );
-- 
-- КОНТАКТЫ
-- таблица содержит контактные данные конкретного человека
 DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts ( id serial PRIMARY KEY,
surname VARCHAR(100) comment 'фамилия',
name VARCHAR(50) comment 'имя',
middle_name VARCHAR(50) NULL comment 'отчество',
photo VARCHAR(255) NULL comment 'ссылка на фото',
birthday DATE NULL,
posit VARCHAR(255) NULL comment 'должность',
site VARCHAR(100) NULL comment 'сайт',
company_id BIGINT UNSIGNED NULL comment 'компания',
contact_type_id BIGINT UNSIGNED NOT NULL comment 'тип контакта: клиент, поставщик, партнёр, другое',
source VARCHAR(200) NULL comment 'источник клиента/контакта',
description TEXT NULL comment 'описание',
FOREIGN KEY (contact_type_id) REFERENCES contact_types(id),
FOREIGN KEY (company_id) REFERENCES companys(id) );
-- 
-- ТЕЛЕФОНЫ
 DROP TABLE IF EXISTS phones;

CREATE TABLE phones ( id serial PRIMARY KEY,
phone VARCHAR(20) comment 'номер телефона',
phone_type_id BIGINT UNSIGNED NOT NULL comment 'тип номера телефона',
contact_id BIGINT UNSIGNED NULL comment 'id контактов',
company_id BIGINT UNSIGNED NULL comment 'id компаний',
FOREIGN KEY (contact_id) REFERENCES contacts(id),
FOREIGN KEY (company_id) REFERENCES companys(id),
FOREIGN KEY (phone_type_id) REFERENCES phone_types(id) );
-- 
-- E-MAIL АДРЕСА
 DROP TABLE IF EXISTS emails;

CREATE TABLE emails ( id serial PRIMARY KEY,
email VARCHAR(60),
email_type_id BIGINT UNSIGNED NOT NULL comment 'тип почтового адреса',
contact_id BIGINT UNSIGNED NULL comment 'id контактов',
company_id BIGINT UNSIGNED NULL comment 'id компаний',
FOREIGN KEY (contact_id) REFERENCES contacts(id),
FOREIGN KEY (company_id) REFERENCES companys(id),
FOREIGN KEY (email_type_id) REFERENCES email_types(id) );
-- 
-- МЕССЕНДЖЕРЫ И СОЦИАЛЬНЫЕ СЕТИ: skype, telegram...
 DROP TABLE IF EXISTS messendgers;

CREATE TABLE messendgers ( id serial PRIMARY KEY,
messendger VARCHAR(250),
messendger_type_id BIGINT UNSIGNED NOT NULL comment 'тип социальной сети',
contact_id BIGINT UNSIGNED NULL comment 'id контактов',
company_id BIGINT UNSIGNED NULL comment 'id компаний',
FOREIGN KEY (contact_id) REFERENCES contacts(id),
FOREIGN KEY (company_id) REFERENCES companys(id),
FOREIGN KEY (messendger_type_id) REFERENCES messendger_types(id) );
-- 
-- ТИПЫ АДРЕСОВ
 DROP TABLE IF EXISTS addr_types;

CREATE TABLE addr_types ( id serial PRIMARY KEY,
addr_type VARCHAR(20) );
-- 
-- АДРЕСА
 DROP TABLE IF EXISTS addresses;

CREATE TABLE addresses ( id serial PRIMARY KEY,
addr_type_id BIGINT UNSIGNED NOT NULL comment 'тип адреса',
region VARCHAR(100) comment 'область',
city VARCHAR(50) comment 'город',
streat VARCHAR(50) comment 'улица',
building VARCHAR(4) comment 'корпус дома',
house VARCHAR(4) comment 'дом',
office VARCHAR(4) comment 'квартира/офис',
entrance VARCHAR(4) comment 'подъезд',
flr VARCHAR(4) comment 'этаж',
description TEXT comment 'описание',
FOREIGN KEY (addr_type_id) REFERENCES addr_types(id) );
-- 
-- РЕКВИЗИТЫ ДЛЯ ФИЗ ЛИЦА
 DROP TABLE IF EXISTS person;

CREATE TABLE person ( id serial PRIMARY KEY,
surname VARCHAR(100) comment 'фамилия',
name VARCHAR(50) comment 'имя',
middle_name VARCHAR(50) comment 'отчество',
document VARCHAR(50) comment 'вид документа',
series VARCHAR(10) comment 'серия',
num VARCHAR(50) comment 'номер документа',
given VARCHAR(200) comment 'кем выдан',
date_issue DATE comment 'дата выдачи',
code VARCHAR(50) comment 'код подразделения',
address_id BIGINT UNSIGNED NULL comment 'адрес',
FOREIGN KEY (address_id) REFERENCES addresses(id)
    ON UPDATE CASCADE 
    ON DELETE CASCADE );
-- 
-- РЕКВИЗИТЫ ДЛЯ ИП
 DROP TABLE IF EXISTS ip;

CREATE TABLE ip ( id serial PRIMARY KEY,
sortname VARCHAR(100) comment 'сокрощённое название',
fullname VARCHAR(100) comment 'понлое название',
surname VARCHAR(100) comment 'фамилия',
name VARCHAR(50) comment 'имя',
middle_name VARCHAR(50) comment 'отчество',
inn VARCHAR(12) comment 'ИНН',
ogrnip VARCHAR(15) comment 'ОГРНИП',
okpo VARCHAR(10) comment 'ОКПО',
okved VARCHAR(20) comment 'ОКВЭД',
address_id BIGINT UNSIGNED NULL comment 'адрес',
FOREIGN KEY (address_id) REFERENCES addresses(id)
    ON UPDATE CASCADE 
    ON DELETE CASCADE );
-- 
-- РЕКВИЗИТЫ ДЛЯ ОРГАНИЗАЦИИ
 DROP TABLE IF EXISTS organization;

CREATE TABLE organization ( id serial PRIMARY KEY,
inn VARCHAR(12) comment 'ИНН',
sortname VARCHAR(100) comment 'сокрощённое название',
fullname VARCHAR(100) comment 'понлое название',
ogrn VARCHAR(13) comment 'ОГРН',
kpp VARCHAR(10) comment 'КПП',
date_reg DATE comment 'дата регистрации',
okpo VARCHAR(11) comment 'ОКПО',
oktmo VARCHAR(11) comment 'ОКТМО',
gendirektor VARCHAR(200) comment 'ген директор',
glavbuh VARCHAR(200) comment 'глав бух',
address_id BIGINT UNSIGNED NULL comment 'адрес',
FOREIGN KEY (address_id) REFERENCES addresses(id)
    ON UPDATE CASCADE 
    ON DELETE CASCADE );
-- 
-- СВЯЗУЮЩАЯ ТАБЛИЦА РЕКВИЗИТОВ С КОНТАКТАМИ И КОМПАНИЯМИ
 DROP TABLE IF EXISTS requisite;

CREATE TABLE requisite ( id serial PRIMARY KEY,
contact_id BIGINT UNSIGNED NULL comment 'id контактов',
company_id BIGINT UNSIGNED NULL comment 'id компаний',
person_id BIGINT UNSIGNED NULL comment 'id реквизитов физ лица',
ip_id BIGINT UNSIGNED NULL comment 'id реквизитов ип',
organization_id BIGINT UNSIGNED NULL comment 'id реквизитов организации',
FOREIGN KEY (contact_id) REFERENCES contacts(id),
FOREIGN KEY (company_id) REFERENCES companys(id),
FOREIGN KEY (person_id) REFERENCES person(id),
FOREIGN KEY (ip_id) REFERENCES ip(id),
FOREIGN KEY (organization_id) REFERENCES organization(id) );
-- 
-- СТАТУСЫ ЗАКАЗОВ: принят, в разработке, закрыт....
 DROP TABLE IF EXISTS order_status;

CREATE TABLE order_status ( id serial PRIMARY KEY,
status VARCHAR(100) NOT NULL UNIQUE );
-- 
-- ЗАКАЗЫ
 DROP TABLE IF EXISTS orders;

CREATE TABLE orders ( id serial PRIMARY KEY,
num VARCHAR(6) NOT NULL UNIQUE,
name VARCHAR(50) comment 'название',
status_id BIGINT UNSIGNED NOT NULL,
date_accept DATE comment 'дата принятия заказа',
date_production DATE comment 'отдано в производство',
date_shipment DATE comment 'дата отгрузки',
cost INT UNSIGNED DEFAULT 0 comment 'стоимость заказа',
contact_id BIGINT UNSIGNED NOT NULL comment 'контакт',
company_id BIGINT UNSIGNED NULL comment 'компания',
FOREIGN KEY (status_id) REFERENCES order_status(id),
FOREIGN KEY (contact_id) REFERENCES contacts(id),
FOREIGN KEY (company_id) REFERENCES companys(id) );
