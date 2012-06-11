package hopscotch;

import hopscotch.graphics.IGraphic;
import hopscotch.engine.ScreenSize;
import hopscotch.camera.ICamera;
import hopscotch.errors.ArgumentNullError;
import flash.geom.Point;
import flash.display.BitmapData;
import flash.geom.Matrix;
import hopscotch.errors.IllegalOperationError;

class Playfield {
    public var active:Bool;
    public var visible:Bool;

    public var camera:ICamera;

    var group:Group;

    var previousCamera:ICamera;
    var cameraMatrix:Matrix;
    var tmpMatrix:Matrix;

    public function new () {
        active = true;
        visible = true;

        group = new Group();

        previousCamera = null;
        cameraMatrix = new Matrix();
        tmpMatrix = new Matrix();
    }

    public function addUpdater (updater:IUpdater) {
        group.addUpdater(updater);
    }

    public function removeUpdater (updater:IUpdater) {
        group.removeUpdater(updater);
    }

    public function addGraphic (graphic:IGraphic) {
        group.addGraphic(graphic);
    }

    public function removeGraphic (graphic:IGraphic) {
        group.removeGraphic(graphic);
    }

    public function addEntity (entity:IEntity) {
        group.addEntity(entity);
    }

    public function removeEntity (entity:IEntity) {
        group.removeEntity(entity);
    }

    public function begin (frame:Int) {
        group.begin(frame);
    }

    public function end ():Void {
        group.end();
    }

    public function update (frame:Int) {
        group.update(frame);
    }

    public function beginGraphic (frame:Int) {
        group.beginGraphic(frame);

        if (camera != null) {
            camera.begin(frame);
        }
        previousCamera = camera;
    }

    public function endGraphic () {
        group.endGraphic();

        if (camera != null) {
            camera.end();
        }
        previousCamera = null;
    }

    public function updateGraphic (frame:Int, screenSize:ScreenSize) {
        group.updateGraphic(frame, screenSize);

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

    public function render (target:BitmapData, position:Point, camera:Matrix) {
        tmpMatrix.a = cameraMatrix.a;
        tmpMatrix.b = cameraMatrix.b;
        tmpMatrix.c = cameraMatrix.c;
        tmpMatrix.d = cameraMatrix.d;
        tmpMatrix.tx = cameraMatrix.tx + position.x;
        tmpMatrix.ty = cameraMatrix.ty + position.y;
        tmpMatrix.concat(camera);

        group.render(target, Static.origin, tmpMatrix);
    }
}