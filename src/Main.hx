import hopscotch.Entity;
import hopscotch.engine.Engine;
import hopscotch.Playfield;

class Main {
    static function main ():Void {
        var engine = new Engine(flash.Lib.current, 640, 480, 60);
        engine.playfield = new Playfield();
        engine.playfield.addEntity(new Entity());
        engine.start();
    }
}