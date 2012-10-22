package hopscotch.input.digital;

import hopscotch.errors.ArgumentNullError;
import hopscotch.input.analogue.Joystick;

class ButtonJoystick extends Joystick {
    private var upButton:Button;
    private var downButton:Button;
    private var leftButton:Button;
    private var rightButton:Button;

    private var ease:Float;

    public function new (upButton:Button, downButton:Button,
    leftButton:Button, rightButton:Button,
    ease:Float = 0.4) {
        super();

        if (upButton == null) {
            throw new ArgumentNullError("upButton");
        }
        if (downButton == null) {
            throw new ArgumentNullError("downButton");
        }
        if (leftButton == null) {
            throw new ArgumentNullError("leftButton");
        }
        if (rightButton == null) {
            throw new ArgumentNullError("rightButton");
        }

        this.upButton = upButton;
        this.downButton = downButton;
        this.leftButton = leftButton;
        this.rightButton = rightButton;

        this.ease = ease;
    }

    override public function update (frame:Int) {
        upButton.update(frame);
        downButton.update(frame);
        leftButton.update(frame);
        rightButton.update(frame);

        Static.vector2d.x = 0;
        Static.vector2d.y = 0;

        if (upButton.pressed) {
            Static.vector2d.y = -1;
        }
        if (downButton.pressed) {
            Static.vector2d.y += 1;
        }

        if (leftButton.pressed) {
            Static.vector2d.x = -1;
        }
        if (rightButton.pressed) {
            Static.vector2d.x += 1;
        }

        Static.vector2d.normalize();

        position.x += (Static.vector2d.x - position.x) * ease;
        position.y += (Static.vector2d.y - position.y) * ease;
    }
}
