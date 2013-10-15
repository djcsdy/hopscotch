package hopscotch.collision;

import hopscotch.errors.IllegalOperationError;
import openfl.Assets;
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

    public function testCollideRejectsBoxWithNaNProperties() {
        var caught = false;
        var pixelMask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var boxMask = new BoxMask();
        boxMask.x = Math.NaN;
        try {
            pixelMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.x = 0;
        boxMask.y = Math.NaN;
        try {
            pixelMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.y = 0;
        boxMask.width = Math.NaN;
        try {
            pixelMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.width = 0;
        boxMask.height = Math.NaN;
        try {
            pixelMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCollideRejectsBoxWithInfiniteProperties() {
        var caught = false;
        var pixelMask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var boxMask = new BoxMask();
        boxMask.x = Math.POSITIVE_INFINITY;
        try {
            pixelMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.x = 0;
        boxMask.y = Math.POSITIVE_INFINITY;
        try {
            pixelMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.y = 0;
        boxMask.width = Math.POSITIVE_INFINITY;
        try {
            pixelMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.width = 0;
        boxMask.height = Math.POSITIVE_INFINITY;
        try {
            pixelMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCollideRejectsBoxWithNegativeWidthOrHeight() {
        var caught = false;
        var pixelMask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var boxMask = new BoxMask();
        boxMask.width = -1;
        try {
            pixelMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        boxMask.width = 0;
        boxMask.height = -1;
        try {
            pixelMask.collide(boxMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            boxMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testPixelMaskCollidesWithABox() {
        var pixelMask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var boxMask = new BoxMask(-9, 1, 10, 5);
        pixelMask.x = 5;
        pixelMask.y = -2;

        assertTrue(pixelMask.collide(boxMask, 2, 3, 30, 16));
        assertTrue(boxMask.collide(pixelMask, 30, 16, 2, 3));
    }

    public function testPixelMaskDoesNotCollideWithABox() {
        var pixelMask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var boxMask = new BoxMask(-9, 1, 10, 5);
        pixelMask.x = 5;
        pixelMask.y = -2;

        assertFalse(pixelMask.collide(boxMask, 2, 3, 31, 16));
        assertFalse(boxMask.collide(pixelMask, 31, 16, 2, 3));

        pixelMask.x = 30;
        pixelMask.y = 30;
        boxMask.x = 0;
        boxMask.y = 0;
        boxMask.width = 30;
        boxMask.height = 30;

        assertFalse(pixelMask.collide(boxMask));
        assertFalse(boxMask.collide(pixelMask));
    }

    public function testCollideRejectsCircleWithNaNProperties() {
        var caught = false;
        var pixelMask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var circleMask = new CircleMask();
        circleMask.x = Math.NaN;
        try {
            pixelMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask.x = 0;
        circleMask.y = Math.NaN;
        try {
            pixelMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask.y = 0;
        circleMask.radius = Math.NaN;
        try {
            pixelMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCollideRejectsCircleWithInfiniteProperties() {
        var caught = false;
        var pixelMask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var circleMask = new CircleMask();
        circleMask.x = Math.POSITIVE_INFINITY;
        try {
            pixelMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask.x = 0;
        circleMask.y = Math.POSITIVE_INFINITY;
        try {
            pixelMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        circleMask.y = 0;
        circleMask.radius = Math.POSITIVE_INFINITY;
        try {
            pixelMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testCollideRejectsCircleWithNegativeRadius() {
        var caught = false;
        var pixelMask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var circleMask = new CircleMask();
        circleMask.radius = -1;
        try {
            pixelMask.collide(circleMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);

        caught = false;
        try {
            circleMask.collide(pixelMask);
        } catch (e:IllegalOperationError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testPixelMaskCollidesWithACircle() {
        var pixelMask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var circleMask = new CircleMask(-9, 1, 2.5);
        pixelMask.x = 5;
        pixelMask.y = -2;

        assertTrue(pixelMask.collide(circleMask, 2, 3, 32.5, 18.5));
        assertTrue(circleMask.collide(pixelMask, 32.5, 18.5, 2, 3));
    }

    public function testPixelMaskDoesNotCollideWithACircle() {
        var pixelMask = new PixelMask(Assets.getBitmapData("test-assets/hopscotch/collision/PixelMask1.png"));
        var circleMask = new CircleMask(-9, 1, 2.5);
        pixelMask.x = 5;
        pixelMask.y = -2;

        assertFalse(pixelMask.collide(circleMask, 2, 3, 33.5, 18.5));
        assertFalse(circleMask.collide(pixelMask, 33.5, 18.5, 2, 3));
    }
}
