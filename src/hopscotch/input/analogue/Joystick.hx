package hopscotch.input.analogue;

import hopscotch.geometry.Vector2d;
import hopscotch.input.IInput;

/** A two-dimensional analogue input device that gives a position in the range
 * (-1,-1)..(1,1). */
class Joystick implements IInput {
    public var position(default, null):Vector2d;

    public function new () {
        position = new Vector2d();
    }

    public function update (frame:Int) {
    }
}
