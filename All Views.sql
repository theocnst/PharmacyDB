
--A view that displays all the information for customers, including their name, date of birth, and contact information.
CREATE VIEW CustomerInfo AS 
    SELECT first_name, last_name, date_of_birth, gender, phone, email 
    FROM CUSTOMER;

--A view that displays all the information for pharmacists, including their name and contact information, keeping private information hidden.
CREATE VIEW PharmacistPublicInfo AS
    SELECT pharmacist_id, first_name, last_name, phone, email
    FROM PHARMACIST;

--A view that displays all the medicines manufactured by a specific manufacturer, including name, description, category and price.
CREATE VIEW ManufacturerMedicine AS
    SELECT M.name, M.description, M.category, M.price
    FROM MEDICINE M JOIN MANUFACTURER MN ON M.manufacturer_id = MN.manufacturer_id;

--A view that displays all the medicines available in the inventory, including their name, description, and price.
CREATE VIEW MedicineInventory AS 
    SELECT M.name, M.description, M.price, I.amount
    FROM MEDICINE M JOIN INVENTORY I ON M.medicine_id = I.medicine_id;

--A view that displays all the medicines that are out of stock, including their name and description.
CREATE VIEW OutOfStock AS
    SELECT M.name, M.description
    FROM MEDICINE M JOIN INVENTORY I ON M.medicine_id = I.medicine_id
    WHERE I.amount = 0;

--A view that displays all the prescriptions for a specific doctor, including the customer's name, the medicine name, dosage, frequency and duration.
CREATE VIEW DoctorPrescription AS 
    SELECT P.doctor_id, C.first_name, C.last_name,  PD.medicine_id, M.name, PD.dosage, PD.frequency, PD.duration
    FROM PRESCRIPTION P JOIN PRESCRIPTION_DETAIL PD ON P.prescription_id = PD.prescription_id 
    JOIN CUSTOMER C ON P.customer_id = C.customer_id 
    JOIN MEDICINE M ON PD.medicine_id = M.medicine_id;

--A view that displays all the prescriptions for a specific customer, including the doctor's name, the medicine name, dosage, frequency and duration.
CREATE VIEW CustomerPrescription AS 
    SELECT P.customer_id, D.first_name, D.last_name,  PD.medicine_id, M.name, PD.dosage, PD.frequency, PD.duration
    FROM PRESCRIPTION P JOIN PRESCRIPTION_DETAIL PD ON P.prescription_id = PD.prescription_id 
    JOIN DOCTOR D ON P.doctor_id = D.doctor_id 
    JOIN MEDICINE M ON PD.medicine_id = M.medicine_id;

--A view that displays all the sales made on a specific date, including the customer's name and the medicine name, amount and total price.
CREATE VIEW DailySales AS
    SELECT S.date, C.first_name, C.last_name, SD.medicine_id, M.name, SD.amount, (SD.amount*M.price) as total_price 
    FROM SALE S JOIN SALE_DETAIL SD ON S.sale_id = SD.sale_id
    JOIN CUSTOMER C ON S.customer_id = C.customer_id
    JOIN MEDICINE M ON SD.medicine_id = M.medicine_id;

--A view that displays all the sales made on a specific month, including the customer's name and the medicine name, amount and total price.
CREATE VIEW MonthlySales AS
    SELECT MONTH(S.date) as month, C.first_name, C.last_name, SD.medicine_id, M.name, SD.amount, (SD.amount*M.price) as total_price 
    FROM SALE S JOIN SALE_DETAIL SD ON S.sale_id = SD.sale_id
    JOIN CUSTOMER C ON S.customer_id = C.customer_id
    JOIN MEDICINE M ON SD.medicine_id = M.medicine_id;

--A view that displays all the sales made by a specific pharmacist, including the customer's name and the medicine name, amount and total price.
CREATE VIEW PharmacistSales AS
    SELECT S.pharmacist_id, C.first_name, C.last_name, SD.medicine_id, M.name, SD.amount, (SD.amount*M.price) as total_price 
    FROM SALE S JOIN SALE_DETAIL SD ON S.sale_id = SD.sale_id
    JOIN CUSTOMER C ON S.customer_id = C.customer_id
    JOIN MEDICINE M ON SD.medicine_id = M.medicine_id;

--A view that displays the total sales made by a specific pharmacist, including their name and the total amount.
CREATE VIEW PharmacistSalesTotal AS
    SELECT P.first_name, P.last_name, SUM(SD.amount*M.price) as total_sales
    FROM SALE S JOIN SALE_DETAIL SD ON S.sale_id = SD.sale_id
    JOIN PHARMACIST P ON S.pharmacist_id = P.pharmacist_id
    JOIN MEDICINE M ON SD.medicine_id = M.medicine_id
    GROUP BY P.first_name, P.last_name, S.pharmacist_id;
