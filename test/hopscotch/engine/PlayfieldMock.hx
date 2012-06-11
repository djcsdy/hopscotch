package hopscotch.engine;

import hopscotch.Playfield;

class PlayfieldMock extends Playfield {
    public var updateCount:Int;
    public var updateFrame:Int;

    public function new() {
        super();
    }

    override public function update(frame:Int) {
        super.update(frame);
        ++updateCount;
        updateFrame = frame;
    }
}
