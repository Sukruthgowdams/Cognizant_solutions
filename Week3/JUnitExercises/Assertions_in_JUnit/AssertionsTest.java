package JUnitExercises.Assertions_in_JUnit;

import org.junit.Test;
import static org.junit.Assert.*;

public class AssertionsTest {

    @Test
    public void testAssertions() {
        // Assert equals
        assertEquals("Addition failed", 5, 2 + 3);

        // Assert true
        assertTrue("Expected true condition", 5 > 3);

        // Assert false
        assertFalse("Expected false condition", 5 < 3);

        // Assert null
        Object obj = null;
        assertNull("Object should be null", obj);

        // Assert not null
        assertNotNull("Object should not be null", new Object());
    }
}
