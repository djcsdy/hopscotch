package hopscotch.graphics;

import hopscotch.engine.ScreenSize;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.display.BitmapData;

class GraphicList implements IGraphic {
    public var active:Bool;
    public var visible:Bool;

    public var graphics(default, null):Array<IGraphic>;

    public function new (?graphics:Iterable<IGraphic>) {
        active = false;
        visible = true;
        this.graphics = if (graphics == null) [] else Lambda.array(graphics);
    }

    public function beginGraphic (frame:Int) {
        for (graphic in graphics) {
            if (graphic != null) {
                graphic.beginGraphic(frame);
            }
        }
    }

    public function endGraphic () {
        for (graphic in graphics) {
            if (graphic != null) {
                graphic.endGraphic();
            }
        }
    }

    public function updateGraphic (frame:Int, screenSize:ScreenSize) {
        for (graphic in graphics) {
            if (graphic != null && graphic.active) {
                graphic.updateGraphic(frame, screenSize);
            }
        }
    }

    public function render (target:BitmapData, position:Point, camera:Matrix) {
        for (graphic in graphics) {
            if (graphic != null && graphic.visible) {
                graphic.render(target, position, camera);
            }
        }
    }
}
