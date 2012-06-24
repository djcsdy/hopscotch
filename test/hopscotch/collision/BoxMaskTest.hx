package hopscotch.collision;

import hopscotch.errors.IllegalOperationError;
import hopscotch.errors.ArgumentError;
import haxe.unit.TestCase;

class BoxMaskTest extends TestCase {
    public function new() {
        super();
    }

    public function testConstructorRejectsNaN () {
        var caught = false;
        try {
            new BoxMask(Math.NaN, 0, 0, 0);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            new BoxMask(0, Math.NaN, 0, 0);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            new BoxMask(0, 0, Math.NaN, 0);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            new BoxMask(0, 0, 0, Math.NaN);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testConstructorRejectsInfinity () {
        var caught = false;
        try {
            new BoxMask(Math.POSITIVE_INFINITY, 0, 0, 0);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            new BoxMask(0, Math.POSITIVE_INFINITY, 0, 0);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            new BoxMask(0, 0, Math.POSITIVE_INFINITY, 0);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            new BoxMask(0, 0, 0, Math.POSITIVE_INFINITY);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testConstructorRejectsNegativeWidthOrHeight () {
        var caught = false;
        try {
            new BoxMask(0, 0, -1, 0);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            new BoxMask(0, 0, 0, -1);
        } catch (e:ArgumentError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCollideRejectsNaNProperties () {
        var caught = false;
        var boxMask1 = new BoxMask();
        var boxMask2 = new BoxMask();
        boxMask1.x = Math.NaN;
        try {
            boxMask1.collide(boxMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask2.collide(boxMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask1.x = 0;
        boxMask1.y = Math.NaN;
        try {
            boxMask1.collide(boxMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask2.collide(boxMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask1.y = 0;
        boxMask1.width = Math.NaN;
        try {
            boxMask1.collide(boxMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask2.collide(boxMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask1.width = 0;
        boxMask1.height = Math.NaN;
        try {
            boxMask1.collide(boxMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask2.collide(boxMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCollideRejectsInfiniteProperties () {
        var caught = false;
        var boxMask1 = new BoxMask();
        var boxMask2 = new BoxMask();
        boxMask1.x = Math.POSITIVE_INFINITY;
        try {
            boxMask1.collide(boxMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = true;
        try {
            boxMask2.collide(boxMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask1.x = 0;
        boxMask1.y = Math.POSITIVE_INFINITY;
        try {
            boxMask1.collide(boxMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask2.collide(boxMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask1.y = 0;
        boxMask1.width = Math.POSITIVE_INFINITY;
        try {
            boxMask1.collide(boxMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask2.collide(boxMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask1.width = 0;
        boxMask1.height = Math.POSITIVE_INFINITY;
        try {
            boxMask1.collide(boxMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask2.collide(boxMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCollideRejectsNegativeWidthOrHeightProperties () {
        var caught = false;
        var boxMask1 = new BoxMask();
        var boxMask2 = new BoxMask();
        boxMask1.width = -1;
        try {
            boxMask1.collide(boxMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask2.collide(boxMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }

        caught = false;
        boxMask1.width = 0;
        boxMask1.height = -1;
        try {
            boxMask1.collide(boxMask2);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask2.collide(boxMask1);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testZeroAreaBoxDoesNotCollideWithItself () {
        var boxMask = new BoxMask();
        assertFalse(boxMask.collide(boxMask));
    }

    public function testBoxCollidesWithItself () {
        var boxMask = new BoxMask(0, 0, 1, 1);
        assertTrue(boxMask.collide(boxMask));
    }

    public function testBoxMaskCollidesWithItselfAtOverlappingCoordinates () {
        var boxMask = new BoxMask(5, 5, 10, 10);
        assertTrue(boxMask.collide(boxMask, -4, 0, 4, 9));
    }

    public function testBoxDoesNotCollideWithItselfAtDifferentCoordinates () {
        var boxMask = new BoxMask(5, 5, 10, 10);
        assertFalse(boxMask.collide(boxMask, -5, -10, 10, 10));
    }

    public function testBoxMaskCollidesWithAnotherBoxMask () {
        var boxMask1 = new BoxMask(5, 5, 10, 10);
        var boxMask2 = new BoxMask(-2, 0, 3, 4);
        assertTrue(boxMask1.collide(boxMask2, -20, 5, -4, 19));
    }

    public function testBoxMaskDoesNotCollideWithAnotherBoxMask () {
        var boxMask1 = new BoxMask(5, 5, 10, 10);
        var boxMask2 = new BoxMask(-2, 0, 3, 4);
        assertFalse(boxMask1.collide(boxMask2, -20, 5, -50, 0));
    }

    public function testBoxMaskDoesNotCollideWithAnAdjacentBoxMask () {
        var boxMask1 = new BoxMask(5, 5, 10, 10);
        var boxMask2 = new BoxMask(-2, 0, 3, 4);
        assertFalse(boxMask1.collide(boxMask2, -20, 5, -16, 19));
    }
}
