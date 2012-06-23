package hopscotch.collision;

import haxe.unit.TestCase;

class CircleMaskTest extends TestCase {
    public function new() {
        super();
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
