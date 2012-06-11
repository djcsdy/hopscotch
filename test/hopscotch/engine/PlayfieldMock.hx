package hopscotch.engine;

import hopscotch.Playfield;

class PlayfieldMock extends Playfield {
    public var updateCount:Int;
    public var updateFrame:Int;

    public var updateGraphicCount:Int;
    public var updateGraphicFrame:Int;

    public var screenWidth:Int;
    public var screenHeight:Int;

    public function new() {
        super();

        updateCount = 0;
        updateFrame = -1;

        updateGraphicCount = 0;
        updateGraphicFrame = -1;

        screenWidth = 0;
        screenHeight = 0;
    }

    override public function update(frame:Int) {
        super.update(frame);
        ++updateCount;
        updateFrame = frame;
    }

    override public function updateGraphic(frame:Int, screenSize:ScreenSize) {
        if (updateCount <= updateGraphicCount) {
            throw "update() was not called before updateGraphic()";
        }

        super.updateGraphic(frame, screenSize);

        ++updateGraphicCount;
        updateGraphicFrame = frame;

        screenWidth = screenSize.width;
        screenHeight = screenSize.height;
    }
}
