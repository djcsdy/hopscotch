package hopscotch;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.Vector;
import hopscotch.errors.ArgumentError;
import hopscotch.errors.IllegalOperationError;

class Playfield implements IUpdater, implements IGraphic {
    public var active:Bool;
    public var visible:Bool;

    var updaters:Vector<IUpdater>;
    var graphics:Vector<IGraphic>;

    public function new () {
        active = true;
        visible = true;
        updaters = new Vector<IUpdater>();
        graphics = new Vector<IGraphic>();
    }

    public function addUpdater (updater:IUpdater):Void {
        if (updater == null) {
            throw new ArgumentError("updater is null");
        }

        updaters[updaters.length] = updater;
    }

    public function removeUpdater (updater:IUpdater):Void {
        if (updater == null) {
            throw new ArgumentError("updater is null");
        }

        var i = updaters.indexOf(updater);
        if (i < 0) {
            throw new IllegalOperationError("Tried to remove an updater "
                    + "that was never added");
        }

        updaters.splice(i, 1);
    }

    public function addGraphic (graphic:IGraphic):Void {
        if (graphic == null) {
            throw new ArgumentError("graphic is null");
        }

        graphics[graphics.length] = graphic;
    }

    public function removeGraphic (graphic:IGraphic):Void {
        if (graphic == null) {
            throw new ArgumentError("graphic is null");
        }

        var i = graphics.indexOf(graphic);
        if (i < 0) {
            throw new IllegalOperationError("Tried to remove a graphic "
                    + "that was never added");
        }

        graphics.splice(i, 1);
    }

    public function addEntity (entity:Entity):Void {
        if (entity == null) {
            throw new ArgumentError("entity is null");
        }

        updaters[updaters.length] = entity;
        graphics[graphics.length] = entity;
    }

    public function removeEntity (entity:Entity):Void {
        if (entity == null) {
            throw new ArgumentError("entity is null");
        }

        var updatersIndex = updaters.indexOf(entity);
        var graphicsIndex = graphics.indexOf(entity);

        if (updatersIndex < 0 || graphicsIndex < 0) {
            throw new IllegalOperationError("Tried to remove an entity "
                    + "that was never added");
        }

        updaters.splice(updatersIndex, 1);
        graphics.splice(graphicsIndex, 1);
    }

    public function begin (frame:Int):Void {
        for (updater in updaters) {
            updater.begin(frame);
        }
    }

    public function end ():Void {
        for (updater in updaters) {
            updater.end();
        }
    }

    public function update (frame:Int):Void {
        for (updater in updaters) {
            if (updater.active) {
                updater.update(frame);
            }
        }
    }

    public function updateGraphic (frame:Int):Void {
        for (graphic in graphics) {
            if (graphic.active) {
                graphic.updateGraphic(frame);
            }
        }
    }

    public function render (target:BitmapData, camera:Matrix):Void {
        for (graphic in graphics) {
            if (graphic.visible) {
                graphic.render(target, camera);
            }
        }
    }
}