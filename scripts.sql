/*
a. Запрос на извлечение данных из нескольких связанных таблиц с использованием соединения по равенству полей таблиц.

Этот запрос извлекает информацию о клиентах, их заказах и статусе заказов. 
Он соединяет таблицы client, orders, и order_status по соответствующим полям, 
чтобы получить имя клиента, дату заказа, статус заказа и общую сумму заказа.
*/
SELECT
    c.client_name,
    c.client_surname,
    o.order_date,
    os.order_status_name,
    o.order_total_amount
FROM
    client c,
    orders o,
    order_status os
WHERE
    c.client_id = o.client_client_id
    AND o.order_status_order_status_id = os.order_status_id;
    

/*
b. Запрос а) реализовать вторым способом с использованием INNER JOIN.

Этот запрос извлекает информацию о клиентах, их заказах и статусе заказов. 
Он использует INNER JOIN для соединения таблиц client, orders, 
и order_status по соответствующим полям, чтобы получить имя клиента, дату заказа, 
статус заказа и общую сумму заказа.
*/

SELECT
    c.client_name,
    c.client_surname,
    o.order_date,
    os.order_status_name,
    o.order_total_amount
FROM
    client c
INNER JOIN
    orders o ON c.client_id = o.client_client_id
INNER JOIN
    order_status os ON o.order_status_order_status_id = os.order_status_id;

/*
c. Запрос с использованием процедурных возможностей SQL (команда CASE).

Этот запрос извлекает информацию о заказах и их статусе, а также определяет, является ли заказ оплаченным или нет. 
Он использует оператор CASE для определения статуса оплаты заказа в зависимости от значения order_status_order_status_id.
*/
SELECT
    o.order_id,
    o.order_date,
    o.order_total_amount,
    os.order_status_name,
    CASE
        WHEN os.order_status_name = 'Оплачен' THEN 'Оплачен'
        ELSE 'Не оплачен'
    END AS payment_status
FROM
    orders o
INNER JOIN
    order_status os ON o.order_status_order_status_id = os.order_status_id;

/*
d. Запрос с использованием группировок, группировочных функций и условий на группы (HAVING).

Этот запрос извлекает информацию о количестве заказов, сделанных каждым клиентом, и суммарной стоимости этих заказов. 
Он группирует заказы по клиентам и использует группировочные функции для подсчета количества заказов и суммарной стоимости. 
Условие HAVING используется для фильтрации клиентов, у которых суммарная стоимость заказов превышает 1000 рублей.
*/
SELECT
    c.client_name,
    c.client_surname,
    COUNT(o.order_id) AS order_count,
    SUM(o.order_total_amount) AS total_amount
FROM
    client c
INNER JOIN
    orders o ON c.client_id = o.client_client_id
GROUP BY
    c.client_name,
    c.client_surname
HAVING
    SUM(o.order_total_amount) > 1000;

/* ------------------------
e. Запрос с использованием левого/правого соединения (LEFT/RIGHT JOIN).

Этот запрос извлекает информацию о всех банкетных залах и событиях, которые проводятся в этих залах. 
Он использует LEFT JOIN для соединения таблиц banquet_hall и event по соответствующим полям, 
чтобы получить информацию о банкетных залах и событиях, включая те залы, в которых в данный момент не проводятся события.
*/
SELECT
    bh.id AS banquet_hall_id,
    bh.capacity AS banquet_hall_capacity,
    e.event_id,
    e.event_name,
    e.description,
    e.date_start,
    e.date_end
FROM
    banquet_hall bh
LEFT JOIN
    event e ON bh.id = e.banquet_hall_id;

/*
f. Запрос с использованием вложенного подзапроса (вложенный SELECT).

Этот запрос извлекает информацию о клиентах, которые сделали заказы с суммарной стоимостью более 1000 рублей, 
а также о заказах этих клиентов. Он использует вложенный подзапрос для выбора клиентов, 
у которых суммарная стоимость заказов превышает 1000 рублей, и затем извлекает информацию о заказах этих клиентов.
*/
SELECT
    c.client_id,
    c.client_name,
    c.client_surname,
    c.client_email,
    o.order_id,
    o.order_date,
    o.order_total_amount,
    os.order_status_name
FROM
    client c
INNER JOIN
    orders o ON c.client_id = o.client_client_id
INNER JOIN
    order_status os ON o.order_status_order_status_id = os.order_status_id
WHERE
    c.client_id IN (
        SELECT
            o.client_client_id
        FROM
            orders o
        GROUP BY
            o.client_client_id
        HAVING
            SUM(o.order_total_amount) > 1000
    );

/*
g. Запрос на создание представления (VIEW) по любому из запросов а)-д).

Этот запрос создает представление client_orders_view, которое содержит информацию о клиентах, 
их заказах и статусе заказов. 
Представление использует запрос из пункта b) для извлечения данных.
*/

CREATE VIEW client_orders_view AS
SELECT
    c.client_name,
    c.client_surname,
    o.order_date,
    os.order_status_name,
    o.order_total_amount
FROM
    client c
INNER JOIN
    orders o ON c.client_id = o.client_client_id
INNER JOIN
    order_status os ON o.order_status_order_status_id = os.order_status_id;

-- Триггеры
-- Триггер 1: Обновление остатков ингредиентов на складе после добавления нового заказа

drop trigger after_cart_insert;

DELIMITER //
CREATE TRIGGER after_cart_insert
AFTER INSERT ON cart
FOR EACH ROW
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE ingredient_id INT;
    DECLARE total_quantity INT;
    DECLARE cur CURSOR FOR
        SELECT r.ingredient_ingredient_id, r.quantity * NEW.quantity AS total_quantity
        FROM recipe r
        WHERE r.menu_position_id = NEW.menu_position_id;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    OPEN cur;

    read_loop: LOOP
        FETCH cur INTO ingredient_id, total_quantity;
        IF done THEN
            LEAVE read_loop;
        END IF;

        UPDATE warehouse
        SET quantity = quantity - total_quantity
        WHERE ingredient_ingredient_id = ingredient_id;
    END LOOP;

    CLOSE cur;
END//

-- Тесты 1
SELECT * FROM warehouse;
SELECT * FROM orders;

INSERT INTO payment (payment_id, payment_date, payment_method, amount) VALUES
(9, '2024-12-18 10:00:00', 'Наличные', 700.00);

INSERT INTO orders (order_id, order_date, required_date, order_total_amount, address_address_id, order_status_order_status_id, client_client_id, payment_payment_id)
VALUES (9, '2024-12-18 10:00:00', '2024-12-18 12:00:00', 700.00, NULL, 1, 1, 9);

INSERT INTO cart (cart_id, orders_order_id, menu_position_id, quantity, price)
VALUES (17, 9, 1, 2, 700.00);

SELECT * FROM warehouse;

-- Триггер 2: Обновление остатков ингредиентов на складе после добавления нового заказа ингредиентов
DELIMITER //
CREATE TRIGGER after_purchasing_ingredients_insert
AFTER INSERT ON purchasing_ingredients
FOR EACH ROW
BEGIN
    DECLARE ingredient_id INT;
    DECLARE total_quantity INT;

    SET ingredient_id = NEW.ingredient_ingredient_id;
    SET total_quantity = NEW.quantity;

    IF EXISTS (SELECT 1 FROM warehouse WHERE ingredient_ingredient_id = ingredient_id) THEN
        UPDATE warehouse
        SET quantity = quantity + total_quantity
        WHERE ingredient_ingredient_id = ingredient_id;
    ELSE
        INSERT INTO warehouse (ingredient_ingredient_id, quantity)
        VALUES (ingredient_id, total_quantity);
    END IF;
END//

-- Тесты 1

select * from warehouse;

INSERT INTO purchasing_ingredients (purchase_id, ingredient_ingredient_id, supplier_supplier_id, quantity, price, purchasing_ingredients_date) VALUES
(32, 1, 1, 1000, 10.00, NOW());

select * from warehouse;
select * from purchasing_ingredients;


-- Процедуры
-- Процедура 1: Добавление нового клиента и его контактной информации
/*
Эта хранимая процедура добавляет нового клиента в таблицу client и его контактную информацию в таблицу telephone. 
Процедура принимает имя, фамилию, email и номер телефона клиента в качестве параметров.
*/

DELIMITER //

CREATE PROCEDURE CreatePaymentAndOrder(
    IN p_payment_date DATETIME,
    IN p_payment_method VARCHAR(30),
    IN p_order_date DATETIME,
    IN p_required_date DATETIME,
    IN p_address_address_id INTEGER,
    IN p_order_status_order_status_id INTEGER,
    IN p_client_client_id INTEGER
)
BEGIN
    DECLARE v_payment_id INTEGER;
    DECLARE v_order_id INTEGER;

    SET v_payment_id = (SELECT COALESCE(MAX(payment_id), 0) + 1 FROM payment);

    INSERT INTO payment (payment_id, payment_date, payment_method, amount)
    VALUES (v_payment_id, p_payment_date, p_payment_method, 0);

    SET v_order_id = (SELECT COALESCE(MAX(order_id), 0) + 1 FROM orders);

    INSERT INTO orders (order_id, order_date, required_date, order_total_amount, address_address_id, order_status_order_status_id, client_client_id, payment_payment_id)
    VALUES (v_order_id, p_order_date, p_required_date, 0, p_address_address_id, p_order_status_order_status_id, p_client_client_id, v_payment_id);
END //

DELIMITER ;


-- Тест 1
CALL CreatePaymentAndOrder(
    '2024-12-18 10:00:00',  
    'Наличные',          
    '2024-12-18 12:00:00',
    '2024-12-18 13:00:00', 
    1,
    1,
    1
);

select * from payment;
select * from orders;

-- Процедура 2 
DELIMITER //

CREATE PROCEDURE UpdateOrderPrices(IN orderId INT)
BEGIN
    DECLARE totalAmount DECIMAL(9, 2) DEFAULT 0;

    UPDATE cart
    SET price = (SELECT menu.position_price
                 FROM menu
                 WHERE menu.position_id = cart.menu_position_id) * cart.quantity
    WHERE orders_order_id = orderId;

    SELECT SUM(price) INTO totalAmount
    FROM cart
    WHERE orders_order_id = orderId;

    UPDATE orders
    SET order_total_amount = totalAmount
    WHERE order_id = orderId;

    UPDATE payment
    SET amount = totalAmount
    WHERE payment_id = (SELECT payment_payment_id
                        FROM orders
                        WHERE order_id = orderId);
END //

DELIMITER ;


-- Тест 2
select * from cart;
select * from orders;
select * from payment;

INSERT INTO cart (cart_id, orders_order_id, menu_position_id, quantity, price) VALUES
(17, 9, 1, 2, 0.00), (18, 9, 2, 1, 0.00), (19, 9, 3, 3, 0.00);

CALL UpdateOrderPrices(9);


