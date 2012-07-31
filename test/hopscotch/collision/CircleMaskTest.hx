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

    public function testCollideRejectsNaNProperties () {
        var caught = false;
        var circleMask1 = new CircleMask();
        var circleMask2 = new CircleMask();
        var boxMask = new BoxMask();
        circleMask1.x = Math.NaN;
        try {
            circleMask1.collide(circleMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask2.collide(circleMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask1.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(circleMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask1.x = 0;
        circleMask1.y = Math.NaN;
        try {
            circleMask1.collide(circleMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask2.collide(circleMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask1.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(circleMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask1.y = 0;
        circleMask1.radius = Math.NaN;
        try {
            circleMask1.collide(circleMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask2.collide(circleMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask1.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(circleMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCollideRejectsInfiniteProperties () {
        var caught = false;
        var circleMask1 = new CircleMask();
        var circleMask2 = new CircleMask();
        circleMask1.x = Math.POSITIVE_INFINITY;
        try {
            circleMask1.collide(circleMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask2.collide(circleMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask1.x = 0;
        circleMask1.y = Math.POSITIVE_INFINITY;
        try {
            circleMask1.collide(circleMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask2.collide(circleMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask1.y = 0;
        circleMask1.radius = Math.POSITIVE_INFINITY;
        try {
            circleMask1.collide(circleMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask2.collide(circleMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCollideRejectsNegativeRadius () {
        var caught = false;
        var circleMask1 = new CircleMask();
        var circleMask2 = new CircleMask();
        circleMask1.radius = -1;
        try {
            circleMask1.collide(circleMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask2.collide(circleMask1);
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

    public function testCircleCollidesWithItselfAtOverlappingCoordinates () {
        var circleMask = new CircleMask(5, 10, 5);
        assertTrue(circleMask.collide(circleMask, -2, 4, 5, -3));
    }

    public function testCircleDoesNotCollideWithItselfAtDifferentCoordinates () {
        var circleMask = new CircleMask(5, 10, 5);
        assertFalse(circleMask.collide(circleMask, -2, 4, 5, -4));
    }

    public function testCircleDoesNotCollideWithAnAdjacentCircle () {
        var circleMask1 = new CircleMask(5, 10, 5);
        var circleMask2 = new CircleMask(-1, 2, 4);
        assertFalse(circleMask1.collide(circleMask2, -2, 4, 4, 21));
    }

    public function testCircleDoesNotCollideWithAnotherCircle () {
        var circleMask1 = new CircleMask(5, 10, 5);
        var circleMask2 = new CircleMask(-1, 2, 4);
        assertFalse(circleMask1.collide(circleMask2, -2, 4, 9, 3));
    }

    public function testCollideRejectsBoxWithNaNProperties() {
        var caught = false;
        var circleMask = new CircleMask();
        var boxMask = new BoxMask();
        boxMask.x = Math.NaN;
        try {
            circleMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.x = 0;
        boxMask.y = Math.NaN;
        try {
            boxMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.y = 0;
        boxMask.width = Math.NaN;
        try {
            boxMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.width = 0;
        boxMask.height = Math.NaN;
        try {
            boxMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCollideRejectsBoxWithInfiniteProperties() {
        var caught = false;
        var circleMask = new CircleMask();
        var boxMask = new BoxMask();
        boxMask.x = Math.POSITIVE_INFINITY;
        try {
            circleMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.x = 0;
        boxMask.y = Math.POSITIVE_INFINITY;
        try {
            boxMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.y = 0;
        boxMask.width = Math.POSITIVE_INFINITY;
        try {
            boxMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.width = 0;
        boxMask.height = Math.POSITIVE_INFINITY;
        try {
            boxMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCollideRejectsBoxWithNegativeWidthOrHeightProperties() {
        var caught = false;
        var circleMask = new CircleMask();
        var boxMask = new BoxMask();
        boxMask.width = -1;
        try {
            boxMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.width = 0;
        boxMask.height = -1;
        try {
            boxMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCircleCollidesWithABox () {
        var circleMask = new CircleMask(1, 6, 5);
        var boxMask = new BoxMask(-1, -1, 1, 1);
        assertTrue(circleMask.collide(boxMask, 2.5, -9.2, 3, -8));
        assertTrue(boxMask.collide(circleMask, 3, -8, 2.5, -9.2));
    }

    public function testCircleDoesNotCollideWithABox () {
        var circleMask = new CircleMask(1, 6, 5);
        var boxMask = new BoxMask(-1, -1, 1, 1);
        assertFalse(circleMask.collide(boxMask, 2.5, -9, 3, -8));
        assertFalse(boxMask.collide(circleMask, 3, -8, 2.5, -9));
    }
}
