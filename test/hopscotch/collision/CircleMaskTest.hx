package hopscotch.collision;

import hopscotch.errors.IllegalOperationError;
import hopscotch.errors.ArgumentError;
import haxe.unit.TestCase;

class CircleMaskTest extends TestCase {
    public function new() {
        super();
    }

    public function testConstructorRejectsNaN () {
        var caught = false;
        try {
            new CircleMask(Math.NaN, 0, 1);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            new CircleMask(0, Math.NaN, 1);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            new CircleMask(0, 0, Math.NaN);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testConstructorRejectsInfinity () {
        var caught = false;
        try {
            new CircleMask(Math.POSITIVE_INFINITY, 0, 1);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            new CircleMask(0, Math.POSITIVE_INFINITY, 1);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            new CircleMask(0, 0, Math.POSITIVE_INFINITY);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testConstructorRejectsNegativeRadius () {
        var caught = false;
        try {
            new CircleMask(0, 0, -1);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function collideRejectsNaNProperties () {
        var caught = false;
        var circleMask = new CircleMask();
        circleMask.x = Math.NaN;
        try {
            circleMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask.x = 0;
        circleMask.y = Math.NaN;
        try {
            circleMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask.y = 0;
        circleMask.radius = Math.NaN;
        try {
            circleMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function collideRejectsInfiniteProperties () {
        var caught = false;
        var circleMask = new CircleMask();
        circleMask.x = Math.POSITIVE_INFINITY;
        try {
            circleMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask.x = 0;
        circleMask.y = Math.POSITIVE_INFINITY;
        try {
            circleMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask.y = 0;
        circleMask.radius = Math.POSITIVE_INFINITY;
        try {
            circleMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function collideRejectsNegativeRadius () {
        var caught = false;
        var circleMask = new CircleMask();
        circleMask.radius = -1;
        try {
            circleMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testZeroAreaCircleDoesNotCollideWithItself () {
        var circleMask = new CircleMask();
        assertFalse(circleMask.collide(circleMask));
    }

    public function testCircleCollidesWithItself () {
        var circleMask = new CircleMask(5, 10, 1);
        assertTrue(circleMask.collide(circleMask));
    }
}
