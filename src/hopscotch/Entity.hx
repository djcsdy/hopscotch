package hopscotch;
import flash.display.BitmapData;
import flash.geom.Matrix;

class Entity implements IUpdater, implements IGraphic {
    public var active:Bool;
    public var visible:Bool;

    public var graphic:IGraphic;

    public function new() {
        active = true;
        visible = true;
    }

    public function begin (frame:Int):Void {
        // TODO
    }

    public function end ():Void {
        // TODO
    }

    public function update (frame:Int):Void {
        // TODO
    }

    public function updateGraphic (frame:Int):Void {
        // TODO
    }

    public function render (target:BitmapData, camera:Matrix):Void {
        // TODO
    }
}