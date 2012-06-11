package hopscotch.engine;

import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Matrix;
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
    public var renderPosition:Point;
    public var renderCamera:Matrix;

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

    override public function render (target:BitmapData, position:Point, camera:Matrix) {
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
