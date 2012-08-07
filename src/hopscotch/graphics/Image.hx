package hopscotch.graphics;

import hopscotch.engine.ScreenSize;
import hopscotch.errors.ArgumentNullError;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.display.Bitmap;
import flash.display.BlendMode;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.display.BitmapData;

class Image implements IGraphic {
    public var active:Bool;
    public var visible:Bool;

    public var x:Float;
    public var y:Float;

    public var width(default, null):Int;
    public var height(default, null):Int;

    public var originX:Float;
    public var originY:Float;

    public var angle:Float;
    public var scale:Float;

    public var flipX:Bool;
    public var flipY:Bool;

    public var alpha:Float;
    public var blendMode:BlendMode;
    public var smooth:Bool;

    public var tintColor:Int;
    public var tintAmount:Float;
    public var colorizeAmount:Float;

    var sourceBitmap:Bitmap;
    var source:BitmapData;
    var sourceRect:Rectangle;

    var buffer:BitmapData;
    var bufferBitmap:Bitmap;

    var previousFlipX:Bool;
    var previousFlipY:Bool;

    var previousAlpha:Float;

    var previousTintColor:Int;
    var previousTintAmount:Float;
    var previousColorizeAmount:Float;

    public function new (source:BitmapData, clipX:Int=0, clipY:Int=0, clipWidth:Int=-1, clipHeight:Int=-1) {
        if (source == null) {
            throw new ArgumentNullError("source");
        }

        active = false;
        visible = true;

        x = 0;
        y = 0;

        originX = 0;
        originY = 0;

        angle = 0;
        scale = 1;

        flipX = false;
        flipY = false;

        alpha = 1;
        blendMode = BlendMode.NORMAL;
        smooth = true;

        tintColor = 0xffffff;
        tintAmount = 0;
        colorizeAmount = 0;

        this.source = source;
        sourceBitmap = new Bitmap(source);

        if (clipWidth < 0) {
            width = source.width;
        } else {
            width = clipWidth;
        }

        if (clipHeight < 0) {
            height = source.height;
        } else {
            height = clipHeight;
        }

        sourceRect = new Rectangle(clipX, clipY, width, height);

        buffer = new BitmapData(width, height, true);
        bufferBitmap = new Bitmap(buffer);

        updateBuffer();
    }

    public function beginGraphic (frame:Int) {
    }

    public function endGraphic () {
    }

    public function updateGraphic (frame:Int, screenSize:ScreenSize) {
    }

    public function render (target:BitmapData, position:Point, camera:Matrix) {
        if (flipX != previousFlipX
                || flipY != previousFlipY
                || alpha != previousAlpha
                || tintColor != previousTintColor
                || tintAmount != previousTintAmount
                || colorizeAmount != previousColorizeAmount) {
            updateBuffer();
        }

        if (camera.a == 1 && camera.b == 0 && camera.c == 0 && camera.d == 1
                && angle == 0 && scale == 1 && blendMode == BlendMode.NORMAL) {
            Static.point.x = position.x + x - (if (flipX) width - originX else originX) + camera.tx;
            Static.point.y = position.y + y - (if (flipY) width - originY else originY) + camera.ty;
            if (!smooth || (Static.point.x%1==0 && Static.point.y%1==0)) {
                target.copyPixels(buffer, buffer.rect, Static.point, null, null, true);
            } else {
                Static.matrix.a = Static.matrix.d = 1;
                Static.matrix.b = Static.matrix.c = 0;
                Static.matrix.tx = Static.point.x;
                Static.matrix.ty = Static.point.y;
                Static.rect.x = Static.point.x - 1; // offset to account for rounding errors and antialiasing.
                Static.rect.y = Static.point.y - 1; // offset to account for rounding errors and antialiasing.
                Static.rect.width = buffer.width + 2; // offset to account for rounding errors and antialiasing.
                Static.rect.height = buffer.height + 2; // offset to account for rounding errors and antialiasing.
                bufferBitmap.smoothing = smooth;
                #if flash
                target.draw(bufferBitmap, Static.matrix, null, blendMode, Static.rect, smooth);
                #else
                bufferBitmap.blendMode = blendMode;
                target.draw(bufferBitmap, Static.matrix, null, null, Static.rect, smooth);
                #end
            }
        } else {
            Static.matrix.a = Static.matrix.d = 1;
            Static.matrix.b = Static.matrix.c = 0;
            Static.matrix.tx = -(if (flipX) width - originX else originX);
            Static.matrix.ty = -(if (flipY) height - originY else originY);
            Static.matrix.rotate(angle);
            Static.matrix.scale(scale, scale);
            Static.matrix.tx += position.x + x;
            Static.matrix.ty += position.y + y;
            Static.matrix.concat(camera);
            bufferBitmap.smoothing = smooth;
            #if flash
            target.draw(bufferBitmap, Static.matrix, null, blendMode, null, smooth); // TODO clipRect
            #else
            bufferBitmap.blendMode = blendMode;
            target.draw(bufferBitmap, Static.matrix, null, null, null, smooth); // TODO clipRect
            #end
        }
    }

    public function centerOrigin() {
        originX = width * 0.5;
        originY = height * 0.5;
    }

    private function updateBuffer() {
        if (flipX || flipY) {
            Static.matrix.b = Static.matrix.c = 0;
            Static.matrix.a = if (flipX) -1 else 1;
            Static.matrix.d = if (flipY) -1 else 1;
            Static.matrix.tx = if (flipX) sourceRect.x + sourceRect.width else -sourceRect.x;
            Static.matrix.ty = if (flipY) sourceRect.y + sourceRect.height else -sourceRect.y;

            buffer.fillRect(buffer.rect, 0);
            buffer.draw(sourceBitmap, Static.matrix);
        } else {
            buffer.copyPixels(source, sourceRect, Static.origin);
        }

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

        previousFlipX = flipX;
        previousFlipY = flipY;

        previousAlpha = alpha;

        previousTintColor = tintColor;
        previousTintAmount = tintAmount;
        previousColorizeAmount = colorizeAmount;
    }
}