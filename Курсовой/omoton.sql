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

-- Таблица услуги
drop table if exists services;
create table services (
	id serial primary key,
	name varchar(100)
);

-- Таблица услуга
drop table if exists service;
create table service (
	id serial primary key,
	page_id,
	
);

-- Данные страницы
drop table if exists pages;
create table pages (
	id serial primary key,
	title varchar(255),
	description varchar(512),
	keywords varchar(255),
	head_img 
	body text
);


