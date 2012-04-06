package hopscotch.debug;

import flash.geom.Point;
import flash.display.BitmapData;

class Console implements IConsole {
    public var enabled:Bool;

    public function new() {
        enabled = true;
    }

    public function begin(frame:Int):Void {
    }

    public function end():Void {
    }

    public function update(frame:Int):Void {
    }

    public function render(target:BitmapData, playfield:Playfield):Void {
        if (playfield != null && playfield.visible) {
            playfield.render(target, Static.origin, Static.identity);
        }
    }
}
