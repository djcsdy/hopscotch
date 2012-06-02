package hopscotch.input.analogue;

import hopscotch.input.IInput;

/** A one-dimensional analogue controller that gives a signal in the
 * range 0..1. */
class Throttle implements IInput {
    public var position(default, null):Float;

    public function new () {
        position = 0;
    }

    public function update (frame:Int) {
    }
}
