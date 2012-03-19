package hopscotch;
import flash.geom.Point;
import flash.display.BitmapData;
import flash.geom.Matrix;

interface IGraphic {
    var active:Bool;
    var visible:Bool;
    var x:Float;
    var y:Float;
    function beginGraphic(frame:Int):Void;
    function endGraphic():Void;
    function updateGraphic(frame:Int):Void;
    function render(target:BitmapData, camera:Matrix):Void;
}