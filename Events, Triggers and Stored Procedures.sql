SELECT *
FROM parks_and_recreation.employee_demographics;

SELECT *
FROM parks_and_recreation.employee_salary;

SELECT first_name,
last_name,
birth_date,
age,
(age+10)*10+10 
FROM parks_and_recreation.employee_demographics;
# PEMDAS The order for carrying out arithmetic operations in SQL

SELECT DISTINCT first_name,gender
FROM parks_and_recreation.employee_demographics;

-- STORED PROCEDURES
DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries2();

-- PARAMETERS IN A STORED PROCEDURE
DELIMITER $$
CREATE PROCEDURE large_salaries3(employee_id_param INT)
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 60000
AND employee_id = employee_id_param;
END $$
DELIMITER ;

CALL large_salaries3(1);

-- TRIGGERS
DELIMITER $$
CREATE TRIGGER employee_insert
	AFTER INSERT ON employee_salary
    FOR EACH ROW
BEGIN
	INSERT INTO employee_demographics (employee_id,first_name,last_name)
    VALUES(NEW.employee_id,NEW.first_name,NEW.last_name);
END $$
DELIMITER ;

-- TEST TO SEE IF THE TRIGGERS WORK
INSERT INTO employee_salary (employee_id,first_name,last_name,occupation, salary, dept_id)
VALUES(13,'Dominion','Joshua','Data Analyst',1000000,NULL);

-- EVENTS
DELIMITER $$
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE 
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;





