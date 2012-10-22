package hopscotch.camera;

import hopscotch.geometry.Matrix23;
import hopscotch.engine.ScreenSize;

interface ICamera {
    function begin(frame:Int):Void;
    function end():Void;
    function update(frame:Int, screenSize:ScreenSize, matrix:Matrix23):Void;
}
