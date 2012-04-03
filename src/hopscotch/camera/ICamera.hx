package hopscotch.camera;

import hopscotch.engine.ScreenSize;
import flash.geom.Matrix;

interface ICamera {
    function update(frame:Int, screenSize:ScreenSize, matrix:Matrix):Void;
}
