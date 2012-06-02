package hopscotch.input.analogue;

import hopscotch.input.IInput;
import flash.geom.Point;

/** A two-dimensional analogue input device that gives a position in the range
 * (-1,-1)..(1,1). */
class Joystick implements IInput {
    public var position(default, null):Point;

    public function new () {
        position = new Point();
    }

    public function update (frame:Int) {
    }
}
