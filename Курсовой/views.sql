-- Представления

USE crm;

-- Получаем контактных лиц, принадлежащих компаниям

 DROP VIEW IF EXISTS contacts_company;
CREATE VIEW contacts_company AS
    SELECT cmp.id, cmp.name, concat(ct.surname, ' ', ct.name, ' ', ct.middle_name) AS contact, ct.id AS contact_id
    FROM companys AS cmp JOIN contacts AS ct ON ct.company_id = cmp.id;
    
-- Получаем реквизиты физ лиц из контактов

 DROP VIEW IF EXISTS requisites_persons;
CREATE VIEW requisites_persons AS
    SELECT p.* FROM person AS p JOIN requisite AS r ON (r.person_id = p.id AND (r.contact_id IS NOT NULL AND r.person_id IS not NULL));
    
-- Получаем реквизиты для ИП компаний из контактов

 DROP VIEW IF EXISTS requisites_ip_company;
CREATE VIEW requisites_ip_company AS
    SELECT ip.* FROM ip JOIN requisite AS r ON (r.ip_id = ip.id AND (r.company_id IS NOT NULL AND r.ip_id IS not NULL));

-- Получаем реквизиты организаций из контактов

 DROP VIEW IF EXISTS requisites_organization;
CREATE VIEW requisites_organization AS
    SELECT o.* FROM organization AS o JOIN requisite AS r ON (r.organization_id = o.id AND (r.contact_id IS NOT NULL AND r.organization_id IS not NULL));


    
    
    
    
    
