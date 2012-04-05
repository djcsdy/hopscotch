package hopscotch.collision;

import flash.geom.Matrix;
import flash.geom.Point;
import flash.display.BitmapData;

interface IConsole {
    var enabled:Bool;
    function begin(frame:Int):Void;
    function end():Void;
    function update(frame:Int):Void;
    function render(target:BitmapData):Void;
}
