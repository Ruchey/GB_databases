
-- ФУНКЦИИ и ПРОЦЕДУРЫ
 USE crm;

DROP PROCEDURE IF EXISTS pro_get_delivery_address_order;
delimiter //
CREATE PROCEDURE pro_get_delivery_address_order()
BEGIN
    -- Получаю id адресов со значеним "Для установки или доставки"
    DROP TABLE IF EXISTS temp_delivery_address;
    CREATE TEMPORARY TABLE temp_delivery_address 
        SELECT a.id FROM addresses a WHERE a.addr_type_id = 3;
  
END//

-- Процедура выбора телефонного номера определённого контакта
DROP PROCEDURE IF EXISTS pro_get_phones;
delimiter //
CREATE PROCEDURE pro_get_phones(cont_id int)
BEGIN
     SELECT p.phone, pt.phone_type FROM phones p JOIN contacts c ON p.contact_id = c.id JOIN phone_types pt ON p.phone_type_id = pt.id WHERE c.id = cont_id;
END//



