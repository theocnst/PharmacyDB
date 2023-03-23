/*CREATION OF DATABASE*/
IF NOT EXISTS(SELECT * FROM SYS.DATABASES WHERE NAME='PHARMACY ')
BEGIN
CREATE DATABASE PHARMACY
END

USE PHARMACY

/*CREATION OF TABLES*/
IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='PHARMACIST')
BEGIN
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
END

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='DOCTOR')
BEGIN
    CREATE TABLE DOCTOR (
        doctor_id INT PRIMARY KEY,
        first_name VARCHAR(255) NOT NULL,
        last_name VARCHAR(255) NOT NULL,
        speciality VARCHAR(255) NOT NULL,
        phone VARCHAR(255) NOT NULL UNIQUE, 
        email VARCHAR(255) NOT NULL UNIQUE
    )
END

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='CUSTOMER')
BEGIN
    CREATE TABLE CUSTOMER (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE
    )
END

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='MANUFACTURER')
BEGIN
    CREATE TABLE MANUFACTURER (
    manufacturer_id INT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(20) UNIQUE,
    email VARCHAR(255) UNIQUE
    )
END

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='MEDICINE')
BEGIN
    CREATE TABLE MEDICINE (
    medicine_id INT PRIMARY KEY,
    manufacturer_id INT FOREIGN KEY REFERENCES MANUFACTURER(manufacturer_id),
    name VARCHAR(255),
    description VARCHAR(1000),
    category VARCHAR(255),
    price DECIMAL(10, 2)
    )
END

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='INVENTORY')
BEGIN
    CREATE TABLE INVENTORY (
    medicine_id INT FOREIGN KEY REFERENCES MEDICINE(medicine_id),
    amount INT
    )
END

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='SALE')
BEGIN
    CREATE TABLE SALE (
    sale_id INT PRIMARY KEY,
    pharmacist_id INT FOREIGN KEY REFERENCES PHARMACIST(pharmacist_id),
    customer_id INT FOREIGN KEY REFERENCES CUSTOMER(customer_id),
    date DATE
    )
END

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='SALE_DETAIL')
BEGIN
    CREATE TABLE SALE_DETAIL (
    sale_id INT FOREIGN KEY REFERENCES SALE(sale_id),
    medicine_id INT FOREIGN KEY REFERENCES MEDICINE(medicine_id),
    amount INT,
    PRIMARY KEY(sale_id,medicine_id)
    )
END

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='PRESCRIPTION')
BEGIN
    CREATE TABLE PRESCRIPTION (
    prescription_id INT PRIMARY KEY,
    doctor_id INT FOREIGN KEY REFERENCES DOCTOR(doctor_id),
    customer_id INT FOREIGN KEY REFERENCES CUSTOMER(customer_id),
    date DATE
    )
END

IF NOT EXISTS(SELECT * FROM SYS.TABLES WHERE NAME='PRESCRIPTION_DETAIL')
BEGIN
    CREATE TABLE PRESCRIPTION_DETAIL (
    prescription_id INT FOREIGN KEY REFERENCES PRESCRIPTION(prescription_id),
    medicine_id INT FOREIGN KEY REFERENCES MEDICINE(medicine_id),
    dosage INT,
    frequency VARCHAR(50),
    duration INT,
    PRIMARY KEY(prescription_id,medicine_id)
    )
END

/*INSERTING INTO TABLES*/
IF NOT EXISTS (SELECT * FROM PHARMACIST)
BEGIN
	INSERT INTO PHARMACIST (pharmacist_id, first_name, last_name, date_of_birth, gender, address, phone, email, password)
    VALUES (1, 'John', 'Smith', '1980-01-01', 'male', '123 Main St', '+40723123456', 'john.smith@example.com','password1'),
            (2, 'Jane', 'Doe', '1985-02-02', 'female', '456 Park Ave', '+40721234567', 'jane.doe@example.com','password2'),
            (3, 'Bob', 'Johnson', '1990-03-03', 'male', '789 Elm St', '+40724345678', 'bob.johnson@example.com','password3'),
            (4, 'Emily', 'Williams', '1995-04-04', 'female', '321 Oak St', '+4072545678', 'emily.williams@example.com','password4'),
            (5, 'Michael', 'Brown', '2000-05-05', 'male', '159 Pine St', '+40726567890', 'michael.brown@example.com','password5')

    INSERT INTO CUSTOMER (customer_id, first_name, last_name, date_of_birth, gender, phone, email)
    VALUES (1, 'Jacob', 'Green', '1970-01-01', 'male', '+40727678901', 'jacob.green@example.com'),
            (2, 'Sophia', 'Lee', '1975-02-02', 'female', '+40728789012', 'sophia.lee@example.com'),
            (3, 'Mason', 'White', '1980-03-03', 'male', '+40729890123', 'mason.white@example.com'),
            (4, 'Isabella', 'Black', '1985-04-04', 'female', '+40720901234', 'isabella.black@example.com'),
            (5, 'William', 'Nash', '1990-05-05', 'male', '40731012345', 'william.nash@example.com')

    INSERT INTO DOCTOR (doctor_id, first_name, last_name, speciality, phone, email)
    VALUES (1, 'Alex', 'Johnson', 'Surgery', '+40732123456', 'alex.johnson@example.com'),
            (2, 'Sarah', 'Lee', 'Pediatrics', '+40733234567', 'sarah.lee@example.com'),
            (3, 'David', 'White', 'Cardiology', '+40734345678', 'david.white@example.com'),
            (4, 'Emily', 'Black', 'Obstetrics', '+40735456789', 'emily.black@example.com'),
            (5, 'Michael', 'Nash', 'Oncology', '+40736567890', 'michael.nash@example.com')

    INSERT INTO MANUFACTURER (manufacturer_id, name, address, phone, email)
    VALUES (1, 'Farmaceutica SRL', 'Bucuresti, Strada Ion Mihalache nr. 15', '+40211234567', 'office@farmaceutica.ro'),
            (2, 'Mediplus SRL', 'Timisoara, Bulevardul Eroilor nr. 25', '+40256123456', 'info@mediplus.ro'),
            (3, 'PharmaGrup SRL', 'Cluj-Napoca, Strada George Baritiu nr. 35', '+40264123456', 'contact@pharmagrup.ro'),
            (4, 'Biofarm SRL', 'Iasi, Strada Alexandru Lapusneanu nr. 45', '+40232123456', 'office@biofarm.ro'),
            (5, 'Farmacia Verde SRL', 'Brasov, Strada Republicii nr. 55', '+40268123456', 'info@farmaciaverde.ro')

    INSERT INTO MEDICINE (medicine_id, manufacturer_id, name, description, category, price) 
    VALUES (1, 1, 'Aspirin', 'Pain relief medication', 'Analgesic', 10.50),
            (2, 2, 'Ibuprofen', 'Pain relief and fever reduction medication', 'Analgesic', 8.99),
            (3, 3, 'Amoxicillin', 'Antibiotic for bacterial infections', 'Antibiotic', 15.75),
            (4, 4, 'Metformin', 'Oral medication for diabetes', 'Diabetes', 20.00),
            (5, 5, 'Acetaminophen', 'Pain relief medication', 'Analgesic', 5.50),
            (6, 1, 'Paracetamol', 'Pain relief medication', 'Analgesic', 6.50),
            (7, 2, 'Naproxen', 'Pain relief and fever reduction medication', 'Analgesic', 9.99),
            (8, 3, 'Doxycycline', 'Antibiotic for bacterial infections', 'Antibiotic', 16.75),
            (9, 4, 'Glipizide', 'Oral medication for diabetes', 'Diabetes', 22.00),
            (10, 5, 'Acetylsalicylic acid', 'Pain relief medication', 'Analgesic', 7.50)

    INSERT INTO INVENTORY (medicine_id, amount) 
    VALUES (1, 192),
            (2, 150),
            (3, 160),
            (4, 124),
            (5, 129),
            (6, 80),
            (7, 50),
            (8, 190),
            (9, 110),
            (10, 135)

    INSERT INTO SALE (sale_id, pharmacist_id, customer_id, date) 
    VALUES (1, 1, 1, '2021-01-01'),
            (2, 2, 2, '2021-02-01'),
            (3, 3, 3, '2021-03-01'),
            (4, 3, 4, '2021-04-01'),
            (5, 4, 5, '2021-05-01'),
            (6, 4, 1, '2021-06-01'),
            (7, 5, 2, '2021-07-01'),
            (8, 5, 1, '2021-08-01'),
            (9, 1, 4, '2021-09-01'),
            (10, 2, 3, '2021-10-01')

    INSERT INTO SALE_DETAIL (sale_id, medicine_id, amount) 
    VALUES (1, 1, 20),
            (1, 10, 40),
            (2, 2, 50),
            (2, 9, 15),
            (3, 3, 45),
            (3, 8, 25),
            (4, 4, 55),
            (4, 7, 30),
            (5, 5, 60),
            (5, 6, 10),
            (6, 6, 65),
            (6, 5, 10),
            (7, 7, 70),
            (7, 4, 20),
            (8, 8, 75),
            (8, 3, 15),
            (9, 9, 80),
            (9, 2, 25),
            (10, 10, 30),
            (10, 1, 85)

    INSERT INTO PRESCRIPTION (prescription_id, doctor_id, customer_id, date) 
    VALUES (1, 1, 1, '2021-01-01'),
            (2, 2, 2, '2021-02-01'),
            (3, 3, 3, '2021-03-01'),
            (4, 4, 4, '2021-04-01'),
            (5, 5, 5, '2021-05-01'),
            (6, 1, 5, '2021-06-01'),
            (7, 2, 4, '2021-07-01'),
            (8, 3, 3, '2021-08-01'),
            (9, 4, 2, '2021-09-01'),
            (10, 5, 1, '2021-10-01')

    INSERT INTO PRESCRIPTION_DETAIL (prescription_id, medicine_id, dosage, frequency, duration) 
    VALUES (1, 1, 1, 'twice a day', 10),
            (2, 2, 2, 'once a day', 15),
            (3, 3, 1, 'three times a day', 20),
            (4, 4, 2, 'twice a day', 25),
            (5, 5, 1, 'once a day', 30),
            (6, 1, 1, 'twice a day', 10),
            (6, 2, 2, 'once a day', 14),
            (7, 1, 1, 'three times a day', 5),
            (8, 4, 2, 'twice a day', 21),
            (9, 5, 1, 'once a day', 28),
            (1, 10, 2, 'once a day', 5),
            (10, 1, 1, 'twice a day', 14),
            (10, 2, 2, 'once a day', 7),
            (10, 3, 1, 'three times a day', 14),
            (7, 10, 2, 'twice a day', 21),
            (8, 10, 1, 'once a day', 14),
            (9, 8, 2, 'once a day', 14),
            (6, 3, 1, 'twice a day', 7),
            (9, 10, 2, 'once a day', 7),
            (9, 9, 1, 'three times a day', 21)
END

/*VIEWS*/

--A view that displays all the information for customers, including their name, date of birth, and contact information.
SELECT * FROM CustomerInfo

--A view that displays all the information for pharmacists, including their name and contact information, keeping private information hidden.
SELECT * FROM PharmacistPublicInfo

--A view that displays all the medicines manufactured by a specific manufacturer, including name, description, category and price.
SELECT * FROM ManufacturerMedicine

--A view that displays all the medicines available in the inventory, including their name, description, and price.
SELECT * FROM MedicineInventory

--A view that displays all the medicines that are out of stock, including their name and description.
SELECT * FROM OutOfStock

--A view that displays all the prescriptions for a specific doctor, including the customer's name, the medicine name, dosage, frequency and duration.
SELECT * FROM DoctorPrescription

--A view that displays all the prescriptions for a specific customer, including the doctor's name, the medicine name, dosage, frequency and duration.
SELECT * FROM CustomerPrescription

--A view that displays all the sales made on a specific date, including the customer's name and the medicine name, amount and total price.
SELECT * FROM DailySales

--A view that displays all the sales made on a specific month, including the customer's name and the medicine name, amount and total price.
SELECT * FROM MonthlySales

--A view that displays all the sales made by a specific pharmacist, including the customer's name and the medicine name, amount and total price.
SELECT * FROM PharmacistSales

--A view that displays the total sales made by a specific pharmacist, including their name and the total amount.
SELECT * FROM PharmacistSalesTotal

/*TRIGGERS*/

--A trigger that automatically updates the inventory when a sale is made.
CREATE TRIGGER UpdateInventory
ON SALE_DETAIL
AFTER INSERT
AS
BEGIN
    UPDATE INVENTORY
    SET INVENTORY.amount = INVENTORY.amount - INSERTED.amount
    FROM INVENTORY
    JOIN INSERTED
    ON INVENTORY.medicine_id = INSERTED.medicine_id
END

--A trigger to check if there is sufficient stock before a sale is made.
CREATE TRIGGER CheckStock
ON SALE_DETAIL
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @stock INT;
    SELECT @stock = INVENTORY.amount FROM INVENTORY WHERE INVENTORY.medicine_id = INSERTED.medicine_id;
    IF @stock < INSERTED.amount 
    BEGIN
        RAISERROR ('Insufficient stock', 16, 1);
        ROLLBACK;
    END;
    ELSE
    BEGIN
        INSERT INTO SALE_DETAIL (sale_id,medicine_id,amount) SELECT sale_id,medicine_id,amount FROM INSERTED;
    END;
END;

--A trigger to ensure that the date of birth of a CUSTOMER is not in the future.
CREATE TRIGGER ValidBirth
BEFORE INSERT ON CUSTOMER
FOR EACH ROW
BEGIN
    IF NEW.date_of_birth > GETDATE()
    BEGIN
        RAISERROR('Invalid date of birth.', 16, 1);
        ROLLBACK;
    END;
END;

--A trigger to prevent insertion of duplicate MEDICINE records.
CREATE TRIGGER PreventDuplicateMedicine
BEFORE INSERT ON MEDICINE
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT 1 FROM MEDICINE WHERE name = NEW.name AND manufacturer_id = NEW.manufacturer_id)
    BEGIN
        RAISERROR('This medicine already exists.', 16, 1);
        ROLLBACK;
    END;
END;

 /*FUNCTIONS*/

 --A function that returns the total sales made by a specific pharmacist for a given date range.
CREATE FUNCTION dbo.getPharmacistSalesByDateRange (@pharmacistID INT, @startDate DATE, @endDate DATE)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @totalSales DECIMAL(10, 2);
    SELECT @totalSales = SUM(SD.amount*M.price)
    FROM dbo.SALE S JOIN dbo.SALE_DETAIL SD ON S.sale_id = SD.sale_id
    JOIN dbo.MEDICINE M ON SD.medicine_id = M.medicine_id
    WHERE S.pharmacist_id = @pharmacistID AND S.date BETWEEN @startDate AND @endDate;
    RETURN @totalSales;
END;

--A function that returns the total number of prescriptions written by a specific doctor.
CREATE FUNCTION dbo.getPrescriptionCountByDoctor(@doctorID INT)
RETURNS INT
AS
BEGIN
    DECLARE @prescriptionCount INT;
    SELECT @prescriptionCount = COUNT(*) 
    FROM dbo.PRESCRIPTION
    WHERE doctor_id = @doctorID;
RETURN @prescriptionCount;
END;

--A function that returns the total amount of a specific medicine sold for a given date range.
CREATE FUNCTION dbo.getMedicineSalesByDateRange(@medicineID INT, @startDate DATE, @endDate DATE)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @totalSales DECIMAL(10, 2);
    SELECT @totalSales = SUM(SD.amount*M.price)
    FROM dbo.SALE S JOIN dbo.SALE_DETAIL SD ON S.sale_id = SD.sale_id
    JOIN dbo.MEDICINE M ON SD.medicine_id = M.medicine_id
    WHERE M.medicine_id = @medicineID AND S.date BETWEEN @startDate AND @endDate;
    RETURN @totalSales;
END;

SELECT dbo.getPrescriptionCountByDoctor(1)
SELECT dbo.getMedicineSalesByDateRange(1,'1980-01-01','2023-01-01')
SELECT dbo.getPharmacistSalesByDateRange (1, '1980-01-01','2023-01-01')

/*INDEX*/
CREATE INDEX idx_pharmacist_name ON PHARMACIST (first_name, last_name);
CREATE INDEX idx_medicine_name ON MEDICINE (name);
CREATE INDEX idx_sale_date ON SALE (date);

SELECT * FROM PHARMACIST WHERE first_name = 'Jane' AND last_name = 'Doe';
SELECT * FROM MEDICINE WHERE name = 'Aspirin';
SELECT * FROM SALE WHERE date BETWEEN '2000-01-01' AND '2022-12-31';

/*REPORTS*/

--Report of the total sales made by each pharmacist.
SELECT 
    p.first_name, p.last_name, 
    SUM(sd.amount) as total_sales
FROM SALE s
JOIN SALE_DETAIL sd ON s.sale_id = sd.sale_id
JOIN PHARMACIST p ON s.pharmacist_id = p.pharmacist_id
GROUP BY p.pharmacist_id,p.first_name,p.last_name
HAVING SUM(sd.amount) > 0
ORDER BY total_sales DESC;

--Report of the total sales of each medicine category.
SELECT 
    m.category, 
    SUM(sd.amount) as total_sales
FROM SALE_DETAIL sd
JOIN MEDICINE m ON sd.medicine_id = m.medicine_id
GROUP BY m.category
HAVING SUM(sd.amount) > 0
ORDER BY total_sales DESC;

--Report of the total sales made by each customer.
SELECT 
    c.first_name, c.last_name, 
    SUM(sd.amount) as total_sales
FROM SALE s
JOIN SALE_DETAIL sd ON s.sale_id = sd.sale_id
JOIN CUSTOMER c ON s.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(sd.amount) > 0
ORDER BY total_sales DESC
