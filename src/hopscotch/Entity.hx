package hopscotch;

import hopscotch.collision.Mask;
import hopscotch.graphics.IGraphic;
import hopscotch.engine.ScreenSize;
import flash.geom.Point;
import flash.display.BitmapData;
import flash.geom.Matrix;

class Entity implements IEntity {
    public var active:Bool;
    public var visible:Bool;

    public var x:Float;
    public var y:Float;

    public var collisionMask:Mask;

    public var graphic:IGraphic;
    var previousGraphic:IGraphic;

    static var tmpPoint:Point = new Point();

    public function new() {
        active = true;
        visible = true;

        x = 0;
        y = 0;

        collisionMask = null;

        graphic = null;
        previousGraphic = null;
    }

    public function begin (frame:Int) {
    }

    public function end () {
    }

    public function update (frame:Int) {
    }

    public function beginGraphic (frame:Int) {
        if (graphic != null) {
            graphic.beginGraphic(frame);
            previousGraphic = graphic;
        }
    }

    public function endGraphic () {
        if (previousGraphic != null) {
            previousGraphic.endGraphic();
            previousGraphic = null;
        }
    }

    public function updateGraphic (frame:Int, screenSize:ScreenSize) {
        if (graphic != previousGraphic) {
            if (previousGraphic != null) {
                previousGraphic.endGraphic();
            }
            if (graphic != null) {
                graphic.beginGraphic(frame);
            }
            previousGraphic = graphic;
        }

        if (graphic != null && graphic.active) {
            graphic.updateGraphic(frame, screenSize);
        }
    }

    public function render (target:BitmapData, position:Point, camera:Matrix) {
        if (graphic != null && graphic.visible) {
            tmpPoint.x = position.x + x;
            tmpPoint.y = position.y + y;

            graphic.render(target, tmpPoint, camera);
        }
    }

    public function collideEntity (entity:IEntity) {
        if (collisionMask == null) {
            return false;
        }

        return entity.collideMask(collisionMask, x, y);
    }

    public function collideMask (mask:Mask, maskX:Float, maskY:Float) {
        if (collisionMask == null) {
            return false;
        }

        return collisionMask.collide(mask, x, y, maskX, maskY);
    }
}