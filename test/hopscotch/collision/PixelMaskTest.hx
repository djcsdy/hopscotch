package hopscotch.collision;

import nme.installer.Assets;
import flash.display.BitmapData;
import hopscotch.errors.ArgumentNullError;
import haxe.unit.TestCase;
class PixelMaskTest extends TestCase {
    public function new() {
        super();
    }

    public function testConstructorRejectsNull() {
        var caught = false;
        try {
            new PixelMask(null);
        } catch (e:ArgumentNullError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testEmptyPixelMaskDoesNotCollideWithItself() {
        var mask = new PixelMask(new BitmapData(32, 32, true, 0x000000));
        assertFalse(mask.collide(mask));
    }

    public function testPixelMaskCollidesWithItself() {
        var mask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        assertTrue(mask.collide(mask));
    }

    public function testPixelMaskCollidesWithItselfAtOverlappingCoordinates() {
        var mask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        mask.x = 5;
        mask.y = -2;
        assertTrue(mask.collide(mask, 7, -2, 23, 13));
    }

    public function testPixelMaskDoesNotCollideWithItselfAtDifferentCoordinates() {
        var mask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        mask.x = 5;
        mask.y = -2;
        assertFalse(mask.collide(mask, 7, -2, 23, 14));
    }

    public function testPixelMaskCollidesWithAnotherPixelMask() {
        var mask1 = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var mask2 = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask2.png"));
        mask1.x = 5;
        mask1.y = -2;
        mask2.x = -9;
        mask2.y = 1;

        assertTrue(mask1.collide(mask2, 7, -1, 38, 11));
        assertTrue(mask2.collide(mask1, 38, 11, 7, -1));
    }

    public function testPixelMaskDoesNotCollideWithAnotherPixelMask() {
        var mask1 = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var mask2 = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask2.png"));
        mask1.x = 5;
        mask1.y = -2;
        mask2.x = -9;
        mask2.y = 1;

        assertFalse(mask1.collide(mask2, 7, -1, 39, 11));
        assertFalse(mask2.collide(mask1, 39, 11, 7, -1));
    }
}
