package hopscotch;
import flash.display.Bitmap;
import flash.geom.Matrix;

interface IGraphic {
	function updateGraphic(frame:Int):Void;
	function render(target:BitmapData, camera:Matrix):Void;
}