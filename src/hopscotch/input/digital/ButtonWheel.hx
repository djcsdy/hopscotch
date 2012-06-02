package hopscotch.input.digital;

import hopscotch.errors.ArgumentNullError;
import hopscotch.input.analogue.Wheel;

class ButtonWheel extends Wheel {
    public var ease:Float;

    private var leftButton:Button;
    private var rightButton:Button;

    public function new (leftButton:Button, rightButton:Button, ease:Float = 0.4) {
        super();

        if (leftButton == null) {
            throw new ArgumentNullError("leftButton");
        }
        if (rightButton == null) {
            throw new ArgumentNullError("rightButton");
        }

        this.leftButton = leftButton;
        this.rightButton = rightButton;
        this.ease = ease;
    }

    override public function update (frame:Int) {
        leftButton.update(frame);
        rightButton.update(frame);

        var target:Float = 0;
        if (leftButton.pressed) {
            target = -1;
        }
        if (rightButton.pressed) {
            target += 1;
        }

        position += (target - position) * ease;
    }
}
