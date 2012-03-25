package hopscotch.input.digital;
class Button implements IInput {
    public var pressed(default, null):Bool;
    public var justPressed(default, null):Bool;
    public var justReleased(default, null):Bool;
    public var pressedTicks(default, null):Int;
    public var releasedTicks(default, null):Int;

    private var pressQueued:Bool;

    public function new() {
        pressQueued = false;
    }

    private function press():Void {
        pressQueued = true;
    }

    private function release():Void {
        pressQueued = false;
    }

    public function update(frame:Int):Void {
        if (pressQueued) {
            pressed = true;
            justPressed = pressedTicks == 0;
            releasedTicks = 0;
            justReleased = false;
            pressedTicks++;
        } else {
            pressed = false;
            justReleased = releasedTicks == 0;
            pressedTicks = 0;
            justPressed = false;
            releasedTicks++;
        }
    }
}
