DELIMITER //

CREATE PROCEDURE assert_equals(
    IN expected_val VARCHAR(500),
    IN actual_val VARCHAR(500),
    IN test_name VARCHAR(100),
    IN suite_id INT
)
BEGIN
    DECLARE test_status ENUM('PASS', 'FAIL');
    DECLARE start_time BIGINT;
    DECLARE end_time BIGINT;
    
    SET start_time = UNIX_TIMESTAMP(NOW(3)) * 1000;
    
    IF expected_val = actual_val THEN
        SET test_status = 'PASS';
    ELSE
        SET test_status = 'FAIL';
    END IF;
    
    SET end_time = UNIX_TIMESTAMP(NOW(3)) * 1000;
    
    INSERT INTO test_cases (suite_id, test_name, expected_result, actual_result, test_status, execution_time_ms)
    VALUES (suite_id, test_name, expected_val, actual_val, test_status, end_time - start_time);
    
    SELECT CONCAT('Test: ', test_name, ' - ', test_status) as assertion_result;
END //

CREATE PROCEDURE assert_not_null(
    IN actual_val VARCHAR(500),
    IN test_name VARCHAR(100),
    IN suite_id INT
)
BEGIN
    IF actual_val IS NOT NULL THEN
        CALL assert_equals('NOT_NULL', 'NOT_NULL', test_name, suite_id);
    ELSE
        CALL assert_equals('NOT_NULL', 'NULL', test_name, suite_id);
    END IF;
END //

CREATE PROCEDURE assert_true(
    IN condition_result BOOLEAN,
    IN test_name VARCHAR(100),
    IN suite_id INT
)
BEGIN
    IF condition_result = TRUE THEN
        CALL assert_equals('TRUE', 'TRUE', test_name, suite_id);
    ELSE
        CALL assert_equals('TRUE', 'FALSE', test_name, suite_id);
    END IF;
END //

DELIMITER ;

-- Test assertions
CALL setup_test_suite('Assertion Tests');
SET @suite_id = LAST_INSERT_ID();

CALL before_each_test();
SELECT salary INTO @emp_salary FROM employees WHERE employee_id = 9001;
CALL assert_equals('50000.00', CAST(@emp_salary as CHAR), 'Test Employee Salary', @suite_id);

SELECT COUNT(*) INTO @emp_count FROM employees WHERE employee_id BETWEEN 9000 AND 9999;
CALL assert_equals('2', CAST(@emp_count as CHAR), 'Test Employee Count', @suite_id);

CALL assert_not_null(@emp_salary, 'Test Salary Not Null', @suite_id);
CALL after_each_test();