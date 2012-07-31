package hopscotch.collision;

import flash.display.Shape;
import hopscotch.Static;
import flash.display.StageScaleMode;
import flash.display.BitmapData;
import flash.display.Bitmap;
import hopscotch.errors.ArgumentNullError;
import flash.geom.Rectangle;

class PixelMask extends Mask {
    public var x:Float;
    public var y:Float;

    var boundingBox:BoxMask;

    var mask:BitmapData;
    var otherMask:BitmapData;
    var shape:Shape;

    public function new (source:BitmapData) {
        super();

        if (source == null) {
            throw new ArgumentNullError("source");
        }

        boundingBox = new BoxMask(0, 0, source.width, source.height);

        mask = source;
        otherMask = new BitmapData(source.width, source.height, true, 0x00000000);

        x = 0;
        y = 0;

        shape = new Shape();

        implement(PixelMask, collidePixelMask);
        implement(BoxMask, collideBox);
        implement(CircleMask, collideCircle);
    }

    function collidePixelMask (mask2:PixelMask, x1:Float, y1:Float, x2:Float, y2:Float) {
        if (!boundingBox.collide(mask2.boundingBox, x + x1, y + y1, mask2.x + x2, mask2.y + y2)) {
            return false;
        }

        Static.point.x = x + x1;
        Static.point.y = y + y1;

        Static.point2.x = mask2.x + x2;
        Static.point2.y = mask2.y + y2;

        return mask.hitTest(Static.point, 1, mask2.mask, Static.point2, 1);
    }

    function collideBox (mask2:BoxMask, x1:Float, y1:Float, x2:Float, y2:Float) {
        mask2.checkProperties();

        if (!boundingBox.collide(mask2, x + x1, y + y1, x2, y2)) {
            return false;
        }

        shape.graphics.clear();
        shape.graphics.beginFill(0xffffff);
        shape.graphics.drawRect(mask2.x + x2 - x - x1,
                mask2.y + y2 - y - y1,
                mask2.width, mask2.height);

        otherMask.fillRect(otherMask.rect, 0x00000000);
        otherMask.draw(shape);

        return mask.hitTest(Static.origin, 1, otherMask, Static.origin, 1);
    }

    function collideCircle (mask2:CircleMask, x1:Float, y1:Float, x2:Float, y2:Float) {
        mask2.checkProperties();

        if (!boundingBox.collide(mask2, x + x1, y + y1, x2, y2)) {
            return false;
        }

        shape.graphics.clear();
        shape.graphics.beginFill(0xffffff);
        shape.graphics.drawCircle(
                mask2.x + x2 - x - x1,
                mask2.y + y2 - y - y1,
                mask2.radius);

        otherMask.fillRect(otherMask.rect, 0x00000000);
        otherMask.draw(shape);

        return mask.hitTest(Static.origin, 1, otherMask, Static.origin, 1);
    }
}
