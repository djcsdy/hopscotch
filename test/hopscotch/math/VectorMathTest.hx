package hopscotch.math;

import haxe.PosInfos;
import flash.geom.Point;
import haxe.unit.TestCase;

class VectorMathTest extends TestCase {
    public function new () {
        super();
    }

    public function testAdd () {
        var p1 = new Point(2, 3);
        var p2 = new Point(5, 2);

        VectorMath.add(p1, p2);

        assertEquals(7.0, p1.x);
        assertEquals(5.0, p1.y);
    }

    public function testSubtract () {
        var p1 = new Point(2, 3);
        var p2 = new Point(5, 2);

        VectorMath.subtract(p1, p2);

        assertEquals(-3.0, p1.x);
        assertEquals(1.0, p1.y);
    }

    public function testDot () {
        var p1 = new Point(2, 3);
        var p2 = new Point(4, -5);

        assertEquals(-7.0, VectorMath.dot(p1, p2));
    }

    public function testCross () {
        var p1 = new Point(2, 3);
        var p2 = new Point(4, -5);

        assertEquals(-22.0, VectorMath.cross(p1, p2));
    }

    public function testScale () {
        var p1 = new Point(2, 3);

        VectorMath.scale(p1, 4);

        assertEquals(8.0, p1.x);
        assertEquals(12.0, p1.y);
    }

    public function testNegate () {
        var p1 = new Point(2, 3);

        VectorMath.negate(p1);

        assertEquals(-2.0, p1.x);
        assertEquals(-3.0, p1.y);
    }

    public function testAngle () {
        var p1 = new Point(0, 0);
        assertEquals(0.0, VectorMath.angle(p1));

        p1.x = 4;
        assertEquals(Math.PI/2, VectorMath.angle(p1));

        p1.y = 4;
        assertEquals(3*Math.PI/4, VectorMath.angle(p1));

        p1.x = 0;
        assertEquals(Math.PI, VectorMath.angle(p1));

        p1.x = -4;
        assertEquals(-3*Math.PI/4, VectorMath.angle(p1));

        p1.y = -4;
        assertEquals(-Math.PI/4, VectorMath.angle(p1));
    }

    public function testMagnitude () {
        var p1 = new Point(0, 0);
        assertEquals(0.0, VectorMath.magnitude(p1));

        p1.x = 3;
        assertEquals(3.0, VectorMath.magnitude(p1));

        p1.y = -4;
        assertEquals(5.0, VectorMath.magnitude(p1));

        p1.x = -3;
        assertEquals(5.0, VectorMath.magnitude(p1));
    }

    public function testNormalize () {
        var p1 = new Point(0, 0);

        VectorMath.normalize(p1);

        assertEquals(0.0, p1.x);
        assertEquals(0.0, p1.y);

        VectorMath.normalize(p1, 2.5);

        assertEquals(0.0, p1.x);
        assertEquals(0.0, p1.y);

        p1.x = 5;

        VectorMath.normalize(p1);

        assertEquals(1.0, p1.x);
        assertEquals(0.0, p1.y);

        p1.x = 5;

        VectorMath.normalize(p1, 3);

        assertEquals(3.0, p1.x);
        assertEquals(0.0, p1.y);

        p1.x = -3;
        p1.y = 4;

        VectorMath.normalize(p1);

        assertApproxEquals(-3/5, p1.x);
        assertEquals(4/5, p1.y);

        p1.x = -3;
        p1.y = 4;

        VectorMath.normalize(p1, 10);

        assertEquals(-6.0, p1.x);
        assertEquals(8.0, p1.y);

        p1.x = -3;
        p1.y = 4;

        VectorMath.normalize(p1, -5);

        assertEquals(3.0, p1.x);
        assertEquals(-4.0, p1.y);
    }

    public function testDistance () {
        var p1 = new Point(2, 3);
        var p2 = new Point(4, -5);

        assertEquals(Math.sqrt(68), VectorMath.distance(p1, p2));
    }

    public function testRotate () {
        var p1 = new Point(0, 0);

        VectorMath.rotate(p1, Math.PI/4);

        assertEquals(0.0, p1.x);
        assertEquals(0.0, p1.y);

        p1.x = 0;
        p1.y = -1;

        VectorMath.rotate(p1, Math.PI/4);
        assertApproxEquals(Math.sqrt(0.5), p1.x);
        assertApproxEquals(-Math.sqrt(0.5), p1.y);

        p1.x = -1;
        p1.y = 1;

        VectorMath.rotate(p1, Math.PI/4);
        assertApproxEquals(-Math.sqrt(2), p1.x);
        assertApproxEquals(0.0, p1.y);

        p1.x = 1;
        p1.y = -1;
        VectorMath.rotate(p1, Math.PI/2);
        assertApproxEquals(1.0, p1.x);
        assertApproxEquals(1.0, p1.y);
    }

    public function testToUnitVector () {
        var p1 = new Point();

        VectorMath.toUnitVector(p1, 0);
        assertEquals(0.0, p1.x);
        assertEquals(-1.0, p1.y);

        VectorMath.toUnitVector(p1, Math.PI/4);
        assertApproxEquals(Math.sqrt(0.5), p1.x);
        assertApproxEquals(-Math.sqrt(0.5), p1.y);

        VectorMath.toUnitVector(p1, Math.PI/2);
        assertApproxEquals(1.0, p1.x);
        assertApproxEquals(0.0, p1.y);

        VectorMath.toUnitVector(p1, 3*Math.PI/4);
        assertApproxEquals(Math.sqrt(0.5), p1.x);
        assertApproxEquals(Math.sqrt(0.5), p1.y);

        VectorMath.toUnitVector(p1, Math.PI);
        assertApproxEquals(0.0, p1.x);
        assertApproxEquals(1.0, p1.y);

        VectorMath.toUnitVector(p1, 5*Math.PI/4);
        assertApproxEquals(-Math.sqrt(0.5), p1.x);
        assertApproxEquals(Math.sqrt(0.5), p1.y);

        VectorMath.toUnitVector(p1, -3*Math.PI/4);
        assertApproxEquals(-Math.sqrt(0.5), p1.x);
        assertApproxEquals(Math.sqrt(0.5), p1.y);

        VectorMath.toUnitVector(p1, -Math.PI/4);
        assertApproxEquals(-Math.sqrt(0.5), p1.x);
        assertApproxEquals(-Math.sqrt(0.5), p1.y);
    }

    public function testToPolar () {
        var p1 = new Point();

        VectorMath.toPolar(p1, 0, 0);
        assertEquals(0.0, p1.x);
        assertEquals(0.0, p1.y);

        VectorMath.toPolar(p1, Math.PI/4, 0);
        assertEquals(0.0, p1.x);
        assertEquals(0.0, p1.y);

        VectorMath.toPolar(p1, 0, 4);
        assertApproxEquals(0.0, p1.x);
        assertApproxEquals(-4.0, p1.y);

        VectorMath.toPolar(p1, Math.PI/4, 3);
        assertApproxEquals(3*Math.sqrt(0.5), p1.x);
        assertApproxEquals(-3*Math.sqrt(0.5), p1.y);

        VectorMath.toPolar(p1, Math.PI/2, 2);
        assertApproxEquals(2.0, p1.x);
        assertApproxEquals(0.0, p1.y);

        VectorMath.toPolar(p1, 3*Math.PI/4, 5);
        assertApproxEquals(5*Math.sqrt(0.5), p1.x);
        assertApproxEquals(5*Math.sqrt(0.5), p1.y);

        VectorMath.toPolar(p1, Math.PI, 0.5);
        assertApproxEquals(0.0, p1.x);
        assertApproxEquals(0.5, p1.y);

        VectorMath.toPolar(p1, 5*Math.PI/4, 1.5);
        assertApproxEquals(-1.5*Math.sqrt(0.5), p1.x);
        assertApproxEquals(1.5*Math.sqrt(0.5), p1.y);

        VectorMath.toPolar(p1, -3*Math.PI/4, 7);
        assertApproxEquals(-7*Math.sqrt(0.5), p1.x);
        assertApproxEquals(7*Math.sqrt(0.5), p1.y);

        VectorMath.toPolar(p1, -Math.PI/4, -3.5);
        assertApproxEquals(3.5*Math.sqrt(0.5), p1.x);
        assertEquals(3.5*Math.sqrt(0.5), p1.y);
    }

    /** Tests if two floats are approximately equal. Useful to test for expected results while
     * allowing for IEEE-754 rounding errors. */
    function assertApproxEquals (expected:Float, actual:Float, ?deviation:Null<Float>, ?c:PosInfos) {
        if (deviation == null) {
            deviation = 0.000001;
        }

        currentTest.done = true;
        if (actual < expected - deviation || actual > expected + deviation) {
            currentTest.success = false;
            currentTest.error = "expected '" + expected + "' +/- " + deviation + ", but was '" + actual + "'";
            currentTest.posInfos = c;
            throw currentTest;
        }
    }
}
