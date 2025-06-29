DELIMITER //

CREATE PROCEDURE generate_mock_employees(IN num_records INT)
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE mock_first_name VARCHAR(50);
    DECLARE mock_last_name VARCHAR(50);
    DECLARE mock_salary DECIMAL(10,2);
    
    -- Clean existing mock data
    DELETE FROM employees WHERE employee_id >= 2000;
    
    WHILE i <= num_records DO
        -- Generate mock data
        SET mock_first_name = CONCAT('MockFirst', i);
        SET mock_last_name = CONCAT('MockLast', i);
        SET mock_salary = 40000 + (RAND() * 40000); -- Random salary between 40k-80k
        
        INSERT INTO employees VALUES (
            1999 + i,
            mock_first_name,
            mock_last_name,
            CONCAT('mock', i, '@email.com'),
            mock_salary,
            (i % 3) + 1, -- Rotate through departments 1-3
            DATE_ADD('2024-01-01', INTERVAL i DAY)
        );
        
        SET i = i + 1;
    END WHILE;
    
    SELECT CONCAT(num_records, ' mock employees generated') as message;
    
END //

DELIMITER ;

-- Verification Procedure (Mock of interaction testing)
DELIMITER //

CREATE PROCEDURE verify_employee_operations()
BEGIN
    DECLARE emp_count INT;
    DECLARE avg_salary DECIMAL(10,2);
    
    -- Generate test data
    CALL generate_mock_employees(10);
    
    -- Verify data was inserted
    SELECT COUNT(*) INTO emp_count FROM employees WHERE employee_id >= 2000;
    CALL run_test('Mock Data Generation', '10', CAST(emp_count as CHAR));
    
    -- Test salary operations on mock data
    CALL manage_employee_salary(2001, 'INCREASE', 15, @new_sal, @status);
    CALL run_test('Mock Salary Update', 'Salary increased successfully', @status);
    
    -- Cleanup
    DELETE FROM employees WHERE employee_id >= 2000;
    
END //

DELIMITER ;

CALL verify_employee_operations();