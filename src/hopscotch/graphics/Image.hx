package hopscotch.graphics;

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
    }

    public function beginGraphic (frame:Int):Void {
    }

    public function endGraphic ():Void {
    }

    public function updateGraphic (frame:Int):Void {
    }

    public function render (target:BitmapData, camera:Matrix):Void {
        // TODO draw this in the correct place.
        target.copyPixels(buffer, buffer.rect, Static.zero, null, null, true);
    }
}