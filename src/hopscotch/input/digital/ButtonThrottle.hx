package hopscotch.input.digital;

import hopscotch.input.analogue.Throttle;

class ButtonThrottle extends Throttle {
    public var ease:Float;

    private var button:Button;

    public function new(button:Button, ease=0.2) {
        super();

        this.button = button;
        this.ease = ease;
    }

    override public function update(frame:Int):Void {
        button.update();

        var target:Float = if (button.pressed) 1 else 0;

        position += (target - position) * ease;
    }
}
