package hopscotch;
import flash.display.BitmapData;
import flash.geom.Matrix;

class Entity implements IEntity {
    public var active:Bool;
    public var visible:Bool;

    public var graphic:IGraphic;

    public function new() {
        active = true;
        visible = true;
    }

    public function begin (frame:Int):Void {
    }

    public function end ():Void {
    }

    public function update (frame:Int):Void {
    }

    public function beginGraphic (frame:Int):Void {
        if (graphic != null) {
            graphic.beginGraphic(frame);
        }
    }

    public function endGraphic ():Void {
        if (graphic != null) {
            graphic.endGraphic();
        }
    }

    public function updateGraphic (frame:Int):Void {
        if (graphic != null) {
            graphic.updateGraphic(frame);
        }
    }

    public function render (target:BitmapData, camera:Matrix):Void {
        if (graphic != null) {
            graphic.render(target, camera);
        }
    }
}