DELIMITER //

CREATE PROCEDURE salary_grade_analysis()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE emp_id INT;
    DECLARE emp_salary DECIMAL(10,2);
    DECLARE salary_grade VARCHAR(20);
    
    -- Cursor for employees
    DECLARE emp_cursor CURSOR FOR 
        SELECT employee_id, salary FROM employees;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Create temporary result table
    DROP TEMPORARY TABLE IF EXISTS salary_grades;
    CREATE TEMPORARY TABLE salary_grades (
        employee_id INT,
        salary DECIMAL(10,2),
        grade VARCHAR(20)
    );
    
    OPEN emp_cursor;
    
    read_loop: LOOP
        FETCH emp_cursor INTO emp_id, emp_salary;
        
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- Control structure: IF-ELSEIF-ELSE
        IF emp_salary >= 60000 THEN
            SET salary_grade = 'High';
        ELSEIF emp_salary >= 50000 THEN
            SET salary_grade = 'Medium';
        ELSE
            SET salary_grade = 'Low';
        END IF;
        
        INSERT INTO salary_grades VALUES (emp_id, emp_salary, salary_grade);
        
    END LOOP;
    
    CLOSE emp_cursor;
    
    -- Display results
    SELECT * FROM salary_grades;
    
END //

DELIMITER ;

-- Test the procedure
CALL salary_grade_analysis();