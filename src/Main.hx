import flash.Lib;
import hopscotch.input.digital.Keyboard;
import hopscotch.input.digital.Button;
import hopscotch.input.digital.Key;
import hopscotch.graphics.GraphicList;
import hopscotch.graphics.Image;
import hopscotch.Entity;
import hopscotch.engine.Engine;
import hopscotch.Playfield;

class Main {
    static function main ():Void {
        var engine = new Engine(Lib.current, 640, 480, 60);
        engine.playfield = new Playfield();
        var entity = new Entity();
        engine.playfield.addEntity(entity);
        var graphicList = new GraphicList();
        entity.setGraphic(graphicList);
        graphicList.graphics.push(new Image(null));
        var keyboard = new Keyboard(Lib.current.stage);
        engine.inputs.push(keyboard.buttonForKey(Key.X));
        engine.start();
    }
}