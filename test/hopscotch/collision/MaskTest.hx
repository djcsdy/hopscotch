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
        var mask = new Mask();

        try {
            mask.collide(null, 0, 0, 0, 0);
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

    public function testImplementNull () {
        var caught = false;
        var mask = new Mask();

        try {
            mask.implement(null, function (mask2:Mask, x1:Float, y1:Float, x2:Float, y2:Float) { return false; });
        } catch (e:ArgumentNullError) {
            caught = true;
        }

        assertTrue(caught);

        caught = false;

        try {
            mask.implement(BoxMask, null);
        } catch (e:ArgumentNullError) {
            caught = true;
        }

        assertTrue(caught);
    }
}