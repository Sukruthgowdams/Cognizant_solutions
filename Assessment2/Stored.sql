-- PLSQL_Exercises2.sql

-- Ensure you're using the right database
USE assignmentdb;

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS manage_employee_salary;

DELIMITER //

CREATE PROCEDURE manage_employee_salary(
    IN p_employee_id INT,
    IN p_action VARCHAR(10),
    IN p_percentage DECIMAL(5,2),
    OUT p_new_salary DECIMAL(10,2),
    OUT p_status VARCHAR(100)
)
BEGIN
    DECLARE current_salary DECIMAL(10,2);
    DECLARE employee_exists INT DEFAULT 0;
    
    -- Check if employee exists
    SELECT COUNT(*), salary 
    INTO employee_exists, current_salary 
    FROM employees 
    WHERE employee_id = p_employee_id;
    
    IF employee_exists = 0 THEN
        SET p_status = 'Employee not found';
        SET p_new_salary = 0;
    ELSE
        -- CASE statement for different actions
        CASE 
            WHEN p_action = 'INCREASE' THEN
                SET p_new_salary = current_salary * (1 + p_percentage/100);
                UPDATE employees 
                SET salary = p_new_salary 
                WHERE employee_id = p_employee_id;
                SET p_status = 'Salary increased successfully';
                
            WHEN p_action = 'DECREASE' THEN
                SET p_new_salary = current_salary * (1 - p_percentage/100);
                UPDATE employees 
                SET salary = p_new_salary 
                WHERE employee_id = p_employee_id;
                SET p_status = 'Salary decreased successfully';
                
            ELSE
                SET p_new_salary = current_salary;
                SET p_status = 'Invalid action. Use INCREASE or DECREASE';
        END CASE;
    END IF;
    
END //

DELIMITER ;

-- Test the stored procedure
CALL manage_employee_salary(1, 'INCREASE', 10, @new_sal, @status);
SELECT @new_sal AS new_salary, @status AS status;