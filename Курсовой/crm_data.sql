DROP DATABASE IF EXISTS crm;

CREATE DATABASE crm;

USE crm;
-- 
-- ��� ��������: ������, ���������, ������
 DROP TABLE IF EXISTS company_types;

CREATE TABLE company_types ( id serial PRIMARY KEY,
company_type VARCHAR(20) );

INSERT INTO company_types VALUES
(1, '������'),
(2, '���������'),
(3, '���������'),
(4, '������');
-- 
-- ��� ��������: ������, ���������, ������
 DROP TABLE IF EXISTS contact_types;

CREATE TABLE contact_types ( id serial PRIMARY KEY,
contact_type VARCHAR(20) );

INSERT INTO contact_types VALUES
(1, '������'),
(2, '���������'),
(3, '������');
-- 
-- ��� ��������: ��������, �������...
 DROP TABLE IF EXISTS phone_types;

CREATE TABLE phone_types ( id serial PRIMARY KEY,
phone_type VARCHAR(20) );

INSERT INTO phone_types VALUES
(1, '�������'),
(2, '��������'),
(3, '����');
-- 
-- ��� �����: ��������, �������...
 DROP TABLE IF EXISTS email_types;

CREATE TABLE email_types ( id serial PRIMARY KEY,
email_type VARCHAR(20) );

INSERT INTO email_types VALUES
(1, '�������'),
(2, '��������'),
(3, '������');
-- 
-- ��� �����������: skype, viber, facebook. vk
 DROP TABLE IF EXISTS messendger_types;

CREATE TABLE messendger_types ( id serial PRIMARY KEY,
messendger_type VARCHAR(20) );

INSERT INTO messendger_types VALUES
(1, 'Skype'),
(2, 'Telegram'),
(3, 'VK'),
(4, 'Facebook'),
(5, 'Viber');
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

INSERT INTO companys VALUES
(1, '��� ����������', 2, '������', 'https://www.tdpra.ru', '', '��������� ��������� � �����'),
(2, '���', 2, '���������', 'https://mdm-complect.ru', '', '��������� ���������'),
(3, '������', 2, '����� ����', 'https://www.aristo.ru', '', '��������� ���������'),
(4, '�����', 2, '���������', 'http://magnabel.ru', '', '��������� ���������'),
(5, '������ ������', 1, '��������������', 'http://zelenaya-dolina.com', '����', '������ �����������');

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

INSERT INTO contacts VALUES
(1, '������', 'ϸ��', '��������', NULL, '1979-06-23', '��������', NULL, 1, 2, '����', '����� ����'),
(2, '�������', '��������', '��������', NULL, '1990-07-01', '��������', NULL, 2, 2, '����', '����� ����'),
(3, '�������', '�����', '����������', NULL, '1965-04-28', '�������', 'shkaf.ru', 3, 3, '����', '������ �����'),
(4, '������', '�������', '����������', NULL, '2010-01-18', NULL, NULL, 3, 1, '����', '�����������'),
(5, '�����', '��������', '���������', NULL, '1982-03-27', NULL, NULL, 4, 1, '����', '����� ����'),
(6, '�������', '������', '�����������', NULL, '2010-01-18', NULL, NULL, NULL, 1, '����', '����� ����'),
(7, '�����������', '������', '�����������', NULL, '1965-04-28', NULL, NULL, 5, 1, '����', '����� ����'),
(8, '��������', '�������', '����������', NULL, '1967-07-28', NULL, NULL, NULL, 1, '����', '����� ����'),
(9, '��������', '���', '����������', NULL, '2009-11-30', NULL, NULL, NULL, 1, '����', '����� ����'),
(10, '������', '�������', '���������', NULL, '1983-11-17', NULL, NULL, NULL, 1, '����', '����� ����');

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

INSERT INTO phones VALUES
(1, '7(495)114-69-44', 1, 1, NULL),
(2, '7(495)320-68-95', 2, 2, NULL),
(3, '7(495)948-16-43', 2, 1, NULL),
(4, '7(495)235-14-19', 1, 4, NULL),
(5, '7(495)332-28-74', 1, 5, NULL),
(6, '7(495)948-74-38', 1, 6, NULL),
(7, '7(495)774-42-85', 2, 6, NULL),
(8, '7(495)217-63-63', 1, NULL, 1),
(9, '7(495)069-83-39', 1, NULL, 2),
(10, '7(495)771-21-05', 2, NULL, 2),
(11, '7(495)913-67-81', 1, NULL, 3),
(12, '7(495)778-00-97', 1, NULL, 4),
(13, '7(495)681-24-97', 1, 7, NULL),
(14, '7(495)912-03-59', 2, 8, NULL),
(15, '7(495)629-40-05', 3, 9, NULL);

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

INSERT INTO emails VALUES
(1, 'jlopez@brown.biz', 1, 1, NULL),
(2, 'matthew17@bonilla.biz', 1, 2, NULL),
(3, 'floresbrandon@delacruz.info', 1, 3, NULL),
(4, 'greenzachary@burgess-johnson.com', 1, 4, NULL),
(5, 'colleenweber@padilla.org', 1, 5, NULL),
(6, 'tiffany27@olsen.com', 1, 6, NULL),
(7, 'michelle16@giles.com', 2, 6, NULL),
(8, 'ycox@gmail.com', 1, NULL, 1),
(9, 'johnstonwilliam@yahoo.com', 1, NULL, 2),
(10, '+davidmonroe@yahoo.com', 2, NULL, 2),
(11, 'mckenziejason@hampton-gonzalez.info', 1, NULL, 3),
(12, 'dylan53@hotmail.com', 1, NULL, 4),
(13, 'ijacobs@hotmail.com', 1, 7, NULL),
(14, 'kelly67@herrera-nunez.net', 2, 8, NULL),
(15, 'qmurphy@lopez-garcia.net', 3, 9, NULL);

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

INSERT INTO messendgers VALUES
(1, 'https://vk.com/id7524767', 3, 1, NULL),
(2, 'https://vk.com/olegvenediktov', 3, 2, NULL),
(3, 'https://vk.com/kuularts', 3, 3, NULL),
(4, 'https://vk.com/mebelkuhnibelgorodforma', 3, 4, NULL),
(5, 'https://vk.com/pavelimona', 3, 5, NULL),
(6, 'https://tlgrm.ru/channels/@temablog', 2, 6, NULL),
(7, 'https://tlgrm.ru/channels/@durov_russia', 2, 6, NULL),
(8, 'https://tlgrm.ru/channels/@SolovievLive', 2, NULL, 1),
(9, 'https://tlgrm.ru/channels/@iznytri', 2, NULL, 2),
(10, 'https://tlgrm.ru/channels/@sanyaizdagestana', 2, NULL, 2),
(11, 'Araktilar', 1, NULL, 3),
(12, 'Faezragore', 1, NULL, 4),
(13, 'Insomnia', 1, 7, NULL),
(14, 'https://www.facebook.com/profile.php?id=100024529522612', 4, 8, NULL),
(15, 'https://www.facebook.com/profile.php?id=100013263849269', 4, 9, NULL);

-- 
-- ���� �������
 DROP TABLE IF EXISTS addr_types;

CREATE TABLE addr_types ( id serial PRIMARY KEY,
addr_type VARCHAR(20) );

INSERT INTO addr_types VALUES
(1, '��������'),
(2, '�����������'),
(3, '���������');

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

INSERT INTO addresses VALUES
(1,'1','Mississippi','Swaniawskifurt','','835','101','298','','7936',''),
(2,'1','RhodeIsland','North Jessie','Point','','','','157','5611',''),
(3,'2','Vermont','','','462','0764','2367','','',''),
(4,'2','Kentucky','East Dahlia','Center','','','','699','9990',''),
(5,'1','Kentucky','East Gia','Heights','','2304','3886','8476','196',''),
(6,'3','SouthDakota','Schmidtfurt','Turnpike','','','771','','8800',''),
(7,'3','Alaska','','Crest','1399','','','718','4600',''),
(8,'2','Arkansas','Amyberg','','','4346','','','7855',''),
(9,'1','Iowa','New Heleneberg','Unions','','695','','1735','4472',''),
(10,'3','Arizona','Helenachester','','9663','','','6754','',''),
(11,'3','SouthDakota','Lake Vernieport','','','','','','6979','Iusto aperiam voluptates perspiciatis quibusdam quia dolorum. Omnis voluptate possimus magnam sit. Provident distinctio fugiat cum sapiente. Unde sit molestiae voluptatem ea molestias rerum qui.'),
(12,'3','NewYork','Lemkeland','','','8968','','956','','Enim laborum laboriosam velit modi harum. Numquam nobis numquam laboriosam accusamus voluptates. Ipsam nihil veniam quia qui dolor neque. Labore ratione voluptatem est optio.'),
(13,'3','NewYork','Ellsworthfort','Corner','3206','9209','','','3720','Reiciendis et non repellat eum ipsum commodi. Non veniam ratione quia ex voluptatem aliquam vel officiis. Iusto labore facilis est explicabo ad. Officia recusandae qui fuga est aut. Quia et harum non officia.'),
(14,'2','District of Columbia','','Vista','','','0380','','',''),
(15,'3','NorthCarolina','Port Darrel','Point','416','','620','435','','Maxime id ex laboriosam aut. Molestias unde vitae sequi dolorem dolores laudantium aut qui. Laboriosam quia rem voluptatum quis.'); 

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

INSERT INTO person VALUES
(1, '������', 'ϸ��', '��������', '�������', '1604', '654258', '���. �. ������', '1985-02-04', '310-000', 1),
(2, '�������', '��������', '��������', '�������', '1450', '236468', '���. �. ������', '1986-04-04', '310-001', 2),
(3, '�������', '�����', '����������', '�������', '5642', '654256', '���. �. ������', '1991-09-03', '310-002', 3),
(4, '������', '�������', '����������', '�������', '0125', '559221', '���. �. ������', '1994-09-21', '310-001', 4),
(5, '�����', '��������', '���������', '�������', '5642', '546235', '���. �. ������', '1996-04-12', '310-001', 5),
(6, '�������', '������', '�����������', '�������', '5642', '145264', '���. �. ������', '2000-03-31', '310-011', 6),
(7, '�����������', '������', '�����������', '�������', '1456', '785423', '���. �. ������', '2001-02-09', '310-014', 7),
(8, '��������', '�������', '����������', '�������', '2354', '125475', '���. �. ������', '2001-12-19', '310-021', 8),
(9, '��������', '���', '����������', '�������', '4562', '235481', '���. �. ������', '2002-05-14', '310-001', 9),
(10, '������', '�������', '���������', '�������', '8745', '321458', '���. �. ������', '2002-12-16', '310-001', 10);


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

INSERT INTO ip VALUES
(1, '�� ������', '��� �����', '������', 'ϸ��', '��������', '680497070723', '304556378099970', '069744185', '5126542568', 1),
(2, '�� �������', '������', '�������', '��������', '��������', '241174775577', '314383238766167', '596144207', '62515635641', 2),
(3, '�� �������', '������ ������', '�������', '�����', '����������', '588393863127', '311433519500189', '867643810', '5453548230',  3),
(4, '�� ������', '������� �', '������', '�������', '����������', '422576467721', '303621521216196', '301843182', '0546112651', 4),
(5, '�� �����', '�����', '�����', '��������', '���������', '833655866301', '316850199463537', '922744958', '05102354024', 5),
(6, '�� �������', '������ ������', '�������', '������', '�����������', '879373026533', '306325070435498', '357545880', '0216510513', 6),
(7, '�� �����������', '��� �����', '�����������', '������', '�����������', '797214807954', '314196105388512', '428344147', '5478950156', 7),
(8, '�� ��������', '����', '��������', '�������', '����������', '149948066007', '318567123525062', '684843562', '1560123541', 8),
(9, '�� ��������', '������ �������', '��������', '���', '����������', '541537799156', '312098833614991', '579243394', '1235481023', 9),
(10, '�� ������', '��� ������', '������', '�������', '���������', '146167776946', '315693180727202', '579243394', '8445602154', 10);

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

INSERT INTO organization VALUES
(1, '680497070723', '��������', '��� "��������"', '3045563780970', '069744185', '2002-12-16', '5126542568', '4535484', '�������� ������ ����������', '���������� ����� ���������', 1),
(2, '241174775577', '��������', '��� "��������"', '3143832387167', '596144207', '2002-12-16', '62515635641', '54523345', '����������� �������� ����������', '�������� ������ �������', 2),
(3, '588393863127', '���������', '��� "���������"', '3114335195189', '867643810', '2002-12-16', '5453548230', '05215486', '�������������� ��������� ����������', '��������� ���� ���������', 3),
(4, '422576467721', '�����', '��� "�����"', '3036215212196', '301843182', '2002-12-16', '0546112651', '654105454', '����������� �������� ����������', '��������� ����� ��������������', 4),
(5, '833655866301', '������', '��� "������"', '3168501463537', '922744958', '2002-12-16', '05102354024', '5643210415', '���������������� ������ �����������', '������� ������ ���������', 5),
(6, '879373026533', '�����', '��� "�����"', '3063250435498', '357545880', '2002-12-16', '0216510513', '56454120', '�������� ������������� ��������', '�������� ���� ����������', 6),
(7, '797214807954', '�����', '��� "�����"', '3141961088512', '428344147', '2002-12-16', '5478950156', '651216545', '��������� ������ �������������', '������������ ���� ����������', 7),
(8, '149948066007', '���������', '��� "���������"', '3185673525062', '684843562', '2002-12-16', '1560123541', '3154151063', '��������� ��������� ���������', '����������� ��������� ����������', 8),
(9, '541537799156', '���������', '��� "���������"', '3120988614991', '579243394', '2002-12-16', '1235481023', '15615103', '����������� �������� ���������', '����������� �������� ����������', 9),
(10, '146167776946', '���������', '��� "���������"', '3156980727202', '579243394', '2002-12-16', '8445602154', '5645132120', '�������� ������ ���������', '����������� ����� ����������', 10);

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

INSERT INTO requisite VALUES
-- id contact_id company_id person_id ip_id organization_id
(1, 1, NULL, 1, NULL, NULL),
(2, 2, NULL, 2, NULL, NULL),
(3, 3, NULL, 3, NULL, NULL),
(4, 4, NULL, 4, NULL, NULL),
(5, NULL, 1, 1, NULL, NULL),
(6, NULL, 2, 2, NULL, NULL),
(7, NULL, 3, 7, NULL, NULL),
(8, NULL, 4, 8, NULL, NULL),
(9, NULL, 5, NULL, 2, NULL),
(10, NULL, 1, NULL, 1, NULL),
(11, NULL, 2, NULL, 6, NULL),
(12, NULL, 3, NULL, 3, NULL),
(13, NULL, 4, NULL, 10, NULL),
(14, NULL, 5, NULL, 4, NULL),
(15, 5, NULL, NULL, NULL, 1),
(16, 6, NULL, NULL, NULL, 3),
(17, 7, NULL, NULL, NULL, 6),
(18, 8, NULL, NULL, NULL, 8);


-- 
-- ������� �������: ������, � ����������, ������....
 DROP TABLE IF EXISTS order_status;

CREATE TABLE order_status ( id serial PRIMARY KEY,
status VARCHAR(100) NOT NULL UNIQUE );

INSERT INTO order_status VALUES
(1, '������'),
(2, '��������'),
(3, '������');

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

INSERT INTO orders VALUES
(1, '23', '����', 1, '2019-07-23', '2019-07-25', '2019-08-2', 53000, 3, NULL),
(2, '24', '����-����', 1, '2019-09-13', '2019-09-15', '2019-10-2', 23000, 1, NULL),
(3, '25', '����-����', 1, '2019-09-20', '2019-09-25', '2019-10-5', 43500, 3, NULL),
(4, '26', '��������', 1, '2019-10-01', '2019-10-03', '2019-10-20', 32000, 6, 4),
(5, '27', '�����', 1, '2019-10-06', '2019-10-08', '2019-10-20', 4500, 10, 2),
(6, '28', '�����', 1, '2019-10-12', '2019-10-15', '2019-11-20', 120000, 5, NULL),
(7, '29', '�����', 1, '2019-10-16', '2019-10-20', '2019-11-30', 60000, 10, NULL),
(8, '30', '�������', 1, '2019-11-02', '2019-11-05', '2019-11-30', 80000, 8, NULL);













