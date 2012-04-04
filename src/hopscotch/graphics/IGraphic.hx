package hopscotch.graphics;

import hopscotch.engine.ScreenSize;
import flash.geom.Point;
import flash.display.BitmapData;
import flash.geom.Matrix;

interface IGraphic {
    var active:Bool;
    var visible:Bool;
    function beginGraphic(frame:Int):Void;
    function endGraphic():Void;
    function updateGraphic(frame:Int, screenSize:ScreenSize):Void;
    function render(target:BitmapData, position:Point, camera:Matrix):Void;
}