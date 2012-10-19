package hopscotch.geometry;

import hopscotch.test.TestCase;

class Vector2dTest extends TestCase {
    public function new() {
        super();
    }

    public function testAdd () {
        var v = new Vector2d(2, 3);
        var w = new Vector2d(5, 2);

        v.add(w);

        assertEquals(7.0, v.x);
        assertEquals(5.0, v.y);
    }

    public function testSubtract () {
        var v = new Vector2d(2, 3);
        var w = new Vector2d(5, 2);

        v.subtract(w);

        assertEquals(-3.0, v.x);
        assertEquals(1.0, v.y);
    }

    public function testDot () {
        var v = new Vector2d(2, 3);
        var w = new Vector2d(4, -5);

        assertEquals(-7.0, v.dot(w));
    }

    public function testCross () {
        var v = new Vector2d(2, 3);
        var w = new Vector2d(4, -5);

        assertEquals(-22.0, v.cross(w));
    }

    public function testScale () {
        var v = new Vector2d(2, 3);

        v.scale(4);

        assertEquals(8.0, v.x);
        assertEquals(12.0, v.y);
    }

    public function testNegate () {
        var v = new Vector2d(2, 3);

        v.negate();

        assertEquals(-2.0, v.x);
        assertEquals(-3.0, v.y);
    }

    public function testAngle () {
        var v = new Vector2d(0, 0);
        assertEquals(0.0, v.angle());

        v.x = 4;
        assertEquals(Math.PI/2, v.angle());

        v.y = 4;
        assertEquals(3*Math.PI/4, v.angle());

        v.x = 0;
        assertEquals(Math.PI, v.angle());

        v.x = -4;
        assertEquals(-3*Math.PI/4, v.angle());

        v.y = -4;
        assertEquals(-Math.PI/4, v.angle());
    }

    public function testMagnitude () {
        var v = new Vector2d(0, 0);
        assertEquals(0.0, v.magnitude());

        v.x = 3;
        assertEquals(3.0, v.magnitude());

        v.y = -4;
        assertEquals(5.0, v.magnitude());

        v.x = -3;
        assertEquals(5.0, v.magnitude());
    }

    public function testNormalize () {
        var v = new Vector2d(0, 0);

        v.normalize();

        assertTrue(Math.isNaN(v.x));
        assertTrue(Math.isNaN(v.y));

        v.x = 0;
        v.y = 0;

        v.normalize(2.5);

        assertTrue(Math.isNaN(v.x));
        assertTrue(Math.isNaN(v.y));

        v.x = 5;
        v.y = 0;

        v.normalize();

        assertEquals(1.0, v.x);
        assertEquals(0.0, v.y);

        v.x = 5;

        v.normalize(3);

        assertEquals(3.0, v.x);
        assertEquals(0.0, v.y);

        v.x = -3;
        v.y = 4;

        v.normalize();

        assertApproxEquals(-3/5, v.x);
        assertEquals(4/5, v.y);

        v.x = -3;
        v.y = 4;

        v.normalize(10);

        assertEquals(-6.0, v.x);
        assertEquals(8.0, v.y);

        v.x = -3;
        v.y = 4;

        v.normalize(-5);

        assertEquals(3.0, v.x);
        assertEquals(-4.0, v.y);
    }

    public function testDistance () {
        var v = new Vector2d(2, 3);
        var w = new Vector2d(4, -5);

        assertEquals(Math.sqrt(68), v.distance(w));
    }

    public function testRotate () {
        var v = new Vector2d(0, 0);

        v.rotate(Math.PI/4);

        assertEquals(0.0, v.x);
        assertEquals(0.0, v.y);

        v.x = 0;
        v.y = -1;

        v.rotate(Math.PI/4);
        assertApproxEquals(Math.sqrt(0.5), v.x);
        assertApproxEquals(-Math.sqrt(0.5), v.y);

        v.x = -1;
        v.y = 1;

        v.rotate(Math.PI/4);
        assertApproxEquals(-Math.sqrt(2), v.x);
        assertApproxEquals(0.0, v.y);

        v.x = 1;
        v.y = -1;
        v.rotate(Math.PI/2);
        assertApproxEquals(1.0, v.x);
        assertApproxEquals(1.0, v.y);
    }

    public function testToUnitVector () {
        var v = new Vector2d();

        v.toUnitVector(0);
        assertEquals(0.0, v.x);
        assertEquals(-1.0, v.y);

        v.toUnitVector(Math.PI/4);
        assertApproxEquals(Math.sqrt(0.5), v.x);
        assertApproxEquals(-Math.sqrt(0.5), v.y);

        v.toUnitVector(Math.PI/2);
        assertApproxEquals(1.0, v.x);
        assertApproxEquals(0.0, v.y);

        v.toUnitVector(3*Math.PI/4);
        assertApproxEquals(Math.sqrt(0.5), v.x);
        assertApproxEquals(Math.sqrt(0.5), v.y);

        v.toUnitVector(Math.PI);
        assertApproxEquals(0.0, v.x);
        assertApproxEquals(1.0, v.y);

        v.toUnitVector(5*Math.PI/4);
        assertApproxEquals(-Math.sqrt(0.5), v.x);
        assertApproxEquals(Math.sqrt(0.5), v.y);

        v.toUnitVector(-3*Math.PI/4);
        assertApproxEquals(-Math.sqrt(0.5), v.x);
        assertApproxEquals(Math.sqrt(0.5), v.y);

        v.toUnitVector(-Math.PI/4);
        assertApproxEquals(-Math.sqrt(0.5), v.x);
        assertApproxEquals(-Math.sqrt(0.5), v.y);
    }

    public function testToPolar () {
        var v = new Vector2d();

        v.toPolar(0, 0);
        assertEquals(0.0, v.x);
        assertEquals(0.0, v.y);

        v.toPolar(Math.PI/4, 0);
        assertEquals(0.0, v.x);
        assertEquals(0.0, v.y);

        v.toPolar(0, 4);
        assertApproxEquals(0.0, v.x);
        assertApproxEquals(-4.0, v.y);

        v.toPolar(Math.PI/4, 3);
        assertApproxEquals(3*Math.sqrt(0.5), v.x);
        assertApproxEquals(-3*Math.sqrt(0.5), v.y);

        v.toPolar(Math.PI/2, 2);
        assertApproxEquals(2.0, v.x);
        assertApproxEquals(0.0, v.y);

        v.toPolar(3*Math.PI/4, 5);
        assertApproxEquals(5*Math.sqrt(0.5), v.x);
        assertApproxEquals(5*Math.sqrt(0.5), v.y);

        v.toPolar(Math.PI, 0.5);
        assertApproxEquals(0.0, v.x);
        assertApproxEquals(0.5, v.y);

        v.toPolar(5*Math.PI/4, 1.5);
        assertApproxEquals(-1.5*Math.sqrt(0.5), v.x);
        assertApproxEquals(1.5*Math.sqrt(0.5), v.y);

        v.toPolar(-3*Math.PI/4, 7);
        assertApproxEquals(-7*Math.sqrt(0.5), v.x);
        assertApproxEquals(7*Math.sqrt(0.5), v.y);

        v.toPolar(-Math.PI/4, -3.5);
        assertApproxEquals(3.5*Math.sqrt(0.5), v.x);
        assertEquals(3.5*Math.sqrt(0.5), v.y);
    }

    public function testCopyFrom() {
        var v = new Vector2d();
        var w = new Vector2d(2, 3);

        v.copyFrom(w);

        assertEquals(w.x, v.x);
        assertEquals(w.y, v.y);

        w.x = -9;

        v.copyFrom(w);

        assertEquals(w.x, v.x);
        assertEquals(w.y, v.y);
    }

    public function testClone() {
        var v = new Vector2d(9, -7);

        var w = v.clone();

        assertFalse(v == w);
        assertEquals(v.x, w.x);
        assertEquals(v.y, w.y);

        v.x = -1;

        var u = v.clone();

        assertFalse(u == v);
        assertFalse(u == w);
        assertEquals(v.x, u.x);
        assertEquals(v.y, u.y);
    }
}
