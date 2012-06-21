package hopscotch.input.digital;

import flash.display.InteractiveObject;
import flash.events.MouseEvent;

class MouseButton extends Button {
    public function new (interactiveObject:InteractiveObject) {
        super();

        interactiveObject.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown, false, 0, true);
        interactiveObject.addEventListener(MouseEvent.MOUSE_UP, onMouseUp, false, 0, true);
    }

    function onMouseDown(event:MouseEvent) {
        press();
    }

    function onMouseUp(event:MouseEvent) {
        release();
    }
}
