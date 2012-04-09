package hopscotch.debug;

import flash.system.System;
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
    var updateTimeText:TextField;
    var graphicUpdateTimeText:TextField;
    var renderTimeText:TextField;
    var systemTimeText:TextField;
    var memText:TextField;

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
        fpsText.defaultTextFormat = textFormat;

        logicRateText = new TextField();
        logicRateText.defaultTextFormat = textFormat;
        logicRateText.y = 20;
        
        updateTimeText = new TextField();
        updateTimeText.defaultTextFormat = textFormat;
        updateTimeText.y = 40;
        
        graphicUpdateTimeText = new TextField();
        graphicUpdateTimeText.defaultTextFormat = textFormat;
        graphicUpdateTimeText.y = 60;
        
        renderTimeText = new TextField();
        renderTimeText.defaultTextFormat = textFormat;
        renderTimeText.y = 80;
        
        systemTimeText = new TextField();
        systemTimeText.defaultTextFormat = textFormat;
        systemTimeText.y = 100;

        memText = new TextField();
        memText.defaultTextFormat = textFormat;
        memText.y = 120;

        sprite.addChild(fpsText);
        sprite.addChild(logicRateText);
        sprite.addChild(updateTimeText);
        sprite.addChild(graphicUpdateTimeText);
        sprite.addChild(renderTimeText);
        sprite.addChild(systemTimeText);
        sprite.addChild(memText);
    }

    public function begin(frame:Int):Void {
    }

    public function end():Void {
    }

    public function update(frame:Int, performanceInfo:PerformanceInfo):Void {
        fpsText.text = Std.string(Math.round(performanceInfo.renderFramesPerSecond));

        var logicRate = Math.round(
                performanceInfo.updateFramesPerSecond
                / performanceInfo.targetFramesPerSecond) * 100;

        logicRateText.text = Std.string(logicRate) + "%";

        if (logicRate < 100) {
            logicRateText.setTextFormat(badTextFormat);
        } else {
            logicRateText.setTextFormat(textFormat);
        }
        
        updateTimeText.text = Std.string(Math.round(performanceInfo.updateTimeMs)) + "ms";
        graphicUpdateTimeText.text = Std.string(Math.round(performanceInfo.graphicUpdateTimeMs)) + "ms";
        renderTimeText.text = Std.string(Math.round(performanceInfo.renderTimeMs)) + "ms";
        systemTimeText.text = Std.string(Math.round(performanceInfo.systemTimeMs)) + "ms";
        memText.text = Std.string(Math.round(System.totalMemory * 100 / 1024 / 1024) / 100) + "MiB";
    }

    public function render(target:BitmapData, playfield:Playfield):Void {
        if (playfield != null && playfield.visible) {
            playfield.render(target, Static.origin, Static.identity);
        }

        target.draw(sprite);
    }
}
