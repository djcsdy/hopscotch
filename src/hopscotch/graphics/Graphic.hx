package hopscotch.graphics;

import flash.geom.Matrix;
import flash.geom.Point;
import flash.display.BitmapData;
import hopscotch.engine.ScreenSize;

class Graphic implements IGraphic {
    public var active:Bool;
    public var visible:Bool;

    public function new () {
        active = false;
        visible = true;
    }

    public function beginGraphic (frame:Int) {
    }

    public function endGraphic () {
    }

    public function updateGraphic (frame:Int, screenSize:ScreenSize) {
    }

    public function render (target:BitmapData, position:Point, camera:Matrix) {
    }
}
