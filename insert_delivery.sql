-- Вставка данных в таблицу city
INSERT INTO city (city_id, city_name) VALUES
(1, 'Одинцово'),
(2, 'Видное'),
(3, 'Балашиха'),
(4, 'Мытищи'),
(5, 'Люберцы'),
(6, 'Подольск');

-- Вставка данных в таблицу street
INSERT INTO street (id_street, street_name, city_city_id) VALUES
(1, 'Молодежная', 1),
(2, 'Западная', 3),
(3, 'Садовая', 2),
(4, 'Волковская', 5),
(5, 'Фрунзе', 4),
(6, 'Климовская', 6);

-- Вставка данных в таблицу house
INSERT INTO house (id_house, house_num, street_id_street) VALUES
(1, 123, 1),
(2, 222, 1),
(3, 32, 3),
(4, 44, 4),
(5, 52, 2),
(6, 522, 3),
(7, 53, 5),
(8, 50, 1),
(9, 301, 1),
(10, 151, 1),
(11, 156, 6);

-- Вставка данных в таблицу apartment
INSERT INTO apartment (apartment_id, apartment_num, house_id_house) VALUES
(1, 10, 1),
(2, 102, 2),
(3, 103, 2),
(4, 104, 3),
(5, 1001, 4),
(6, 104, 5);

-- Вставка данных в таблицу client
INSERT INTO client (client_id, client_name, client_surname, phone_num, client_email) VALUES
(1, 'John', 'Doe', '1234567890', 'john.doe@example.com'),
(2, 'Jane', 'Smith', '0987654321', 'jane.smith@example.com'),
(3, 'Alice', 'Johnson', '1231231234', 'alice.johnson@example.com'),
(4, 'Bob', 'Brown', '4324324321', 'bob.brown@example.com'),
(5, 'Danya', 'Brown', '4324324321', 'danya.brown@example.com'),
(6, 'Charlie', 'Davis', '7777777566', 'charlie.davis@example.com'),
(7, 'Charl', 'Davis', '7828282882', 'charl.davis@example.com'),
(8, 'Arlie', 'Davis', '1234123412', 'arlie.davis@example.com'),
(9, 'Lie', 'Davis', '8238382188', 'lie.davis@example.com'),
(10, 'Eve', 'Wilson', '6786712389', 'eve.wilson@example.com'),
(11, 'Ivan', 'Wilson', '617862312389', 'ivan.wilson@example.com'),
(12, 'Ivan', 'Ivantey', '231241111389', 'ivan.wilson@gmail.com');

-- Вставка данных в таблицу address частный дом
INSERT INTO address (address_id, house_id_house, client_client_id) VALUES
(1, 6, 1),
(2, 7, 2),
(3, 8, 3),
(4, 9, 4),
(5, 10, 5),
(6, 11, 6);

-- Вставка данных в таблицу address квартира
INSERT INTO address (address_id, apartment_apartment_id, client_client_id) VALUES
(7, 1, 7),
(8, 2, 8),
(9, 3, 9),
(10, 4, 10),
(11, 5, 11),
(12, 6, 12);

-- Вставка данных в таблицу order_status
INSERT INTO order_status (order_status_id, order_status_name) VALUES
(1, 'В ожидании'),
(2, 'Обработка'),
(3, 'Отправлено'),
(4, 'Доставлено'),
(5, 'Проблема'),
(6, 'Отменено');

-- Вставка данных в таблицу orders
INSERT INTO orders (
	order_id, 
	order_date, 
	required_date, 
	address_address_id, 
	order_status_order_status_id, 
	client_client_id,
	order_total_amount
) VALUES
(1, "2024-12-02 16:51:00", "2024-12-02 17:51:00", 1, 1, 1, 0),
(2, "2024-12-02 16:20:23", "2024-12-02 17:20:23", 2, 1, 2, 0),
(3, "2024-11-05 16:37:23", "2024-11-05 17:37:23", 3, 4, 3, 0),
(4, "2024-10-06 11:20:23", "2024-10-06 12:20:23", 4, 4, 4, 0),
(5, "2024-05-01 13:30:50", "2024-05-01 14:30:50", 5, 4, 5, 0),
(6, "2024-05-22 19:20:23", "2024-05-22 20:20:23", 6, 5, 6, 0),
(7, "2024-12-02 16:37:23", "2024-12-02 17:37:23", 7, 3, 7, 0),
(8, "2024-12-02 16:37:23", "2024-12-02 18:37:23", 8, 3, 8, 0),
(9, "2024-12-02 16:37:23", "2024-12-02 19:37:23", 9, 3, 9, 0),
(10, "2024-12-02 16:37:23", "2024-12-02 17:37:23", 10, 2, 10, 0);

-- Вставка данных в таблицу category
INSERT INTO category (category_id, category_name) VALUES
(1, 'Пицца'),
(2, 'Бургер'),
(3, 'Салат'),
(4, 'Десерт'),
(5, 'Напиток'),
(6, 'Суши');

-- Вставка данных в таблицу supplier
INSERT INTO supplier (supplier_id, supplier_name) VALUES
(1, 'Pizza Hut'),
(2, 'Domino\'s'),
(3, 'McDonald\'s'),
(4, 'Burger King'),
(5, 'Dunkin\' Donuts'),
(6, 'Starbucks');

-- Вставка данных в таблицу dish
INSERT INTO dish (dish_id, dish_name, dish_description, dish_price, category_category_id, supplier_supplier_id) VALUES
(1, 'Маргарита', 'Классическая пицца', 1000, 1, 1),
(2, 'Пеперони', 'Пицца с пепперони', 1200, 1, 2),
(3, 'Салат Цезарь', 'Салат с курицей и соусом Цезарь', 800, 3, 3),
(4, 'Чизбургер', 'Бургер с сыром', 1500, 2, 4),
(5, 'Шоколадный торт', 'Вкусный шоколадный торт', 600, 4, 5),
(6, 'Капучино', 'кофе', 100, 5, 6);

-- Вставка данных в таблицу dish_cart
insert INTO cart (cart_id, orders_order_id, dish_dish_id, quantity) VALUES
(1, 1, 1, 2), (2, 1, 6, 1),
(3, 2, 2, 2), (4, 2, 3, 1), (5, 2, 1, 2),
(6, 3, 6, 2), (7, 3, 5, 1),
(8, 4, 3, 1),
(9, 5, 5, 1),
(10, 6, 2, 1),
(11, 7, 2, 2),
(12, 8, 4, 3),
(13, 9, 2, 1),
(14, 10, 5, 2);
