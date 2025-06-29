DELIMITER //

CREATE PROCEDURE test_employee_salary_increase_AAA()
BEGIN
    DECLARE suite_id INT;
    DECLARE original_salary DECIMAL(10,2);
    DECLARE new_salary DECIMAL(10,2);
    DECLARE expected_salary DECIMAL(10,2);
    
    -- Create test suite
    CALL setup_test_suite('AAA Pattern - Salary Increase Test');
    SET suite_id = LAST_INSERT_ID();
    
    -- ARRANGE - Setup test data and expectations
    CALL before_each_test();
    SELECT salary INTO original_salary FROM employees WHERE employee_id = 9001;
    SET expected_salary = original_salary * 1.10; -- 10% increase
    
    -- ACT - Execute the operation being tested
    CALL manage_employee_salary(9001, 'INCREASE', 10, @result_salary, @status);
    SELECT salary INTO new_salary FROM employees WHERE employee_id = 9001;
    
    -- ASSERT - Verify the results
    CALL assert_equals(CAST(expected_salary as CHAR), CAST(new_salary as CHAR), 'Salary Increase Calculation', suite_id);
    CALL assert_equals('Salary increased successfully', @status, 'Operation Status', suite_id);
    CALL assert_true(new_salary > original_salary, 'Salary Actually Increased', suite_id);
    
    -- Teardown
    CALL after_each_test();
    
    -- Display results
    SELECT * FROM test_cases WHERE suite_id = suite_id;
END //

-- Test Fixtures - Predefined test data setup
CREATE PROCEDURE setup_employee_fixtures()
BEGIN
    -- Standard test employees
    DELETE FROM employees WHERE employee_id BETWEEN 8000 AND 8999;
    
    INSERT INTO employees VALUES 
    (8001, 'Fixture', 'Employee1', 'fixture1@test.com', 45000, 1, '2023-01-01'),
    (8002, 'Fixture', 'Employee2', 'fixture2@test.com', 55000, 2, '2023-06-01'),
    (8003, 'Fixture', 'Employee3', 'fixture3@test.com', 65000, 3, '2023-12-01');
    
    SELECT 'Employee fixtures created' as fixture_status;
END //

CREATE PROCEDURE teardown_employee_fixtures()
BEGIN
    DELETE FROM employees WHERE employee_id BETWEEN 8000 AND 8999;
    SELECT 'Employee fixtures cleaned up' as fixture_status;
END //

-- Setup and Teardown for entire test class
CREATE PROCEDURE setup_before_class()
BEGIN
    -- One-time setup for all tests in the class
    CREATE TEMPORARY TABLE IF NOT EXISTS test_execution_log (
        log_id INT AUTO_INCREMENT PRIMARY KEY,
        test_class VARCHAR(100),
        setup_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    
    INSERT INTO test_execution_log (test_class) VALUES ('Employee Management Test Class');
    SELECT 'Test class setup completed' as class_setup_status;
END //

CREATE PROCEDURE teardown_after_class()
BEGIN
    -- One-time cleanup after all tests in the class
    DROP TEMPORARY TABLE IF EXISTS test_execution_log;
    SELECT 'Test class teardown completed' as class_teardown_status;
END //

DELIMITER ;

-- Run complete test with fixtures
CALL setup_before_class();
CALL setup_employee_fixtures();
CALL test_employee_salary_increase_AAA();
CALL teardown_employee_fixtures();
CALL teardown_after_class();