package hopscotch.collision;

import flash.display.BitmapData;
import flash.display.Sprite;
import flash.display.Bitmap;
import hopscotch.errors.ArgumentNullError;
import flash.geom.Rectangle;

class PixelMask extends Mask {
    public var x:Float;
    public var y:Float;

    public var originX:Float;
    public var originY:Float;

    public var angle:Float;
    public var scale:Float;

    var bitmap:Bitmap;
    var sprite:Sprite;

    public function new (source:BitmapData) {
        super();

        if (source == null) {
            throw new ArgumentNullError("source");
        }

        bitmap = new Bitmap(source);

        x = 0;
        y = 0;

        originX = 0;
        originY = 0;

        angle = 0;
        scale = 1;

        sprite = new Sprite();

        implement(PixelMask, collidePixelMask);
        implement(BoxMask, collideBox);
        implement(CircleMask, collideCircle);
    }

    function collidePixelMask (mask2:PixelMask, x1:Float, y1:Float, x2:Float, y2:Float) {
        applyTransform(x1, y1);
        mask2.applyTransform(x2, y2);

        return bitmap.hitTestObject(mask2.bitmap);
    }

    function collideBox (mask2:BoxMask, x1:Float, y1:Float, x2:Float, y2:Float) {
        applyTransform(x1, y1);

        sprite.graphics.clear();
        sprite.graphics.beginFill(0xffffff);
        sprite.graphics.drawRect(mask2.x + x1, mask2.y + y1, mask2.width, mask2.height);

        return bitmap.hitTestObject(sprite);
    }

    function collideCircle (mask2:CircleMask, x1:Float, y1:Float, x2:Float, y2:Float) {
        applyTransform(x1, y1);

        sprite.graphics.clear();
        sprite.graphics.beginFill(0xffffff);
        sprite.graphics.drawCircle(mask2.x, mask2.y, mask2.radius);

        return bitmap.hitTestObject(sprite);
    }

    function applyTransform (x:Float, y:Float) {
        var matrix = bitmap.transform.matrix;
        matrix.a = matrix.d = 1;
        matrix.b = matrix.c = 0;
        matrix.tx = -originX;
        matrix.ty = -originY;
        matrix.rotate(angle);
        matrix.scale(scale, scale);
        matrix.tx += this.x + x;
        matrix.ty += this.y + y;
        bitmap.transform.matrix = matrix;
    }
}
