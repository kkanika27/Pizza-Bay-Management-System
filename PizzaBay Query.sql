-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD


Create database Pizzeria

USE Pizzeria

DROP TABLE IF EXISTS customers
CREATE TABLE customers (
    cust_id int  NOT NULL ,
    cust_firstname varchar(50)  NOT NULL ,
    cust_lastname varchar(50)  NOT NULL ,
    CONSTRAINT PK_customers PRIMARY KEY (
        cust_id
    )
)

DROP TABLE IF EXISTS address
CREATE TABLE address (
    add_id int  NOT NULL ,
    delivery_address1 varchar(200)  NOT NULL ,
    delivery_Address2 varchar(200)  NULL ,
    delivery_city varchar(50)  NOT NULL ,
    delivery_zipcode varchar(20)  NOT NULL ,
    CONSTRAINT PK_address PRIMARY KEY (
        add_id
    )
)

DROP TABLE IF EXISTS ingredient
CREATE TABLE ingredient (
    ing_id varchar(10)  NOT NULL ,
    ing_name varchar(200)  NOT NULL ,
    ing_weight int  NOT NULL ,
    ing_meas varchar(20)  NOT NULL ,
    ing_price decimal(5,2)  NOT NULL ,
    CONSTRAINT PK_ingredient PRIMARY KEY(
        ing_id
    )
)


DROP TABLE IF EXISTS inventory
CREATE TABLE inventory (
    inv_id int  NOT NULL ,
    item_id varchar(20)  NOT NULL UNIQUE,
    quantity int  NOT NULL ,
    CONSTRAINT PK_inventory PRIMARY KEY (
        inv_id
    )
)

DROP TABLE IF EXISTS recipe
CREATE TABLE recipe (
    row_id int  NOT NULL ,
    recipe_id varchar(20)  NOT NULL UNIQUE,
    ing_id varchar(10)  NOT NULL foreign key references ingredient(ing_id),
    quantity int  NOT NULL ,
    CONSTRAINT PK_recipe PRIMARY KEY (
        row_id 
    )
)

DROP TABLE IF EXISTS item
CREATE TABLE item (
    item_id varchar(10)  NOT NULL ,
    sku varchar(20)  NOT NULL foreign key references recipe(recipe_id),
	foreign key (sku) references inventory(item_id),
    item_name varchar(100)  NOT NULL ,
    item_cat varchar(100)  NOT NULL ,
    item_size varchar(10)  NOT NULL ,
    item_price decimal(10,2)  NOT NULL ,
    CONSTRAINT PK_item PRIMARY KEY (
        item_id
    )
)



DROP TABLE IF EXISTS sshift
CREATE TABLE sshift (
    shift_id varchar(20)  NOT NULL ,
    day_of_week varchar(10)  NOT NULL ,
    start_time time  NOT NULL ,
    end_time time  NOT NULL ,
    CONSTRAINT PK_shift PRIMARY KEY (
        shift_id 
    )
)

DROP TABLE IF EXISTS rota
CREATE TABLE rota (
    row_id int  NOT NULL ,
    rota_id varchar(20)  NOT NULL ,
    date datetime  NOT NULL UNIQUE ,
    shift_id varchar(20)  NOT NULL foreign key references sshift(shift_id),
    staff_id varchar(20)  NOT NULL UNIQUE,
    CONSTRAINT PK_rota PRIMARY KEY(
        row_id
    )
)

DROP TABLE IF EXISTS staff
CREATE TABLE staff (
    staff_id varchar(20)  NOT NULL foreign key references rota(staff_id),
    first_name varchar(50)  NOT NULL ,
    last_name varchar(50)  NOT NULL ,
    position varchar(100)  NOT NULL ,
    hourly_rate decimal(5,2)  NOT NULL ,
    CONSTRAINT PK_staff PRIMARY KEY (
        staff_id
    )
)

DROP TABLE IF EXISTS orders
CREATE TABLE orders (
    row_id int  NOT NULL ,
    order_id varchar(10)  NOT NULL ,
    created_at datetime  NOT NULL foreign key references rota(date),
    item_id varchar(10)  NOT NULL foreign key references item(item_id),
    quantity int  NOT NULL ,
    cust_id int  NOT NULL foreign key references customers(cust_id),
    delivery tinyint NOT NULL ,
    add_id int  NOT NULL foreign key references address(add_id),
    CONSTRAINT PK_orders PRIMARY KEY (
        row_id
    )
)






COMMIT TRANSACTION QUICKDBD