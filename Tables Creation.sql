CREATE TABLE PHARMACIST (
        pharmacist_id INT PRIMARY KEY,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255) NOT NULL,
        date_of_birth DATE NOT NULL,
        gender VARCHAR(255) NOT NULL,
        address VARCHAR(255) NOT NULL,
        phone VARCHAR(255) NOT NULL UNIQUE,
        email VARCHAR(255) NOT NULL UNIQUE,
        password VARCHAR(255) NOT NULL
    )

CREATE TABLE DOCTOR (
        doctor_id INT PRIMARY KEY,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255) NOT NULL,
        speciality VARCHAR(255) NOT NULL,
        phone VARCHAR(255) NOT NULL UNIQUE, 
        email VARCHAR(255) NOT NULL UNIQUE
    )

CREATE TABLE CUSTOMER (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE
    )

CREATE TABLE MANUFACTURER (
    manufacturer_id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(255) UNIQUE
    )

CREATE TABLE MEDICINE (
    medicine_id INT PRIMARY KEY,
    manufacturer_id INT FOREIGN KEY REFERENCES MANUFACTURER(manufacturer_id),
    name VARCHAR(255),
    description VARCHAR(1000),
    category VARCHAR(255),
    price DECIMAL(10, 2)
    )

CREATE TABLE INVENTORY (
    medicine_id INT FOREIGN KEY REFERENCES MEDICINE(medicine_id),
    amount INT
    )

CREATE TABLE SALE (
    sale_id INT PRIMARY KEY,
    pharmacist_id INT FOREIGN KEY REFERENCES PHARMACIST(pharmacist_id),
    customer_id INT FOREIGN KEY REFERENCES CUSTOMER(customer_id),
    date DATE
    )

CREATE TABLE SALE_DETAIL (
    sale_id INT FOREIGN KEY REFERENCES SALE(sale_id),
    medicine_id INT FOREIGN KEY REFERENCES MEDICINE(medicine_id),
    amount INT,
    PRIMARY KEY(sale_id,medicine_id)
    )

CREATE TABLE PRESCRIPTION (
    prescription_id INT PRIMARY KEY,
    doctor_id INT FOREIGN KEY REFERENCES DOCTOR(doctor_id),
    customer_id INT FOREIGN KEY REFERENCES CUSTOMER(customer_id),
    date DATE
    )

CREATE TABLE PRESCRIPTION_DETAIL (
    prescription_id INT FOREIGN KEY REFERENCES PRESCRIPTION(prescription_id),
    medicine_id INT FOREIGN KEY REFERENCES MEDICINE(medicine_id),
    dosage INT,
    frequency VARCHAR,
    duration INT,
    PRIMARY KEY(prescription_id,medicine_id)
    )