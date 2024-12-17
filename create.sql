create database Restaurant;
use Restaurant;

CREATE TABLE address (
    address_id             INTEGER NOT NULL,
    house_id_house         INTEGER,
    apartment_apartment_id INTEGER,
    client_client_id       INTEGER NOT NULL
);

ALTER TABLE address
    ADD CONSTRAINT arc_1
        CHECK ( ( ( house_id_house IS NOT NULL )
                  AND ( apartment_apartment_id IS NULL ) )
                OR ( ( apartment_apartment_id IS NOT NULL )
                     AND ( house_id_house IS NULL ) )
                OR ( ( house_id_house IS NULL )
                     AND ( apartment_apartment_id IS NULL ) ) );

CREATE UNIQUE INDEX address__idx ON
    address (
        house_id_house
    ASC );

CREATE UNIQUE INDEX address__idxv1 ON
    address (
        apartment_apartment_id
    ASC );

ALTER TABLE address ADD CONSTRAINT address_pk PRIMARY KEY ( address_id );

CREATE TABLE apartment (
    apartment_id       INTEGER NOT NULL,
    apartment_num      INTEGER NOT NULL,
    house_id_house     INTEGER NOT NULL,
    address_address_id INTEGER
);

CREATE UNIQUE INDEX apartment__idx ON
    apartment (
        address_address_id
    ASC );

ALTER TABLE apartment ADD CONSTRAINT apartment_pk PRIMARY KEY ( apartment_id );

CREATE TABLE banquet_hall (
    id                       INTEGER NOT NULL,
    restaurant_restaurant_id INTEGER NOT NULL,
    capacity                 INTEGER NOT NULL
);

ALTER TABLE banquet_hall ADD CONSTRAINT banquet_hall_pk PRIMARY KEY ( id );

CREATE TABLE booking (
    booking_id       INTEGER NOT NULL,
    booking_date     DATETIME NOT NULL,
    num_guests       INTEGER NOT NULL,
    client_client_id INTEGER NOT NULL,
    tables_table_id  INTEGER,
    event_event_id   INTEGER
);

ALTER TABLE booking ADD CONSTRAINT booking_pk PRIMARY KEY ( booking_id );

CREATE TABLE cart (
    cart_id          INTEGER NOT NULL,
    orders_order_id  INTEGER NOT NULL,
    menu_position_id INTEGER NOT NULL,
    quantity         INTEGER NOT NULL,
    price            DECIMAL(9, 2) NOT NULL
);

ALTER TABLE cart ADD CONSTRAINT cart_pk PRIMARY KEY ( cart_id );

CREATE TABLE category (
    category_id   INTEGER NOT NULL,
    category_name VARCHAR(30) NOT NULL
);

ALTER TABLE category ADD CONSTRAINT category_pk PRIMARY KEY ( category_id );

CREATE TABLE city (
    city_id            INTEGER NOT NULL,
    city_name          VARCHAR(30) NOT NULL,
    country_country_id INTEGER NOT NULL
);

ALTER TABLE city ADD CONSTRAINT city_pk PRIMARY KEY ( city_id );

CREATE TABLE client (
    client_id          INTEGER NOT NULL,
    client_name        VARCHAR(30) NOT NULL,
    client_surname     VARCHAR(30) NOT NULL,
    client_email       VARCHAR(255),
    telephone_phone_id INTEGER NOT NULL
);

CREATE UNIQUE INDEX client__idx ON
    client (
        telephone_phone_id
    ASC );

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( client_id );

CREATE TABLE country (
    country_id   INTEGER NOT NULL,
    country_name VARCHAR(30) NOT NULL
);

ALTER TABLE country ADD CONSTRAINT country_pk PRIMARY KEY ( country_id );

CREATE TABLE diploma (
    diploma_id           INTEGER NOT NULL,
    diploma_series       VARCHAR(50) NOT NULL,
    diploma_num          VARCHAR(50) NOT NULL,
    employee_employee_id INTEGER NOT NULL
);

ALTER TABLE diploma ADD CONSTRAINT diploma_pk PRIMARY KEY ( diploma_id );

CREATE TABLE education_level (
    id                 INTEGER NOT NULL,
    education_level    VARCHAR(50) NOT NULL,
    diploma_diploma_id INTEGER NOT NULL
);

ALTER TABLE education_level ADD CONSTRAINT education_level_pk PRIMARY KEY ( id );

CREATE TABLE educational_institution (
    id                 INTEGER NOT NULL,
    name               VARCHAR(30) NOT NULL,
    diploma_diploma_id INTEGER NOT NULL
);

ALTER TABLE educational_institution ADD CONSTRAINT educational_institution_pk PRIMARY KEY ( id );

CREATE TABLE employee (
    employee_id              INTEGER NOT NULL,
    name                     VARCHAR(30) NOT NULL,
    last_name                VARCHAR(30) NOT NULL,
    surname                  VARCHAR(30),
    gender                   VARCHAR(1) NOT NULL,
    role                     VARCHAR(30) NOT NULL,
    telephone_phone_id       INTEGER NOT NULL,
    restaurant_restaurant_id INTEGER NOT NULL
);

CREATE UNIQUE INDEX employee__idx ON
    employee (
        telephone_phone_id
    ASC );

ALTER TABLE employee ADD CONSTRAINT employee_pk PRIMARY KEY ( employee_id );

CREATE TABLE event (
    event_id        INTEGER NOT NULL,
    event_name      VARCHAR(30) NOT NULL,
    description     VARCHAR(255) NOT NULL,
    date_start      DATETIME NOT NULL,
    date_end        DATETIME NOT NULL,
    banquet_hall_id INTEGER NOT NULL
);

ALTER TABLE event ADD CONSTRAINT event_pk PRIMARY KEY ( event_id );

CREATE TABLE house (
    id_house           INTEGER NOT NULL,
    house_num          INTEGER NOT NULL,
    street_id_street   INTEGER NOT NULL,
    address_address_id INTEGER
);

CREATE UNIQUE INDEX house__idx ON
    house (
        address_address_id
    ASC );

ALTER TABLE house ADD CONSTRAINT house_pk PRIMARY KEY ( id_house );

CREATE TABLE ingredient (
    ingredient_id INTEGER NOT NULL,
    name          VARCHAR(30) NOT NULL,
    unit          VARCHAR(30) NOT NULL
);

ALTER TABLE ingredient ADD CONSTRAINT ingredient_pk PRIMARY KEY ( ingredient_id );

CREATE TABLE instructions (
    instruction_id INTEGER NOT NULL,
    instructions   VARCHAR(1024) NOT NULL
);

ALTER TABLE instructions ADD CONSTRAINT instructions_pk PRIMARY KEY ( instruction_id );

CREATE TABLE menu (
    position_id          INTEGER NOT NULL,
    position_name        VARCHAR(30) NOT NULL,
    position_description VARCHAR(255) NOT NULL,
    position_price       DECIMAL(9, 2) NOT NULL,
    category_category_id INTEGER NOT NULL
);

ALTER TABLE menu ADD CONSTRAINT menu_pk PRIMARY KEY ( position_id );

CREATE TABLE order_status (
    order_status_id   INTEGER NOT NULL,
    order_status_name VARCHAR(30) NOT NULL
);

ALTER TABLE order_status ADD CONSTRAINT order_status_pk PRIMARY KEY ( order_status_id );

CREATE TABLE orders (
    order_id                     INTEGER NOT NULL,
    order_date                   DATETIME NOT NULL,
    required_date                DATETIME NOT NULL,
    order_total_amount           INTEGER NOT NULL,
    address_address_id           INTEGER,
    order_status_order_status_id INTEGER NOT NULL,
    client_client_id             INTEGER NOT NULL,
    payment_payment_id           INTEGER NOT NULL
);

CREATE UNIQUE INDEX orders__idx ON
    orders (
        payment_payment_id
    ASC );

ALTER TABLE orders ADD CONSTRAINT orders_pk PRIMARY KEY ( order_id );

CREATE TABLE payment (
    payment_id     INTEGER NOT NULL,
    payment_date   DATETIME NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    amount         DECIMAL(9, 2) NOT NULL
);

ALTER TABLE payment ADD CONSTRAINT payment_pk PRIMARY KEY ( payment_id );

CREATE TABLE purchasing_ingredients (
    purchase_id                 INTEGER NOT NULL,
    ingredient_ingredient_id    INTEGER NOT NULL,
    supplier_supplier_id        INTEGER NOT NULL,
    quantity                    DECIMAL(9, 2) NOT NULL,
    price                       DECIMAL(9, 2) NOT NULL,
    purchasing_ingredients_date DATETIME NOT NULL
);

ALTER TABLE purchasing_ingredients ADD CONSTRAINT purchasing_ingredients_pk PRIMARY KEY ( purchase_id );

CREATE TABLE qualification (
    qualification_id   INTEGER NOT NULL,
    qualification_name VARCHAR(50) NOT NULL,
    diploma_diploma_id INTEGER NOT NULL
);

ALTER TABLE qualification ADD CONSTRAINT qualification_pk PRIMARY KEY ( qualification_id );

CREATE TABLE recipe (
    recipe_id                   INTEGER NOT NULL,
    menu_position_id            INTEGER NOT NULL,
    ingredient_ingredient_id    INTEGER NOT NULL,
    instructions_instruction_id INTEGER NOT NULL,
    quantity                    DECIMAL(9, 2) NOT NULL
);

ALTER TABLE recipe ADD CONSTRAINT recipe_pk PRIMARY KEY ( recipe_id );

CREATE TABLE restaurant (
    restaurant_id      INTEGER NOT NULL,
    restaurant_name    VARCHAR(30) NOT NULL,
    house_id_house     INTEGER NOT NULL,
    telephone_phone_id INTEGER NOT NULL
);

CREATE UNIQUE INDEX restaurant__idx ON
    restaurant (
        house_id_house
    ASC );

CREATE UNIQUE INDEX restaurant__idxv1 ON
    restaurant (
        telephone_phone_id
    ASC );

ALTER TABLE restaurant ADD CONSTRAINT restaurant_pk PRIMARY KEY ( restaurant_id );

CREATE TABLE schedule (
    schedule_id          INTEGER NOT NULL,
    shift_start          TIME NOT NULL,
    shift_end            TIME NOT NULL,
    week_day             VARCHAR(30) NOT NULL,
    employee_employee_id INTEGER NOT NULL
);

ALTER TABLE schedule ADD CONSTRAINT schedule_pk PRIMARY KEY ( schedule_id );

CREATE TABLE speciality (
    speciality_id      INTEGER NOT NULL,
    speciality_name    VARCHAR(50) NOT NULL,
    speciality_code    VARCHAR(30),
    diploma_diploma_id INTEGER NOT NULL
);

ALTER TABLE speciality ADD CONSTRAINT speciality_pk PRIMARY KEY ( speciality_id );

CREATE TABLE street (
    id_street    INTEGER NOT NULL,
    street_name  VARCHAR(30) NOT NULL,
    city_city_id INTEGER NOT NULL
);

ALTER TABLE street ADD CONSTRAINT street_pk PRIMARY KEY ( id_street );

CREATE TABLE supplier (
    supplier_id   INTEGER NOT NULL,
    supplier_name VARCHAR(30) NOT NULL
);

ALTER TABLE supplier ADD CONSTRAINT supplier_pk PRIMARY KEY ( supplier_id );

CREATE TABLE tables (
    table_id                 INTEGER NOT NULL,
    restaurant_restaurant_id INTEGER NOT NULL,
    table_num                INTEGER NOT NULL,
    capacity                 INTEGER NOT NULL
);

ALTER TABLE tables ADD CONSTRAINT tables_pk PRIMARY KEY ( table_id );

CREATE TABLE telephone (
    phone_id  INTEGER NOT NULL,
    phone_num VARCHAR(30) NOT NULL
);

ALTER TABLE telephone ADD CONSTRAINT telephone_pk PRIMARY KEY ( phone_id );

CREATE TABLE warehouse (
    id                       INTEGER NOT NULL,
    ingredient_ingredient_id INTEGER NOT NULL,
    quantity                 DECIMAL(9, 2) NOT NULL
);

CREATE UNIQUE INDEX warehouse__idx ON
    warehouse (
        ingredient_ingredient_id
    ASC );

ALTER TABLE warehouse ADD CONSTRAINT warehouse_pk PRIMARY KEY ( id );

ALTER TABLE address
    ADD CONSTRAINT address_apartment_fk FOREIGN KEY ( apartment_apartment_id )
        REFERENCES apartment ( apartment_id );

ALTER TABLE address
    ADD CONSTRAINT address_client_fk
        FOREIGN KEY ( client_client_id )
            REFERENCES client ( client_id )
                ON DELETE CASCADE;

ALTER TABLE address
    ADD CONSTRAINT address_house_fk FOREIGN KEY ( house_id_house )
        REFERENCES house ( id_house );

ALTER TABLE apartment
    ADD CONSTRAINT apartment_address_fk FOREIGN KEY ( address_address_id )
        REFERENCES address ( address_id );

ALTER TABLE apartment
    ADD CONSTRAINT apartment_house_fk FOREIGN KEY ( house_id_house )
        REFERENCES house ( id_house );

ALTER TABLE banquet_hall
    ADD CONSTRAINT banquet_hall_restaurant_fk
        FOREIGN KEY ( restaurant_restaurant_id )
            REFERENCES restaurant ( restaurant_id )
                ON DELETE CASCADE;

ALTER TABLE booking
    ADD CONSTRAINT booking_client_fk
        FOREIGN KEY ( client_client_id )
            REFERENCES client ( client_id )
                ON DELETE CASCADE;

ALTER TABLE booking
    ADD CONSTRAINT booking_event_fk FOREIGN KEY ( event_event_id )
        REFERENCES event ( event_id );

ALTER TABLE booking
    ADD CONSTRAINT booking_tables_fk FOREIGN KEY ( tables_table_id )
        REFERENCES tables ( table_id );

ALTER TABLE cart
    ADD CONSTRAINT cart_menu_fk
        FOREIGN KEY ( menu_position_id )
            REFERENCES menu ( position_id )
                ON DELETE CASCADE;

ALTER TABLE cart
    ADD CONSTRAINT cart_orders_fk
        FOREIGN KEY ( orders_order_id )
            REFERENCES orders ( order_id )
                ON DELETE CASCADE;

ALTER TABLE city
    ADD CONSTRAINT city_country_fk FOREIGN KEY ( country_country_id )
        REFERENCES country ( country_id );

ALTER TABLE client
    ADD CONSTRAINT client_telephone_fk FOREIGN KEY ( telephone_phone_id )
        REFERENCES telephone ( phone_id );

ALTER TABLE diploma
    ADD CONSTRAINT diploma_employee_fk
        FOREIGN KEY ( employee_employee_id )
            REFERENCES employee ( employee_id )
                ON DELETE CASCADE;

ALTER TABLE education_level
    ADD CONSTRAINT education_level_diploma_fk FOREIGN KEY ( diploma_diploma_id )
        REFERENCES diploma ( diploma_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE educational_institution
    ADD CONSTRAINT educational_institution_diploma_fk FOREIGN KEY ( diploma_diploma_id )
        REFERENCES diploma ( diploma_id );

ALTER TABLE employee
    ADD CONSTRAINT employee_restaurant_fk FOREIGN KEY ( restaurant_restaurant_id )
        REFERENCES restaurant ( restaurant_id );

ALTER TABLE employee
    ADD CONSTRAINT employee_telephone_fk FOREIGN KEY ( telephone_phone_id )
        REFERENCES telephone ( phone_id );

ALTER TABLE event
    ADD CONSTRAINT event_banquet_hall_fk FOREIGN KEY ( banquet_hall_id )
        REFERENCES banquet_hall ( id );

ALTER TABLE house
    ADD CONSTRAINT house_address_fk FOREIGN KEY ( address_address_id )
        REFERENCES address ( address_id );

ALTER TABLE house
    ADD CONSTRAINT house_street_fk FOREIGN KEY ( street_id_street )
        REFERENCES street ( id_street );

ALTER TABLE menu
    ADD CONSTRAINT menu_category_fk FOREIGN KEY ( category_category_id )
        REFERENCES category ( category_id );

ALTER TABLE orders
    ADD CONSTRAINT orders_address_fk FOREIGN KEY ( address_address_id )
        REFERENCES address ( address_id );

ALTER TABLE orders
    ADD CONSTRAINT orders_client_fk FOREIGN KEY ( client_client_id )
        REFERENCES client ( client_id );

ALTER TABLE orders
    ADD CONSTRAINT orders_order_status_fk FOREIGN KEY ( order_status_order_status_id )
        REFERENCES order_status ( order_status_id );

ALTER TABLE orders
    ADD CONSTRAINT orders_payment_fk
        FOREIGN KEY ( payment_payment_id )
            REFERENCES payment ( payment_id )
                ON DELETE CASCADE;

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE purchasing_ingredients
    ADD CONSTRAINT purchasing_ingredients_ingredient_fk FOREIGN KEY ( ingredient_ingredient_id )
        REFERENCES ingredient ( ingredient_id );

--  ERROR: FK name length exceeds maximum allowed length(30) 
ALTER TABLE purchasing_ingredients
    ADD CONSTRAINT purchasing_ingredients_supplier_fk FOREIGN KEY ( supplier_supplier_id )
        REFERENCES supplier ( supplier_id );

ALTER TABLE qualification
    ADD CONSTRAINT qualification_diploma_fk FOREIGN KEY ( diploma_diploma_id )
        REFERENCES diploma ( diploma_id );

ALTER TABLE recipe
    ADD CONSTRAINT recipe_ingredient_fk FOREIGN KEY ( ingredient_ingredient_id )
        REFERENCES ingredient ( ingredient_id );

ALTER TABLE recipe
    ADD CONSTRAINT recipe_instructions_fk FOREIGN KEY ( instructions_instruction_id )
        REFERENCES instructions ( instruction_id );

ALTER TABLE recipe
    ADD CONSTRAINT recipe_menu_fk
        FOREIGN KEY ( menu_position_id )
            REFERENCES menu ( position_id )
                ON DELETE CASCADE;

ALTER TABLE restaurant
    ADD CONSTRAINT restaurant_house_fk FOREIGN KEY ( house_id_house )
        REFERENCES house ( id_house );

ALTER TABLE restaurant
    ADD CONSTRAINT restaurant_telephone_fk FOREIGN KEY ( telephone_phone_id )
        REFERENCES telephone ( phone_id );

ALTER TABLE schedule
    ADD CONSTRAINT schedule_employee_fk
        FOREIGN KEY ( employee_employee_id )
            REFERENCES employee ( employee_id )
                ON DELETE CASCADE;

ALTER TABLE speciality
    ADD CONSTRAINT speciality_diploma_fk FOREIGN KEY ( diploma_diploma_id )
        REFERENCES diploma ( diploma_id );

ALTER TABLE street
    ADD CONSTRAINT street_city_fk FOREIGN KEY ( city_city_id )
        REFERENCES city ( city_id );

ALTER TABLE tables
    ADD CONSTRAINT tables_restaurant_fk
        FOREIGN KEY ( restaurant_restaurant_id )
            REFERENCES restaurant ( restaurant_id )
                ON DELETE CASCADE;

ALTER TABLE warehouse
    ADD CONSTRAINT warehouse_ingredient_fk FOREIGN KEY ( ingredient_ingredient_id )
        REFERENCES ingredient ( ingredient_id );