-- LIBRARY MANAGEMENT SYSTEM --

CREATE DATABASE library;
USE library;
CREATE TABLE Branch
(
Branch_no VARCHAR(10) PRIMARY KEY,
Manager_id VARCHAR(10),
Branch_address VARCHAR(30),
Contact_no VARCHAR(15)
);
DESC branch;

CREATE TABLE Employee
(
Emp_id VARCHAR(10) PRIMARY KEY,
Emp_name VARCHAR(30),
Position VARCHAR(30),
Salary DECIMAL(10,2)
);
DESC employee;

CREATE TABLE Books
(
ISBN VARCHAR(25) PRIMARY KEY,
Book_title VARCHAR(80),
Category VARCHAR(30),
Rental_Price DECIMAL(10,2),
Status ENUM('Yes','No'),
Author VARCHAR(30),
Publisher VARCHAR(30)
);
DESC Books;

CREATE TABLE Customer
(
Customer_Id VARCHAR(10) PRIMARY KEY,
Customer_name VARCHAR(30),
Customer_address VARCHAR(30),
Reg_date DATE
);
DESC customer;

CREATE TABLE IssueStatus
(
Issue_Id VARCHAR(10) PRIMARY KEY,
Issued_cust VARCHAR(30),
Issued_book_name VARCHAR(80),
Issue_date DATE,
Isbn_book VARCHAR(25),
FOREIGN KEY (Issued_cust) REFERENCES customer(Customer_id) on DELETE CASCADE,
FOREIGN KEY (Isbn_book) REFERENCES books(ISBN) on DELETE CASCADE
);
DESC issuestatus;

CREATE TABLE ReturnStatus
(
Return_id VARCHAR(10) PRIMARY KEY,
Return_cust VARCHAR(30),
Return_book_name VARCHAR(80),
Return_date DATE,
isbn_book2 VARCHAR(25),
FOREIGN KEY (isbn_book2) REFERENCES books(ISBN) on DELETE CASCADE
);
DESC returnstatus;

INSERT INTO branch VALUES
('B100', 'M100', 'L1 Trivandrum', '8089484414'),
('B101', 'M101', 'L2  Kollam', '8848501165'),
('B102', 'M102', 'L3 Thrissur', '9037873998'),
('B103', 'M103', 'L4 EKM', '7012346589'),
('B104', 'M104', 'L5 PTA', '9447855644');
SELECT * FROM branch;

INSERT INTO employee VALUES
('E101', 'Sivan', 'Manager', 60000.00),
('E102', 'Jithendar', 'Clerk', 45000.00),
('E103', 'Malavika', 'Librarian', 55000.00),
('E104', 'Devayani' ,'Assistant', 40000.00),
('E105', 'Manju', 'Clerk', 42000.00),
('E106', 'Manu', 'Assistant', 43000.00);
INSERT INTO employee VALUES
('E107', 'Vidya', 'Cashier', 52000.00,'B101'),
('E108', 'Dharsana', 'Librarian',50000.00,'B101');

SELECT * FROM employee;

INSERT INTO books VALUES
('MAL1001', 'Indulekha', 'Novel', 100, 'yes', 'O.Chanthu Menon', 'DC Books'),
('MAL1002', 'Harryporter', 'Thriller', 75, 'yes', 'J K Rowling', 'Bloomsbery Publishing'),
('MAL1003', 'Ummachu', 'Novel', 60, 'yes', 'Uroob', 'DC Books'),
('MAL1004', 'Balyakalasakhi', 'Classic', 80, 'yes', 'Basheer', 'DC Books'),
('MAL1005', 'Veenapoov', 'Poetry', 50, 'yes', 'Kumaranasan', 'Mithavathi'),
('MAL1006','Hiroshima', 'History',100, 'yes', 'M. G. Sheftall' ,'John Hersey');


SELECT * FROM books;

INSERT INTO customer VALUES
('C100', 'Ramu', 'Rama Nilayam', '2021-12-30'),
('C101', 'Aswathy', 'NANDANAM', '2024-05-15'),
('C102', 'Shibu', 'SUMITHA HOUSE', '2024-06-20'),
('C103', 'JITHU', 'AMME NARAYANA', '2024-07-10'),
('C104', 'ANIL', 'SIVALAYAM', '2024-08-05'),
('C105', 'AMBILI', 'VAIKUNDAM', '2024-09-25');
SELECT * FROM CUSTOMER;

INSERT INTO IssueStatus VALUES
('IS101', 'C101', 'Indulekha', '2024-06-01', 'MAL1001'),
('IS102', 'C102', 'Harryporter', '2024-07-02', 'MAL1002'),
('IS103', 'C103', 'Ummachu', '2024-08-03', 'MAL1003'),
('IS104', 'C104', 'Balyakalasakhi', '2024-09-04', 'MAL1004'),
('IS105', 'C105', 'Veenapoov', '2023-06-04', 'MAL1005');
SELECT * FROM issuestatus;

INSERT INTO ReturnStatus VALUES
('RS101', 'C101', 'Indulekha', '2024-07-06', 'MAL1001'),
('RS102', 'C103', 'Ummachu', '2024-09-07','MAL1003'),
('RS103', 'C104', 'Balyakalasakhi', '2024-10-08', 'MAL1004');
SELECT * FROM returnstatus;

-- Qn 1

SELECT book_title, category, rental_price FROM books WHERE Status = 'Yes';

-- Qn 2

SELECT emp_name, salary FROM employee ORDER BY Salary DESC;

-- Qn 3

SELECT issuestatus.Issued_book_name, customer.Customer_name FROM issuestatus INNER JOIN
customer on issuestatus.Issued_cust = customer.Customer_Id;

-- Qn 4

SELECT Category, COUNT(Book_title) FROM books GROUP BY Category;

-- Qn 5

SELECT emp_name, position FROM employee WHERE Salary > 50000;

-- Qn 6

SELECT customer_name FROM customer WHERE Reg_date < '2022-01-01' AND Customer_Id NOT IN
(SELECT issued_cust FROM issuestatus);

-- Qn 7

ALTER TABLE employee ADD COLUMN branch_no VARCHAR(10);
ALTER TABLE employee ADD CONSTRAINT FOREIGN KEY (branch_no)
REFERENCES branch(branch_no);
DESC employee;

UPDATE employee SET branch_no = 'B101' WHERE emp_id ='E101';
UPDATE employee SET branch_no = 'B101' WHERE emp_id ='E102';
UPDATE employee SET branch_no = 'B101' WHERE emp_id ='E103';
UPDATE employee SET branch_no = 'B101' WHERE emp_id ='E104';
UPDATE employee SET branch_no = 'B102' WHERE emp_id ='E105';
UPDATE employee SET branch_no = 'B103' WHERE emp_id ='E106';
UPDATE employee SET branch_no = 'B101' WHERE emp_id ='E106';

SELECT Branch_no, COUNT(emp_id) FROM employee GROUP BY Branch_no;

-- Qn 8

SELECT customer.Customer_name FROM customer INNER JOIN issuestatus ON 
customer.Customer_Id = issuestatus.Issued_cust WHERE issuestatus.Issue_date >= '2023-06-01' AND 
issuestatus.Issue_date <= '2023-06-30';

-- Qn 9

SELECT book_title FROM books WHERE Category = 'history';

-- Qn 10

SELECT branch_no, COUNT(emp_id) FROM employee GROUP BY branch_no HAVING COUNT(Emp_id) > 5;

-- Qn 11

SELECT employee.Emp_name, branch.Branch_address
FROM Employee 
INNER JOIN Branch  ON employee.branch_no= branch.Branch_no
WHERE employee.Position = 'Manager'; 

-- Qn 12

SELECT customer.Customer_name from customer
inner join issuestatus on customer.Customer_Id=issuestatus.Issued_cust
inner join books on issuestatus.Isbn_book=books.ISBN
where books.Rental_Price>25;





