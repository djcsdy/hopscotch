package hopscotch;
import hopscotch.engine.ScreenSize;
import flash.geom.Point;
import flash.display.BitmapData;
import flash.geom.Matrix;

class Entity implements IEntity {
    public var active:Bool;
    public var visible:Bool;

    public var x:Float;
    public var y:Float;

    private var graphic:IGraphic;

    private var graphicFrame:Int;

    private static var tmpPoint:Point = new Point();

    public function new() {
        active = true;
        visible = true;

        x = 0;
        y = 0;

        graphicFrame = -1;
    }

    public function getGraphic():IGraphic {
        return graphic;
    }

    public function setGraphic(graphic:IGraphic):Void {
        if (graphic == this.graphic) {
            return;
        }

        if (this.graphic != null && graphicFrame >= 0) {
            this.graphic.endGraphic();
        }

        this.graphic = graphic;

        if (graphic != null && graphicFrame >= 0) {
            graphic.beginGraphic(graphicFrame);
        }
    }

    public function begin (frame:Int):Void {
    }

    public function end ():Void {
    }

    public function update (frame:Int):Void {
    }

    public function beginGraphic (frame:Int):Void {
        graphicFrame = frame;

        if (graphic != null) {
            graphic.beginGraphic(frame);
        }
    }

    public function endGraphic ():Void {
        if (graphic != null) {
            graphic.endGraphic();
        }

        graphicFrame = -1;
    }

    public function updateGraphic (frame:Int, screenSize:ScreenSize):Void {
        graphicFrame = frame;

        if (graphic != null) {
            graphic.updateGraphic(frame, screenSize);
        }
    }

    public function render (target:BitmapData, position:Point, camera:Matrix):Void {
        if (graphic != null) {
            tmpPoint.x = position.x + x;
            tmpPoint.y = position.y + y;

            graphic.render(target, tmpPoint, camera);
        }
    }
}