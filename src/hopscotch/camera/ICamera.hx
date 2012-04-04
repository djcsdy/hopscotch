package hopscotch.camera;

import hopscotch.engine.ScreenSize;
import flash.geom.Matrix;

interface ICamera {
    function begin(frame:Int):Void;
    function end():Void;
    function update(frame:Int, screenSize:ScreenSize, matrix:Matrix):Void;
}
