package hopscotch.collision;

import hopscotch.errors.NotImplementedError;
import hopscotch.errors.ArgumentNullError;
import haxe.unit.TestCase;

class MaskTest extends TestCase {
    public function new () {
        super();
    }

    public function testCollideAgainstNull () {
        var caught = false;
        var mask1 = new Mask();

        try {
            mask1.collide(null, 0, 0, 0, 0);
        } catch (e:ArgumentNullError) {
            caught = true;
        }

        assertTrue(caught);
    }

    public function testCollideNotImplemented () {
        var caught = false;
        var mask1 = new Mask();
        var mask2 = new Mask();

        try {
            mask1.collide(mask2, 0, 0, 0, 0);
        } catch (e:NotImplementedError) {
            caught = true;
        }

        assertTrue(caught);

        caught = false;

        try {
            mask2.collide(mask1, 0, 0, 0, 0);
        } catch (e:NotImplementedError) {
            caught = true;
        }

        assertTrue(caught);

        caught = false;

        try {
            mask1.collide(mask1, 0, 0, 0, 0);
        } catch (e:NotImplementedError) {
            caught = true;
        }

        assertTrue(caught);
    }
}