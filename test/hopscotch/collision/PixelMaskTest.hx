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
        var mask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask.png"));
        assertTrue(mask.collide(mask));
    }

    public function testPixelMaskCollidesWithItselfAtOverlappingCoordinates() {
        var mask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask.png"));
        mask.x = 5;
        mask.y = -2;
        assertTrue(mask.collide(mask, 7, -2, 23, 13));
    }

    public function testPixelMaskDoesNotCollideWithItselfAtDifferentCoordinates() {
        var mask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask.png"));
        mask.x = 5;
        mask.y = -2;
        assertFalse(mask.collide(mask, 7, -2, 23, 14));
    }
}
