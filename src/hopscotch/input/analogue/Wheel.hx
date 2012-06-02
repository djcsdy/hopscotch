package hopscotch.input.analogue;

import hopscotch.input.IInput;

/** A one-dimensional analogue controller that gives a signal in the
 * range -1..1. */
class Wheel implements IInput {
    public var position(default, null):Float;

    public function new () {
        position = 0;
    }

    public function update (frame:Int) {
    }
}
