CREATE TABLE mock_interactions (
    interaction_id INT AUTO_INCREMENT PRIMARY KEY,
    mock_object VARCHAR(100),
    method_called VARCHAR(100),
    parameters TEXT,
    call_count INT DEFAULT 1,
    call_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER //

-- Mock object behavior simulation
CREATE PROCEDURE mock_employee_service_save(
    IN emp_id INT,
    IN first_name VARCHAR(50),
    IN last_name VARCHAR(50),
    IN salary DECIMAL(10,2)
)
BEGIN
    -- Record the interaction
    INSERT INTO mock_interactions (mock_object, method_called, parameters)
    VALUES ('EmployeeService', 'save', CONCAT('id:', emp_id, ',name:', first_name, ' ', last_name, ',salary:', salary));
    
    -- Simulate the actual save (or don't, depending on mock behavior)
    INSERT INTO employees (employee_id, first_name, last_name, salary, department_id)
    VALUES (emp_id, first_name, last_name, salary, 1);
    
    SELECT 'Mock save called' as mock_result;
END //

CREATE PROCEDURE mock_employee_service_find(IN emp_id INT)
BEGIN
    -- Record the interaction
    INSERT INTO mock_interactions (mock_object, method_called, parameters)
    VALUES ('EmployeeService', 'findById', CONCAT('id:', emp_id));
    
    -- Return mock data or real data
    SELECT * FROM employees WHERE employee_id = emp_id;
END //

-- Verification methods
CREATE PROCEDURE verify_method_called(
    IN mock_object_name VARCHAR(100),
    IN method_name VARCHAR(100),
    IN expected_calls INT
)
BEGIN
    DECLARE actual_calls INT;
    
    SELECT COUNT(*) INTO actual_calls 
    FROM mock_interactions 
    WHERE mock_object = mock_object_name AND method_called = method_name;
    
    IF actual_calls = expected_calls THEN
        SELECT CONCAT('PASS: ', method_name, ' called ', actual_calls, ' times as expected') as verification_result;
    ELSE
        SELECT CONCAT('FAIL: ', method_name, ' called ', actual_calls, ' times, expected ', expected_calls) as verification_result;
    END IF;
END //

CREATE PROCEDURE verify_method_called_with_params(
    IN mock_object_name VARCHAR(100),
    IN method_name VARCHAR(100),
    IN expected_params TEXT
)
BEGIN
    DECLARE param_match_count INT;
    
    SELECT COUNT(*) INTO param_match_count
    FROM mock_interactions 
    WHERE mock_object = mock_object_name 
    AND method_called = method_name 
    AND parameters = expected_params;
    
    IF param_match_count > 0 THEN
        SELECT CONCAT('PASS: ', method_name, ' called with expected parameters') as verification_result;
    ELSE
        SELECT CONCAT('FAIL: ', method_name, ' not called with expected parameters: ', expected_params) as verification_result;
    END IF;
END //

DELIMITER ;

-- Test verifying interactions
DELETE FROM mock_interactions;

-- Act - Call mock methods
CALL mock_employee_service_save(7001, 'Mock', 'Employee', 50000);
CALL mock_employee_service_find(7001);
CALL mock_employee_service_find(7001); -- Called twice

-- Verify interactions
CALL verify_method_called('EmployeeService', 'save', 1);
CALL verify_method_called('EmployeeService', 'findById', 2);
CALL verify_method_called_with_params('EmployeeService', 'save', 'id:7001,name:Mock Employee,salary:50000.00');

-- View all interactions
SELECT * FROM mock_interactions ORDER BY call_timestamp;