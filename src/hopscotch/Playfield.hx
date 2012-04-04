package hopscotch;

import hopscotch.graphics.IGraphic;
import hopscotch.engine.ScreenSize;
import hopscotch.camera.ICamera;
import hopscotch.errors.ArgumentNullError;
import flash.geom.Point;
import flash.display.BitmapData;
import flash.geom.Matrix;
import hopscotch.errors.IllegalOperationError;

class Playfield implements IEntity {
    public var active:Bool;
    public var visible:Bool;

    public var camera:ICamera;

    var updateFrame:Int;
    var graphicFrame:Int;

    var updaters:Array<IUpdater>;
    var graphics:Array<IGraphic>;

    var previousCamera:ICamera;
    var cameraMatrix:Matrix;

    public function new () {
        active = true;
        visible = true;

        updateFrame = -1;
        graphicFrame = -1;

        updaters = new Array<IUpdater>();
        graphics = new Array<IGraphic>();

        cameraMatrix = new Matrix();
    }

    public function addUpdater (updater:IUpdater):Void {
        if (updater == null) {
            throw new ArgumentNullError("updater");
        }

        updaters[updaters.length] = updater;

        if (updateFrame >= 0) {
            updater.begin(updateFrame);
        }
    }

    public function removeUpdater (updater:IUpdater):Void {
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

    public function addGraphic (graphic:IGraphic):Void {
        if (graphic == null) {
            throw new ArgumentNullError("graphic");
        }

        graphics[graphics.length] = graphic;

        if (graphicFrame >= 0) {
            graphic.beginGraphic(graphicFrame);
        }
    }

    public function removeGraphic (graphic:IGraphic):Void {
        if (graphic == null) {
            throw new ArgumentNullError("graphic");
        }

        var i = Lambda.indexOf(graphics, graphic);
        if (i < 0) {
            throw new IllegalOperationError("Tried to remove a graphic "
                    + "that was never added");
        }

        graphics.splice(i, 1);

        if (graphicFrame >= 0) {
            graphic.endGraphic();
        }
    }

    public function addEntity (entity:IEntity):Void {
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

    public function removeEntity (entity:IEntity):Void {
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

    public function begin (frame:Int):Void {
        updateFrame = frame;

        for (updater in updaters) {
            updater.begin(frame);
        }
    }

    public function end ():Void {
        for (updater in updaters) {
            updater.end();
        }

        updateFrame = -1;
    }

    public function update (frame:Int):Void {
        updateFrame = frame;

        for (updater in updaters) {
            if (updater.active) {
                updater.update(frame);
            }
        }
    }

    public function beginGraphic (frame:Int):Void {
        graphicFrame = frame;

        for (graphic in graphics) {
            graphic.beginGraphic(frame);
        }

        if (camera != null) {
            camera.begin(frame);
        }
        previousCamera = camera;
    }

    public function endGraphic ():Void {
        for (graphic in graphics) {
            graphic.endGraphic();
        }

        if (camera != null) {
            camera.end();
        }
        previousCamera = null;

        graphicFrame = -1;
    }

    public function updateGraphic (frame:Int, screenSize:ScreenSize):Void {
        graphicFrame = frame;

        for (graphic in graphics) {
            if (graphic.active) {
                graphic.updateGraphic(frame, screenSize);
            }
        }

        if (camera != previousCamera) {
            if (previousCamera != null) {
                previousCamera.end();
            }

            if (camera != null) {
                camera.begin(frame);
            }

            previousCamera = camera;
        }

        cameraMatrix.identity();
        if (camera != null) {
            camera.update(frame, screenSize, cameraMatrix);
            cameraMatrix.invert();
        }
    }

    public function render (target:BitmapData, position:Point, camera:Matrix):Void {
        cameraMatrix.tx += position.x;
        cameraMatrix.ty += position.y;
        cameraMatrix.concat(camera);

        for (graphic in graphics) {
            if (graphic.visible) {
                graphic.render(target, Static.origin, cameraMatrix);
            }
        }
    }
}