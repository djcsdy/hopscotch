package hopscotch.input.analogue;

import flash.display.DisplayObject;
class Mouse implements IPointer {
    public var x:Float;
    public var y:Float;

    var displayObject:DisplayObject;

    public function new (displayObject:DisplayObject) {
        this.displayObject = displayObject;

        x = 0;
        y = 0;
    }

    public function update (frame:Int) {
        x = displayObject.mouseX;
        y = displayObject.mouseY;
    }
}
