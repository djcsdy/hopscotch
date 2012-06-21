package hopscotch;

import hopscotch.collision.Mask;
import flash.geom.Matrix;
import flash.display.BitmapData;
import flash.geom.Point;
import hopscotch.engine.ScreenSize;
import hopscotch.errors.IllegalOperationError;
import hopscotch.errors.ArgumentNullError;
import hopscotch.graphics.IGraphic;

class Group implements IEntity {
    public var active:Bool;
    public var visible:Bool;

    var updateFrame:Int;
    var graphicFrame:Int;

    var updaters:Array<IUpdater>;
    var graphics:Array<IGraphic>;

    public function new () {
        active = true;
        visible = true;

        updateFrame = -1;
        graphicFrame = -1;

        updaters = [];
        graphics = [];
    }

    public function addUpdater (updater:IUpdater) {
        if (updater == null) {
            throw new ArgumentNullError("updater");
        }

        updaters[updaters.length] = updater;

        if (updateFrame >= 0) {
            updater.begin(updateFrame);
        }
    }

    public function removeUpdater (updater:IUpdater) {
        if (updater == null) {
            throw new ArgumentNullError("updater");
        }

        var i = Lambda.indexOf(updaters, updater);
        if (i < 0) {
            throw new IllegalOperationError("Tried to remove an updater "
                    + "that was never added");
        }

        updaters.splice(i, 1);

        if (updateFrame >= 0) {
            updater.end();
        }
    }

    public function addGraphic (graphic:IGraphic) {
        if (graphic == null) {
            throw new ArgumentNullError("graphic");
        }

        graphics[graphics.length] = graphic;

        if (graphicFrame >= 0) {
            graphic.beginGraphic(graphicFrame);
        }
    }

    public function removeGraphic (graphic:IGraphic) {
        if (graphic == null) {
            throw new ArgumentNullError("graphic");
        }

        var i = Lambda.indexOf(graphics, graphic);
        if (i < 0) {
            throw new IllegalOperationError("Tried to remove a graphic "
                    + "that was never added.");
        }

        graphics.splice(i, 1);

        if (graphicFrame >= 0) {
            graphic.endGraphic();
        }
    }

    public function addEntity (entity:IEntity) {
        if (entity == null) {
            throw new ArgumentNullError("entity");
        }

        updaters[updaters.length] = entity;
        graphics[graphics.length] = entity;

        if (updateFrame >= 0) {
            entity.begin(updateFrame);
        }

        if (graphicFrame >= 0) {
            entity.beginGraphic(graphicFrame);
        }
    }

    public function removeEntity (entity:IEntity) {
        if (entity == null) {
            throw new ArgumentNullError("entity");
        }

        var updatersIndex = Lambda.indexOf(updaters, entity);
        var graphicsIndex = Lambda.indexOf(graphics, entity);

        if (updatersIndex < 0 || graphicsIndex < 0) {
            throw new IllegalOperationError("Tried to remove an entity "
                    + "that was never added");
        }

        updaters.splice(updatersIndex, 1);
        graphics.splice(graphicsIndex, 1);

        if (updateFrame >= 0) {
            entity.end();
        }

        if (graphicFrame >= 0) {
            entity.endGraphic();
        }
    }

    public function begin (frame:Int) {
        updateFrame = frame;

        for (updater in updaters) {
            updater.begin(frame);
        }
    }

    public function end () {
        for (updater in updaters) {
            updater.end();
        }

        updateFrame = -1;
    }

    public function update (frame:Int) {
        updateFrame = frame;

        for (updater in updaters) {
            if (updater.active) {
                updater.update(frame);
            }
        }
    }

    public function beginGraphic (frame:Int) {
        graphicFrame = frame;

        for (graphic in graphics) {
            graphic.beginGraphic(frame);
        }
    }

    public function endGraphic () {
        for (graphic in graphics) {
            graphic.endGraphic();
        }

        graphicFrame = -1;
    }

    public function updateGraphic (frame:Int, screenSize:ScreenSize) {
        graphicFrame = frame;

        for (graphic in graphics) {
            if (graphic.active) {
                graphic.updateGraphic(frame, screenSize);
            }
        }
    }

    public function render (target:BitmapData, position:Point, camera:Matrix) {
        for (graphic in graphics) {
            if (graphic.visible) {
                graphic.render(target, position, camera);
            }
        }
    }

    public function collideEntity (entity:IEntity) {
        for (updater in updaters) {
            if (Std.is(updater, IEntity)) {
                if ((cast(updater, IEntity)).collideEntity(entity)) {
                    return true;
                }
            }
        }

        return false;
    }

    public function collideMask (mask:Mask, maskX:Float, maskY:Float) {
        for (updater in updaters) {
            if (Std.is(updater, IEntity)) {
                if ((cast(updater, IEntity)).collideMask(mask, maskX, maskY)) {
                    return true;
                }
            }
        }

        return false;
    }
}
