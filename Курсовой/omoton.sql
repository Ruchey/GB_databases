/*
 * База данных omoton.ru
 * База содержит предоставляемые услуги
 * Таблицу новостей
 * Данные СМИ
 * 
 */

drop database if exists omoton;
create database omoton;
use omoton;

-- Услуги
drop table if exists services;
create table services (
	id serial primary key,
	name varchar(100)
);

-- Категории услуг
drop table if exists categories_services;
create table categories_services (
	id serial primary key,
	service_id bigint unsigned not null,
	name varchar(255),
	foreign key (service_id) references services(id)
	on update cascade
	on delete restrict
);

-- Описание услуг
drop table if exists description_services;
create table description_services (
	id serial primary key,
	categories_services_id bigint unsigned not null,
	description text,
	foreign key (categories_services_id) references categories_services(id)
	on update cascade
	on delete restrict
);

-- Стоимость услуг
drop table if exists cost_services;
create table cost_services (
	id serial primary key,
	categories_services_id bigint unsigned not null,
	price mediumint unsigned,
	explanation varchar(255),
	foreign key (categories_services_id) references categories_services(id)
	on update cascade
	on delete restrict
);


-- Шапка страницы
drop table if exists head_img;
create table head_img (
	id serial primary key,
	name varchar(100),
	url varchar(255)
);


-- Данные страницы
drop table if exists pages;
create table pages (
	id serial primary key,
	title varchar(255),
	description varchar(512),
	keywords varchar(255),
	head_img_id bigint unsigned not null,
	body text,
	foreign key (head_img_id) references head_img(id)
	on update cascade
	on delete restrict
);

