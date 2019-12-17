-- Представления

USE crm;

-- Получаем контактных лиц, принадлежащих компаниям

 DROP VIEW IF EXISTS ContactOfCompany;
CREATE VIEW ContactOfCompany AS 
    SELECT cmp.id, cmp.name, concat(ct.surname, ' ', ct.name, ' ', ct.middle_name) AS contact, ct.id AS contact_id
    FROM companys AS cmp JOIN contacts AS ct ON ct.company_id = cmp.id;
    
