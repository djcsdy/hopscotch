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
}
