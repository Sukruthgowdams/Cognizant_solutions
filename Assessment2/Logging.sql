CREATE TABLE IF NOT EXISTS application_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    log_level ENUM('TRACE', 'DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL'),
    logger_name VARCHAR(100),
    log_message TEXT,
    exception_stack TEXT,
    thread_name VARCHAR(50) DEFAULT 'main',
    class_name VARCHAR(100),
    method_name VARCHAR(100),
    line_number INT,
    log_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_log_level (log_level),
    INDEX idx_timestamp (log_timestamp),
    INDEX idx_logger (logger_name)
);

DELIMITER //

-- Logger factory equivalent
CREATE PROCEDURE get_logger(
    IN class_name VARCHAR(100),
    OUT logger_name VARCHAR(100)
)
BEGIN
    SET logger_name = class_name;
END //

-- Different logging levels
CREATE PROCEDURE log_trace(
    IN logger VARCHAR(100),
    IN message TEXT,
    IN method_name VARCHAR(100)
)
BEGIN
    INSERT INTO application_logs (log_level, logger_name, log_message, method_name)
    VALUES ('TRACE', logger, message, method_name);
END //

CREATE PROCEDURE log_debug(
    IN logger VARCHAR(100),
    IN message TEXT,
    IN method_name VARCHAR(100)
)
BEGIN
    INSERT INTO application_logs (log_level, logger_name, log_message, method_name)
    VALUES ('DEBUG', logger, message, method_name);
END //

CREATE PROCEDURE log_info(
    IN logger VARCHAR(100),
    IN message TEXT,
    IN method_name VARCHAR(100)
)
BEGIN
    INSERT INTO application_logs (log_level, logger_name, log_message, method_name)
    VALUES ('INFO', logger, message, method_name);
END //

CREATE PROCEDURE log_warn(
    IN logger VARCHAR(100),
    IN message TEXT,
    IN method_name VARCHAR(100)
)
BEGIN
    INSERT INTO application_logs (log_level, logger_name, log_message, method_name)
    VALUES ('WARN', logger, message, method_name);
END //

CREATE PROCEDURE log_error(
    IN logger VARCHAR(100),
    IN message TEXT,
    IN method_name VARCHAR(100),
    IN exception_details TEXT
)
BEGIN
    INSERT INTO application_logs (log_level, logger_name, log_message, method_name, exception_stack)
    VALUES ('ERROR', logger, message, method_name, exception_details);
END //

CREATE PROCEDURE log_fatal(
    IN logger VARCHAR(100),
    IN message TEXT,
    IN method_name VARCHAR(100),
    IN exception_details TEXT
)
BEGIN
    INSERT INTO application_logs (log_level, logger_name, log_message, method_name, exception_stack)
    VALUES ('FATAL', logger, message, method_name, exception_details);
END //

-- Example service with comprehensive logging
CREATE PROCEDURE employee_service_with_logging(
    IN operation VARCHAR(20),
    IN emp_id INT,
    IN emp_data JSON
)
BEGIN
    DECLARE logger_name VARCHAR(100);
    DECLARE emp_exists INT DEFAULT 0;
    DECLARE operation_result VARCHAR(200);
    
    CALL get_logger('com.company.service.EmployeeService', logger_name);
    
    CALL log_info(logger_name, CONCAT('Starting employee operation: ', operation, ' for ID: ', emp_id), 'employee_service_with_logging');
    
    -- Check if employee exists
    SELECT COUNT(*) INTO emp_exists FROM employees WHERE employee_id = emp_id;
    CALL log_debug(logger_name, CONCAT('Employee existence check result: ', emp_exists), 'employee_service_with_logging');
    
    CASE operation
        WHEN 'CREATE' THEN
            IF emp_exists > 0 THEN
                CALL log_warn(logger_name, CONCAT('Attempting to create employee with existing ID: ', emp_id), 'employee_service_with_logging');
                SET operation_result = 'Employee already exists';
            ELSE
                -- Simulate create operation
                INSERT INTO employees (employee_id, first_name, last_name, salary, department_id)
                VALUES (emp_id, 
                       JSON_UNQUOTE(JSON_EXTRACT(emp_data, '$.firstName')),
                       JSON_UNQUOTE(JSON_EXTRACT(emp_data, '$.lastName')),
                       JSON_UNQUOTE(JSON_EXTRACT(emp_data, '$.salary')),
                       JSON_UNQUOTE(JSON_EXTRACT(emp_data, '$.departmentId')));
                       
                CALL log_info(logger_name, CONCAT('Successfully created employee: ', emp_id), 'employee_service_with_logging');
                SET operation_result = 'Employee created successfully';
            END IF;
            
        WHEN 'UPDATE' THEN
            IF emp_exists = 0 THEN
                CALL log_error(logger_name, CONCAT('Attempting to update non-existent employee: ', emp_id), 'employee_service_with_logging', 'EmployeeNotFoundException');
                SET operation_result = 'Employee not found';
            ELSE
                -- Simulate update operation
                UPDATE employees 
                SET salary = JSON_UNQUOTE(JSON_EXTRACT(emp_data, '$.salary'))
                WHERE employee_id = emp_id;
                
                CALL log_info(logger_name, CONCAT('Successfully updated employee: ', emp_id), 'employee_service_with_logging');
                SET operation_result = 'Employee updated successfully';
            END IF;
            
        WHEN 'DELETE' THEN
            IF emp_exists = 0 THEN
                CALL log_warn(logger_name, CONCAT('Attempting to delete non-existent employee: ', emp_id), 'employee_service_with_logging');
                SET operation_result = 'Employee not found';
            ELSE
                DELETE FROM employees WHERE employee_id = emp_id;
                CALL log_info(logger_name, CONCAT('Successfully deleted employee: ', emp_id), 'employee_service_with_logging');
                SET operation_result = 'Employee deleted successfully';
            END IF;
            
        ELSE
            CALL log_fatal(logger_name, CONCAT('Invalid operation requested: ', operation), 'employee_service_with_logging', 'InvalidOperationException');
            SET operation_result = 'Invalid operation';
    END CASE;
    
    CALL log_trace(logger_name, CONCAT('Operation completed with result: ', operation_result), 'employee_service_with_logging');
    
    SELECT operation_result as result;
END //

DELIMITER ;

-- Test comprehensive logging
CALL employee_service_with_logging('CREATE', 6001, '{"firstName":"John","lastName":"Logger","salary":55000,"departmentId":1}');
CALL employee_service_with_logging('UPDATE', 6001, '{"salary":60000}');
CALL employee_service_with_logging('UPDATE', 9999, '{"salary":50000}'); -- Non-existent employee
CALL employee_service_with_logging('INVALID_OP', 6001, '{}'); -- Invalid operation

-- Query logs by different levels
SELECT 'ERROR and FATAL logs:' as log_type;
SELECT * FROM application_logs WHERE log_level IN ('ERROR', 'FATAL') ORDER BY log_timestamp DESC;

SELECT 'WARNING logs:' as log_type;
SELECT * FROM application_logs WHERE log_level = 'WARN' ORDER BY log_timestamp DESC;

SELECT 'INFO logs:' as log_type;
SELECT * FROM application_logs WHERE log_level = 'INFO' ORDER BY log_timestamp DESC;

-- Log summary by level
SELECT log_level, COUNT(*) as count 
FROM application_logs 
GROUP BY log_level 
ORDER BY FIELD(log_level, 'TRACE', 'DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL');