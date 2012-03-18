package hopscotch;
import flash.display.BitmapData;
import flash.geom.Matrix;
import flash.Vector;
import hopscotch.errors.ArgumentError;
import hopscotch.errors.IllegalOperationError;

class Playfield implements IUpdater, implements IGraphic {
    public var active:Bool;
    public var visible:Bool;

    /** If we're currently running, the current frame, otherwise -1. */
    var frame:Int;

    var updaters:Vector<IUpdater>;
    var graphics:Vector<IGraphic>;

    public function new () {
        active = true;
        visible = true;
        frame = -1;
        updaters = new Vector<IUpdater>();
        graphics = new Vector<IGraphic>();
    }

    public function addUpdater (updater:IUpdater):Void {
        if (updater == null) {
            throw new ArgumentError("updater is null");
        }

        updaters[updaters.length] = updater;

        if (frame >= 0) {
            updater.begin(frame);
        }
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

        if (frame >= 0) {
            updater.end();
        }
    }

    public function addGraphic (graphic:IGraphic):Void {
        if (graphic == null) {
            throw new ArgumentError("graphic is null");
        }

        graphics[graphics.length] = graphic;

        if (frame >= 0) {
            graphic.begin(frame);
        }
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

        if (frame >= 0) {
            graphic.end();
        }
    }

    public function addEntity (entity:Entity):Void {
        if (entity == null) {
            throw new ArgumentError("entity is null");
        }

        updaters[updaters.length] = entity;
        graphics[graphics.length] = entity;

        if (frame >= 0) {
            entity.begin(frame);
        }
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

        if (frame >= 0) {
            entity.end();
        }
    }

    public function begin (frame:Int):Void {
        this.frame = frame;

        for (updater in updaters) {
            updater.begin(frame);
        }

        for (graphic in graphics) {
            graphic.begin(frame);
        }
    }

    public function end ():Void {
        for (updater in updaters) {
            updater.end();
        }

        for (graphic in graphics) {
            graphic.end();
        }

        this.frame = -1;
    }

    public function update (frame:Int):Void {
        this.frame = frame;

        for (updater in updaters) {
            if (updater.active) {
                updater.update(frame);
            }
        }
    }

    public function updateGraphic (frame:Int):Void {
        this.frame = frame;

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