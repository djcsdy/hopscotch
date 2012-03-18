package hopscotch.graphics;

import flash.geom.Rectangle;
import flash.display.BitmapData;
import hopscotch.errors.ArgumentError;

class Image {
    public var active:Boolean;
    public var visible:Boolean;

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
            sourceRect = source.rectangle;
        }

        buffer = new BitmapData(sourceRect.width, sourceRect.height, true);
        buffer.copyPixels(source, sourceRect, Static.zero);
    }

    override public function render(target:BitmapData, camera:Matrix):Void {
        // TODO draw this in the correct place.
        target.copyPixels(buffer, buffer.rectangle, Static.zero, null, null, true);
    }
}