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
    var logicRateText:TextField;

    var textFormat:TextFormat;
    var badTextFormat:TextFormat;

    public function new() {
        enabled = true;
        sprite = new Sprite();

        textFormat = new TextFormat();
        textFormat.color = 0xffffffff;
        textFormat.align = TextFormatAlign.LEFT;
        textFormat.size = 16;

        badTextFormat = new TextFormat();
        badTextFormat.color = 0xffff0000;
        badTextFormat.align = TextFormatAlign.LEFT;
        badTextFormat.size = 16;

        fpsText = new TextField();
        logicRateText = new TextField();
        logicRateText.y = 20;

        sprite.addChild(fpsText);
        sprite.addChild(logicRateText);
    }

    public function begin(frame:Int):Void {
    }

    public function end():Void {
    }

    public function update(frame:Int, performanceInfo:PerformanceInfo):Void {
        fpsText.text = Std.string(Math.round(performanceInfo.renderFramesPerSecond));
        fpsText.setTextFormat(textFormat);

        var logicRate = Math.round(
                performanceInfo.updateFramesPerSecond
                / performanceInfo.targetFramesPerSecond) * 100;

        logicRateText.text = Std.string(logicRate) + "%";

        if (logicRate < 100) {
            logicRateText.setTextFormat(badTextFormat);
        } else {
            logicRateText.setTextFormat(textFormat);
        }
    }

    public function render(target:BitmapData, playfield:Playfield):Void {
        if (playfield != null && playfield.visible) {
            playfield.render(target, Static.origin, Static.identity);
        }

        target.draw(sprite);
    }
}
