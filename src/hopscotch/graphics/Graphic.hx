package hopscotch.graphics;

import hopscotch.geometry.Matrix23;
import hopscotch.geometry.Vector2d;
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

    public function render (target:BitmapData, position:Vector2d, camera:Matrix23) {
    }
}
