CREATE DATABASE IF NOT EXISTS junit_test_db;
USE junit_test_db;

-- Test suite table
CREATE TABLE test_suites (
    suite_id INT AUTO_INCREMENT PRIMARY KEY,
    suite_name VARCHAR(100),
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Test cases table
CREATE TABLE test_cases (
    test_id INT AUTO_INCREMENT PRIMARY KEY,
    suite_id INT,
    test_name VARCHAR(100),
    test_description TEXT,
    expected_result TEXT,
    actual_result TEXT,
    test_status ENUM('PASS', 'FAIL', 'SKIP'),
    execution_time_ms INT,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (suite_id) REFERENCES test_suites(suite_id)
);

-- JUnit Setup equivalent
DELIMITER //

CREATE PROCEDURE setup_test_suite(IN suite_name VARCHAR(100))
BEGIN
    INSERT INTO test_suites (suite_name) VALUES (suite_name);
    SELECT LAST_INSERT_ID() as suite_id;
END //

CREATE PROCEDURE before_each_test()
BEGIN
    -- Clean up test data before each test
    DELETE FROM employees WHERE employee_id BETWEEN 9000 AND 9999;
    
    -- Insert fresh test data
    INSERT INTO employees VALUES 
    (9001, 'Test', 'User1', 'test1@test.com', 50000, 1, '2024-01-01'),
    (9002, 'Test', 'User2', 'test2@test.com', 60000, 2, '2024-01-01');
    
    SELECT 'Test setup completed' as setup_status;
END //

CREATE PROCEDURE after_each_test()
BEGIN
    -- Clean up after each test
    DELETE FROM employees WHERE employee_id BETWEEN 9000 AND 9999;
    SELECT 'Test cleanup completed' as cleanup_status;
END //

DELIMITER ;

-- Usage example
CALL setup_test_suite('Employee Management Tests');
CALL before_each_test();