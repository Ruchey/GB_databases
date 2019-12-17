/*
	���� ������ CRM �������
	�������� ����������:
		�������� ���� ��������� �������� � ���. ���., ����� ��� ��������� ��������, ����������� � ��������
		������� �������
	� ������ ��������� contacts ����� ��������� ������ ���-�� ���������, email-���, ������������, ����������
	��� �� � ��������� companys ����������� ��������, email-��, �����������, ���������
*/
DROP DATABASE IF EXISTS crm;

CREATE DATABASE crm;

USE crm;
-- 
-- ��� ��������: ������, ���������, ������
 DROP TABLE IF EXISTS company_types;

CREATE TABLE company_types ( id serial PRIMARY KEY,
company_type VARCHAR(20) );
-- 
-- ��� ��������: ������, ���������, ������
 DROP TABLE IF EXISTS contact_types;

CREATE TABLE contact_types ( id serial PRIMARY KEY,
contact_type VARCHAR(20) );
-- 
-- ��� ��������: ��������, �������...
 DROP TABLE IF EXISTS phone_types;

CREATE TABLE phone_types ( id serial PRIMARY KEY,
phone_type VARCHAR(20) );
-- ��� �����: ��������, �������...
 DROP TABLE IF EXISTS email_types;

CREATE TABLE email_types ( id serial PRIMARY KEY,
email_type VARCHAR(20) );
-- 
-- ��� �����������: skype, viber, facebook. vk
 DROP TABLE IF EXISTS messendger_types;

CREATE TABLE messendger_types ( id serial PRIMARY KEY,
messendger_type VARCHAR(20) );
-- 
-- ��������
-- ������� �������� ������ ��������
 DROP TABLE IF EXISTS companys;

CREATE TABLE companys ( id serial PRIMARY KEY,
name VARCHAR(100) comment '��������',
company_type_id BIGINT UNSIGNED NOT NULL comment '��� ��������: ������, ���������, ���������, ������, ������',
activity VARCHAR(100) comment '����� ������������',
site VARCHAR(100) NULL comment '����',
source VARCHAR(200) NULL comment '�������� �������/��������',
description TEXT NULL comment '��������',
FOREIGN KEY (company_type_id) REFERENCES company_types(id) );
-- 
-- ��������
-- ������� �������� ���������� ������ ����������� ��������
 DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts ( id serial PRIMARY KEY,
surname VARCHAR(100) comment '�������',
name VARCHAR(50) comment '���',
middle_name VARCHAR(50) NULL comment '��������',
photo VARCHAR(255) NULL comment '������ �� ����',
birthday DATE NULL,
posit VARCHAR(255) NULL comment '���������',
site VARCHAR(100) NULL comment '����',
company_id BIGINT UNSIGNED NULL comment '��������',
contact_type_id BIGINT UNSIGNED NOT NULL comment '��� ��������: ������, ���������, ������, ������',
source VARCHAR(200) NULL comment '�������� �������/��������',
description TEXT NULL comment '��������',
FOREIGN KEY (contact_type_id) REFERENCES contact_types(id),
FOREIGN KEY (company_id) REFERENCES companys(id) );
-- 
-- ��������
 DROP TABLE IF EXISTS phones;

CREATE TABLE phones ( id serial PRIMARY KEY,
phone VARCHAR(20) comment '����� ��������',
phone_type_id BIGINT UNSIGNED NOT NULL comment '��� ������ ��������',
contact_id BIGINT UNSIGNED NULL comment 'id ���������',
company_id BIGINT UNSIGNED NULL comment 'id ��������',
FOREIGN KEY (contact_id) REFERENCES contacts(id),
FOREIGN KEY (company_id) REFERENCES companys(id),
FOREIGN KEY (phone_type_id) REFERENCES phone_types(id) );
-- 
-- E-MAIL ������
 DROP TABLE IF EXISTS emails;

CREATE TABLE emails ( id serial PRIMARY KEY,
email VARCHAR(60),
email_type_id BIGINT UNSIGNED NOT NULL comment '��� ��������� ������',
contact_id BIGINT UNSIGNED NULL comment 'id ���������',
company_id BIGINT UNSIGNED NULL comment 'id ��������',
FOREIGN KEY (contact_id) REFERENCES contacts(id),
FOREIGN KEY (company_id) REFERENCES companys(id),
FOREIGN KEY (email_type_id) REFERENCES email_types(id) );
-- 
-- ����������� � ���������� ����: skype, telegram...
 DROP TABLE IF EXISTS messendgers;

CREATE TABLE messendgers ( id serial PRIMARY KEY,
messendger VARCHAR(250),
messendger_type_id BIGINT UNSIGNED NOT NULL comment '��� ���������� ����',
contact_id BIGINT UNSIGNED NULL comment 'id ���������',
company_id BIGINT UNSIGNED NULL comment 'id ��������',
FOREIGN KEY (contact_id) REFERENCES contacts(id),
FOREIGN KEY (company_id) REFERENCES companys(id),
FOREIGN KEY (messendger_type_id) REFERENCES messendger_types(id) );
-- 
-- ���� �������
 DROP TABLE IF EXISTS addr_types;

CREATE TABLE addr_types ( id serial PRIMARY KEY,
addr_type VARCHAR(20) );
-- 
-- ������
 DROP TABLE IF EXISTS addresses;

CREATE TABLE addresses ( id serial PRIMARY KEY,
addr_type_id BIGINT UNSIGNED NOT NULL comment '��� ������',
region VARCHAR(100) comment '�������',
city VARCHAR(50) comment '�����',
streat VARCHAR(50) comment '�����',
building VARCHAR(4) comment '������ ����',
house VARCHAR(4) comment '���',
office VARCHAR(4) comment '��������/����',
entrance VARCHAR(4) comment '�������',
flr VARCHAR(4) comment '����',
description TEXT comment '��������',
FOREIGN KEY (addr_type_id) REFERENCES addr_types(id) );
-- 
-- ��������� ��� ��� ����
 DROP TABLE IF EXISTS person;

CREATE TABLE person ( id serial PRIMARY KEY,
surname VARCHAR(100) comment '�������',
name VARCHAR(50) comment '���',
middle_name VARCHAR(50) comment '��������',
document VARCHAR(50) comment '��� ���������',
series VARCHAR(10) comment '�����',
num VARCHAR(50) comment '����� ���������',
given VARCHAR(200) comment '��� �����',
date_issue DATE comment '���� ������',
code VARCHAR(50) comment '��� �������������',
address_id BIGINT UNSIGNED NULL comment '�����',
FOREIGN KEY (address_id) REFERENCES addresses(id)
    ON UPDATE CASCADE 
    ON DELETE CASCADE );
-- 
-- ��������� ��� ��
 DROP TABLE IF EXISTS ip;

CREATE TABLE ip ( id serial PRIMARY KEY,
sortname VARCHAR(100) comment '����������� ��������',
fullname VARCHAR(100) comment '������ ��������',
surname VARCHAR(100) comment '�������',
name VARCHAR(50) comment '���',
middle_name VARCHAR(50) comment '��������',
inn VARCHAR(12) comment '���',
ogrnip VARCHAR(15) comment '������',
okpo VARCHAR(10) comment '����',
okved VARCHAR(20) comment '�����',
address_id BIGINT UNSIGNED NULL comment '�����',
FOREIGN KEY (address_id) REFERENCES addresses(id)
    ON UPDATE CASCADE 
    ON DELETE CASCADE );
-- 
-- ��������� ��� �����������
 DROP TABLE IF EXISTS organization;

CREATE TABLE organization ( id serial PRIMARY KEY,
inn VARCHAR(12) comment '���',
sortname VARCHAR(100) comment '����������� ��������',
fullname VARCHAR(100) comment '������ ��������',
ogrn VARCHAR(13) comment '����',
kpp VARCHAR(10) comment '���',
date_reg DATE comment '���� �����������',
okpo VARCHAR(11) comment '����',
oktmo VARCHAR(11) comment '�����',
gendirektor VARCHAR(200) comment '��� ��������',
glavbuh VARCHAR(200) comment '���� ���',
address_id BIGINT UNSIGNED NULL comment '�����',
FOREIGN KEY (address_id) REFERENCES addresses(id)
    ON UPDATE CASCADE 
    ON DELETE CASCADE );
-- 
-- ��������� ������� ���������� � ���������� � ����������
 DROP TABLE IF EXISTS requisite;

CREATE TABLE requisite ( id serial PRIMARY KEY,
contact_id BIGINT UNSIGNED NULL comment 'id ���������',
company_id BIGINT UNSIGNED NULL comment 'id ��������',
person_id BIGINT UNSIGNED NULL comment 'id ���������� ��� ����',
ip_id BIGINT UNSIGNED NULL comment 'id ���������� ��',
organization_id BIGINT UNSIGNED NULL comment 'id ���������� �����������',
FOREIGN KEY (contact_id) REFERENCES contacts(id),
FOREIGN KEY (company_id) REFERENCES companys(id),
FOREIGN KEY (person_id) REFERENCES person(id),
FOREIGN KEY (ip_id) REFERENCES ip(id),
FOREIGN KEY (organization_id) REFERENCES organization(id) );
-- 
-- ������� �������: ������, � ����������, ������....
 DROP TABLE IF EXISTS order_status;

CREATE TABLE order_status ( id serial PRIMARY KEY,
status VARCHAR(100) NOT NULL UNIQUE );
-- 
-- ������
 DROP TABLE IF EXISTS orders;

CREATE TABLE orders ( id serial PRIMARY KEY,
num VARCHAR(6) NOT NULL UNIQUE,
name VARCHAR(50) comment '��������',
status_id BIGINT UNSIGNED NOT NULL,
date_accept DATE comment '���� �������� ������',
date_production DATE comment '������ � ������������',
date_shipment DATE comment '���� ��������',
cost INT UNSIGNED DEFAULT 0 comment '��������� ������',
contact_id BIGINT UNSIGNED NOT NULL comment '�������',
company_id BIGINT UNSIGNED NULL comment '��������',
FOREIGN KEY (status_id) REFERENCES order_status(id),
FOREIGN KEY (contact_id) REFERENCES contacts(id),
FOREIGN KEY (company_id) REFERENCES companys(id) );
