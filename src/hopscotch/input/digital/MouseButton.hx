package hopscotch.input.digital;

import flash.events.MouseEvent;
import flash.display.DisplayObject;

class MouseButton extends Button {
    public function new (displayObject:DisplayObject) {
        super();

        displayObject.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
        displayObject.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
    }

    function onMouseDown(event:MouseEvent) {
        press();
    }

    function onMouseUp(event:MouseEvent) {
        release();
    }
}
