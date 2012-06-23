package hopscotch.collision;

import haxe.unit.TestCase;

class BoxMaskTest extends TestCase {
    public function new() {
        super();
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
