/*
 * ���� ������ omoton.ru
 * ���� �������� ��������������� ������
 * ������� ��������
 * ������ ���
 * 
 */

drop database if exists omoton;
create database omoton;
use omoton;

-- ������� ������
drop table if exists services;
create table services (
	id serial primary key,
	name varchar(100)
);

-- ������� ������
drop table if exists service;
create table service (
	id serial primary key,
	page_id,
	
);

-- ������ ��������
drop table if exists pages;
create table pages (
	id serial primary key,
	title varchar(255),
	description varchar(512),
	keywords varchar(255),
	head_img 
	body text
);


