import hopscotch.graphics.GraphicList;
import hopscotch.graphics.Image;
import hopscotch.Entity;
import hopscotch.engine.Engine;
import hopscotch.Playfield;

class Main {
    static function main ():Void {
        var engine = new Engine(flash.Lib.current, 640, 480, 60);
        engine.playfield = new Playfield();
        var entity = new Entity();
        engine.playfield.addEntity(entity);
        var graphicList = new GraphicList();
        entity.setGraphic(graphicList);
        graphicList.graphics.push(new Image(null));
        engine.start();
    }
}