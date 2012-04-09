package hopscotch.debug;

import flash.text.TextFormatAlign;
import flash.text.TextFormat;
import flash.text.TextField;
import flash.display.Sprite;
import hopscotch.Static;
import flash.geom.Point;
import flash.display.BitmapData;

class Console implements IConsole {
    public var enabled:Bool;

    var sprite:Sprite;
    var fpsText:TextField;

    public function new() {
        enabled = true;
        sprite = new Sprite();

        var textFormat = new TextFormat();
        textFormat.color = 0xffffffff;
        textFormat.align = TextFormatAlign.LEFT;
        textFormat.size = 16;

        fpsText = new TextField();
        fpsText.setTextFormat(textFormat);
    }

    public function begin(frame:Int):Void {
    }

    public function end():Void {
    }

    public function update(frame:Int, performanceInfo:PerformanceInfo):Void {
        fpsText.text = Std.string(Math.round(performanceInfo.renderFramesPerSecond));
    }

    public function render(target:BitmapData, playfield:Playfield):Void {
        if (playfield != null && playfield.visible) {
            playfield.render(target, Static.origin, Static.identity);
        }

        target.draw(sprite);
    }
}
