package hopscotch.graphics;

import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.display.Bitmap;
import flash.display.BlendMode;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.display.BitmapData;
import hopscotch.errors.ArgumentError;

class Image implements IGraphic {
    public var active:Bool;
    public var visible:Bool;

    public var x:Float;
    public var y:Float;

    public var originX:Float;
    public var originY:Float;

    public var angle:Float;
    public var scale:Float;

    public var alpha:Float;
    public var blendMode:BlendMode;
    public var smooth:Bool;

    public var tintColor:Int;
    public var tintAmount:Float;
    public var colorizeAmount:Float;

    var source:BitmapData;
    var sourceRect:Rectangle;

    var buffer:BitmapData;
    var bitmap:Bitmap;

    var previousAlpha:Float;
    var previousTintColor:Int;
    var previousTintAmount:Float;
    var previousColorizeAmount:Float;

    public function new (source:BitmapData, clipRect:Rectangle = null) {
        if (source == null) {
            throw new ArgumentError("source is null");
        }

        active = false;
        visible = true;

        x = 0;
        y = 0;

        originX = 0;
        originY = 0;

        angle = 0;
        scale = 1;

        alpha = 1;
        blendMode = BlendMode.NORMAL;
        smooth = true;

        tintColor = 0xffffff;
        tintAmount = 0;
        colorizeAmount = 0;

        this.source = source;

        if (clipRect == null) {
            sourceRect = source.rect;
        }

        buffer = new BitmapData(cast sourceRect.width, cast sourceRect.height, true);
        bitmap = new Bitmap(buffer);

        updateBuffer();
    }

    public function beginGraphic (frame:Int):Void {
    }

    public function endGraphic ():Void {
    }

    public function updateGraphic (frame:Int):Void {
    }

    public function render (target:BitmapData, position:Point, camera:Matrix):Void {
        if (tintColor != previousTintColor || tintAmount != previousTintAmount
                || colorizeAmount != previousColorizeAmount
                || alpha != previousAlpha) {
            updateBuffer();
        }

        if (camera.a == 1 && camera.b == 0 && camera.c == 0 && camera.d == 1
                && angle == 0 && scale == 1 && blendMode == BlendMode.NORMAL) {
            Static.point.x = position.x + x - originX + camera.tx;
            Static.point.y = position.y + y - originY + camera.ty;
            target.copyPixels(buffer, buffer.rect, Static.point, null, null, true);
        } else {
            Static.matrix.a = Static.matrix.d = 1;
            Static.matrix.b = Static.matrix.c = 0;
            Static.matrix.tx = -originX;
            Static.matrix.ty = -originY;
            Static.matrix.rotate(angle);
            Static.matrix.scale(scale, scale);
            Static.matrix.tx += position.x + x;
            Static.matrix.ty += position.y + y;
            Static.matrix.concat(camera);
            bitmap.smoothing = smooth;
            target.draw(bitmap, Static.matrix, null, blendMode, null, smooth); // TODO clipRect
        }
    }

    private function updateBuffer():Void {
        buffer.copyPixels(source, sourceRect, Static.origin);
        if (tintAmount != 0 || alpha != 1) {
            Static.colorTransform.alphaMultiplier = alpha;
            Static.colorTransform.alphaOffset = 0;
            Static.colorTransform.redMultiplier = colorizeAmount * (1-tintAmount)
                    + (1-colorizeAmount) * (tintAmount * ((tintColor >> 16 & 0xff) / 255 - 1) + 1);
            Static.colorTransform.greenMultiplier = colorizeAmount * (1-tintAmount)
                    + (1-colorizeAmount) * (tintAmount * ((tintColor >> 8 & 0xff) / 255 - 1) + 1);
            Static.colorTransform.blueMultiplier = colorizeAmount * (1-tintAmount)
                    + (1-colorizeAmount) * (tintAmount * ((tintColor & 0xff) / 255 - 1) + 1);
            Static.colorTransform.redOffset = (tintColor >> 16 & 0xff) * tintAmount * colorizeAmount;
            Static.colorTransform.greenOffset = (tintColor >> 8 & 0xff) * tintAmount * colorizeAmount;
            Static.colorTransform.blueOffset = (tintColor & 0xff) * tintAmount * colorizeAmount;
            buffer.colorTransform(buffer.rect, Static.colorTransform);
        }

        previousAlpha = alpha;
        previousTintColor = tintColor;
        previousTintAmount = tintAmount;
        previousColorizeAmount = colorizeAmount;
    }
}