package JUnitExercises.AAA;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

public class CalcTest {
    private CalcTest calculator;

    @Before
    public void setUp() {
        // Arrange: Initialize shared resource before each test
        calculator = new CalcTest();
        System.out.println(">> Setup Calculator");
    }

    @After
    public void tearDown() {
        // Cleanup after each test
        System.out.println("<< Teardown Calculator\n");
    }

    @Test
    public void testAddition() {
        // Act
        int result = calculator.add(5, 3);

        // Assert
        assertEquals(8, result);
    }

    @Test
    public void testSubtraction() {
        // Act
        int result = calculator.subtract(10, 4);

        // Assert
        assertEquals(6, result);
    }
}
