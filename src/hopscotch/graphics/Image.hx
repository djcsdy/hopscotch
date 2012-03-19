package hopscotch.graphics;

import flash.display.Bitmap;
import flash.geom.Matrix;
import flash.geom.Rectangle;
import flash.display.BitmapData;
import hopscotch.errors.ArgumentError;

class Image implements IGraphic {
    public var active:Bool;
    public var visible:Bool;

    public var x:Float;
    public var y:Float;

    var source:BitmapData;
    var sourceRect:Rectangle;

    var buffer:BitmapData;
    var bitmap:Bitmap;

    public function new (source:BitmapData, clipRect:Rectangle = null) {
        if (source == null) {
            throw new ArgumentError("source is null");
        }

        active = false;
        visible = true;

        this.source = source;

        if (clipRect == null) {
            sourceRect = source.rect;
        }

        buffer = new BitmapData(cast sourceRect.width, cast sourceRect.height, true);
        buffer.copyPixels(source, sourceRect, Static.zero);

        bitmap = new Bitmap(buffer);
    }

    public function beginGraphic (frame:Int):Void {
    }

    public function endGraphic ():Void {
    }

    public function updateGraphic (frame:Int):Void {
    }

    public function render (target:BitmapData, camera:Matrix):Void {
        if (camera.a == 1 && camera.b == 0 && camera.c == 0 && camera.d == 1) {
            Static.point.x = x + camera.tx;
            Static.point.y = x + camera.ty;
            target.copyPixels(buffer, buffer.rect, Static.point, null, null, true);
        } else {
            Static.matrix.a = Static.matrix.d = 1;
            Static.matrix.b = Static.matrix.c = 0;
            Static.matrix.tx = x;
            Static.matrix.ty = y;
            Static.matrix.concat(camera);
            target.draw(bitmap, Static.matrix); // TODO clip, smoothing
        }
    }
}