package hopscotch;
import flash.display.BitmapData;
import flash.geom.Matrix;

interface IGraphic {
    var active:Bool;
    var visible:Bool;
    function begin(frame:Int):Void;
    function end():Void;
    function updateGraphic(frame:Int):Void;
    function render(target:BitmapData, camera:Matrix):Void;
}