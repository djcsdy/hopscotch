package hopscotch.input.digital;

import hopscotch.input.IInput;

class Button implements IInput {
    public var pressed(default, null):Bool;
    public var justPressed(default, null):Bool;
    public var justReleased(default, null):Bool;
    public var pressedFrame(default, null):Int;
    public var releasedFrame(default, null):Int;

    private var pressQueued:Bool;

    public function new () {
        pressQueued = false;
        pressedFrame = -1;
        releasedFrame = -1;
    }

    public function press () {
        pressQueued = true;
    }

    public function release () {
        pressQueued = false;
    }

    public function update (frame:Int) {
        if (pressQueued) {
            if (!pressed || pressedFrame == frame) {
                pressedFrame = frame;
                justPressed = true;
            } else {
                justPressed = false;
            }
            pressed = true;
            justReleased = false;
        } else {
            if (pressed || releasedFrame == frame) {
                releasedFrame = frame;
                justReleased = true;
            } else {
                justReleased = false;
            }
            pressed = false;
            justPressed = false;
        }
    }
}
