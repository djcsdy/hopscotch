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

    public function testCollide () {
        var mask1 = new MaskMock1();
        var mask2 = new MaskMock2();
        var boxMask = new BoxMask();

        var called11 = false;
        var mask2_11:Mask = null;
        var x1_11 = 0.0;
        var y1_11 = 0.0;
        var x2_11 = 0.0;
        var y2_11 = 0.0;
        var result11 = false;
        mask1.implement(MaskMock1,
                function (mask2:MaskMock1, x1:Float, y1:Float, x2:Float, y2:Float) {
                    called11 = true;
                    mask2_11 = mask2;
                    x1_11 = x1;
                    y1_11 = y1;
                    x2_11 = x2;
                    y2_11 = y2;
                    return result11;
                });

        var called12 = false;
        var mask2_12:Mask = null;
        var x1_12 = 0.0;
        var y1_12 = 0.0;
        var x2_12 = 0.0;
        var y2_12 = 0.0;
        var result12 = false;
        mask1.implement(MaskMock2,
                function (mask2:MaskMock2, x1:Float, y1:Float, x2:Float, y2:Float) {
                    called12 = true;
                    mask2_12 = mask2;
                    x1_12 = x1;
                    y1_12 = y1;
                    x2_12 = x2;
                    y2_12 = y2;
                    return result12;
                });

        var called21 = false;
        var mask2_21:Mask = null;
        var x1_21 = 0.0;
        var y1_21 = 0.0;
        var x2_21 = 0.0;
        var y2_21 = 0.0;
        var result21 = false;
        mask2.implement(MaskMock1,
                function (mask2:MaskMock1, x1:Float, y1:Float, x2:Float, y2:Float) {
                    called21 = true;
                    mask2_21 = mask2;
                    x1_21 = x1;
                    y1_21 = y1;
                    x2_21 = x2;
                    y2_21 = y2;
                    return result21;
                });

        var called22 = false;
        var mask2_22:Mask = null;
        var x1_22 = 0.0;
        var y1_22 = 0.0;
        var x2_22 = 0.0;
        var y2_22 = 0.0;
        var result22 = false;
        mask2.implement(MaskMock2,
                function (mask2:MaskMock2, x1:Float, y1:Float, x2:Float, y2:Float) {
                    called22 = true;
                    mask2_22 = mask2;
                    x1_22 = x1;
                    y1_22 = y1;
                    x2_22 = x2;
                    y2_22 = y2;
                    return result22;
                });

        assertEquals(result11, mask1.collide(mask1, 1, 2, 3, 4));
        assertTrue(called11);
        assertEquals(cast(mask1, Mask), mask2_11);
        assertEquals(1.0, x1_11);
        assertEquals(2.0, y1_11);
        assertEquals(3.0, x2_11);
        assertEquals(4.0, y2_11);

        called11 = false;
        result11 = true;
        assertEquals(result11, mask1.collide(mask1, 1, 2, 3, 4));
        assertTrue(called11);
    }
}