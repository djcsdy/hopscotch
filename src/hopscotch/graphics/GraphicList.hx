package hopscotch.graphics;

import flash.geom.Matrix;
import flash.geom.Point;
import flash.display.BitmapData;
import hopscotch.IGraphic;

class GraphicList implements IGraphic {
    public var active:Bool;
    public var visible:Bool;

    public var graphics(default, null):Array<IGraphic>;

    public function new() {
        active = false;
        visible = true;
        graphics = new Array<IGraphic>();
    }

    public function beginGraphic(frame:Int):Void {
        for (graphic in graphics) {
            if (graphic != null) {
                graphic.beginGraphic(frame);
            }
        }
    }

    public function endGraphic():Void {
        for (graphic in graphics) {
            if (graphic != null) {
                graphic.endGraphic();
            }
        }
    }

    public function updateGraphic(frame:Int):Void {
        for (graphic in graphics) {
            if (graphic != null && graphic.active) {
                graphic.updateGraphic(frame);
            }
        }
    }

    public function render(target:BitmapData, position:Point, camera:Matrix):Void {
        for (graphic in graphics) {
            if (graphic != null && graphic.visible) {
                graphic.render(target, position, camera);
            }
        }
    }
}