package hopscotch.engine;

import hopscotch.geometry.Matrix23;
import hopscotch.geometry.Vector2d;
import flash.display.BitmapData;
import hopscotch.Playfield;

class PlayfieldMock extends Playfield {
    public var updateCount:Int;
    public var updateFrame:Int;

    public var updateGraphicCount:Int;
    public var updateGraphicFrame:Int;

    public var screenWidth:Int;
    public var screenHeight:Int;

    public var renderCount:Int;
    public var renderFrame:Int;

    public var renderTarget:BitmapData;
    public var renderPosition:Vector2d;
    public var renderCamera:Matrix23;

    public function new () {
        super();

        updateCount = 0;
        updateFrame = -1;

        updateGraphicCount = 0;
        updateGraphicFrame = -1;

        screenWidth = 0;
        screenHeight = 0;

        renderCount = 0;
        renderFrame = -1;

        renderTarget = null;
        renderPosition = null;
        renderCamera = null;
    }

    override public function update (frame:Int) {
        super.update(frame);
        ++updateCount;
        updateFrame = frame;
    }

    override public function updateGraphic (frame:Int, screenSize:ScreenSize) {
        if (updateCount <= updateGraphicCount) {
            throw "update() was not called before updateGraphic()";
        }

        super.updateGraphic(frame, screenSize);

        ++updateGraphicCount;
        updateGraphicFrame = frame;

        screenWidth = screenSize.width;
        screenHeight = screenSize.height;
    }

    override public function render (target:BitmapData, position:Vector2d, camera:Matrix23) {
        if (updateGraphicFrame <= renderFrame) {
            throw "updateGraphic() was not called before render()";
        }

        super.render(target, position, camera);

        ++renderCount;
        renderFrame = updateGraphicFrame;

        renderTarget = target;
        renderPosition = position;
        renderCamera = camera;
    }
}
