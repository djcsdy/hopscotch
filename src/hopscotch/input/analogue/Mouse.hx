package hopscotch.input.analogue;

import flash.display.InteractiveObject;

class Mouse implements IPointer {
    public var x:Float;
    public var y:Float;

    var displayObject:InteractiveObject;

    public function new (interactiveObject:InteractiveObject) {
        this.displayObject = interactiveObject;

        x = 0;
        y = 0;
    }

    public function update (frame:Int) {
        x = displayObject.mouseX;
        y = displayObject.mouseY;
    }
}
