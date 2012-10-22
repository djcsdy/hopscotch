package hopscotch.debug;

import hopscotch.Playfield;
import flash.text.TextFieldAutoSize;
import flash.system.System;
import flash.text.TextFormatAlign;
import flash.text.TextFormat;
import flash.text.TextField;
import flash.display.Sprite;
import hopscotch.Static;
import flash.display.BitmapData;

class Console implements IConsole {
    public var enabled:Bool;

    var sprite:Sprite;
    var fpsText:TextField;
    var logicRateText:TextField;
    var memoryText:TextField;
    var updateTimeText:TextField;
    var graphicUpdateTimeText:TextField;
    var renderTimeText:TextField;
    var systemTimeText:TextField;

    public function new() {
        enabled = true;
        sprite = new Sprite();

        var fpsFormat = new TextFormat();
        fpsFormat.font = "Arial";
        fpsFormat.bold = true;
        fpsFormat.color = 0xffffffff;
        fpsFormat.align = TextFormatAlign.LEFT;
        fpsFormat.size = 20;

        var fpsLabelFormat = new TextFormat();
        fpsLabelFormat.font = "Arial";
        fpsLabelFormat.color = 0xffdddddd;
        fpsLabelFormat.align = TextFormatAlign.LEFT;
        fpsLabelFormat.size = 15;

        fpsText = new TextField();
        fpsText.defaultTextFormat = fpsFormat;
        fpsText.x = 2;
        fpsText.y = -1;
        fpsText.autoSize = TextFieldAutoSize.LEFT;

        var fpsLabel = new TextField();
        fpsLabel.defaultTextFormat = fpsLabelFormat;
        fpsLabel.x = 28;
        fpsLabel.y = 4;
        fpsLabel.autoSize = TextFieldAutoSize.LEFT;
        fpsLabel.text = "FPS";

        var smallFormat = new TextFormat();
        smallFormat.font = "Arial";
        smallFormat.bold = true;
        smallFormat.color = 0xffffffff;
        smallFormat.align = TextFormatAlign.LEFT;
        smallFormat.size = 10;

        var smallLabelFormat = new TextFormat();
        smallLabelFormat.font = "Arial";
        smallLabelFormat.color = 0xffdddddd;
        smallLabelFormat.align = TextFormatAlign.RIGHT;
        smallLabelFormat.size = 10;

        var logicRateLabel = new TextField();
        logicRateLabel.defaultTextFormat = smallLabelFormat;
        logicRateLabel.width = 0;
        logicRateLabel.x = 160;
        logicRateLabel.y = -1;
        logicRateLabel.autoSize = TextFieldAutoSize.RIGHT;
        logicRateLabel.text = "LOGIC RATE:";

        logicRateText = new TextField();
        logicRateText.defaultTextFormat = smallFormat;
        logicRateText.x = 160;
        logicRateText.y = -1;
        logicRateText.autoSize = TextFieldAutoSize.LEFT;

        var memoryLabel = new TextField();
        memoryLabel.defaultTextFormat = smallLabelFormat;
        memoryLabel.width = 0;
        memoryLabel.x = 160;
        memoryLabel.y = 9;
        memoryLabel.autoSize = TextFieldAutoSize.RIGHT;
        memoryLabel.text = "MEMORY:";

        memoryText = new TextField();
        memoryText.defaultTextFormat = smallFormat;
        memoryText.x = 160;
        memoryText.y = 9;
        memoryText.autoSize = TextFieldAutoSize.LEFT;

        var updateTimeLabel = new TextField();
        updateTimeLabel.defaultTextFormat = smallLabelFormat;
        updateTimeLabel.width = 0;
        updateTimeLabel.x = 280;
        updateTimeLabel.y = -1;
        updateTimeLabel.autoSize = TextFieldAutoSize.RIGHT;
        updateTimeLabel.text = "UPDATE:";

        updateTimeText = new TextField();
        updateTimeText.defaultTextFormat = smallFormat;
        updateTimeText.x = 280;
        updateTimeText.y = -1;
        updateTimeText.autoSize = TextFieldAutoSize.LEFT;

        var graphicUpdateTimeLabel = new TextField();
        graphicUpdateTimeLabel.defaultTextFormat = smallLabelFormat;
        graphicUpdateTimeLabel.width = 0;
        graphicUpdateTimeLabel.x = 280;
        graphicUpdateTimeLabel.y = 9;
        graphicUpdateTimeLabel.autoSize = TextFieldAutoSize.RIGHT;
        graphicUpdateTimeLabel.text = "GRAPHIC:";
        
        graphicUpdateTimeText = new TextField();
        graphicUpdateTimeText.defaultTextFormat = smallFormat;
        graphicUpdateTimeText.x = 280;
        graphicUpdateTimeText.y = 9;
        graphicUpdateTimeText.autoSize = TextFieldAutoSize.LEFT;

        var renderTimeLabel = new TextField();
        renderTimeLabel.defaultTextFormat = smallLabelFormat;
        renderTimeLabel.width = 0;
        renderTimeLabel.x = 380;
        renderTimeLabel.y = -1;
        renderTimeLabel.autoSize = TextFieldAutoSize.RIGHT;
        renderTimeLabel.text = "RENDER:";
        
        renderTimeText = new TextField();
        renderTimeText.defaultTextFormat = smallFormat;
        renderTimeText.x = 380;
        renderTimeText.y = -1;
        renderTimeText.autoSize = TextFieldAutoSize.LEFT;

        var systemTimeLabel = new TextField();
        systemTimeLabel.defaultTextFormat = smallLabelFormat;
        systemTimeLabel.width = 0;
        systemTimeLabel.x = 380;
        systemTimeLabel.y = 9;
        systemTimeLabel.autoSize = TextFieldAutoSize.RIGHT;
        systemTimeLabel.text = "SYSTEM:";

        systemTimeText = new TextField();
        systemTimeText.defaultTextFormat = smallFormat;
        systemTimeText.x = 380;
        systemTimeText.y = 9;
        systemTimeText.autoSize = TextFieldAutoSize.LEFT;

        sprite.graphics.beginFill(0x000000, 0.6);
        sprite.graphics.drawRect(0, 0, 440, 24);

        sprite.addChild(fpsText);
        sprite.addChild(fpsLabel);
        sprite.addChild(logicRateLabel);
        sprite.addChild(logicRateText);
        sprite.addChild(memoryLabel);
        sprite.addChild(memoryText);
        sprite.addChild(updateTimeLabel);
        sprite.addChild(updateTimeText);
        sprite.addChild(graphicUpdateTimeLabel);
        sprite.addChild(graphicUpdateTimeText);
        sprite.addChild(renderTimeLabel);
        sprite.addChild(renderTimeText);
        sprite.addChild(systemTimeLabel);
        sprite.addChild(systemTimeText);
    }

    public function begin(frame:Int) {
    }

    public function end() {
    }

    public function update(frame:Int, performanceInfo:PerformanceInfo) {
        fpsText.text = Std.string(Math.round(performanceInfo.renderFramesPerSecond));

        var logicRate = Math.round(
                performanceInfo.updateFramesPerSecond
                / performanceInfo.targetFramesPerSecond) * 100;
        logicRateText.text = Std.string(logicRate) + "%";

        updateTimeText.text = Std.string(Math.round(performanceInfo.updateTimeMs * 100) / 100) + "ms";
        graphicUpdateTimeText.text = Std.string(Math.round(performanceInfo.graphicUpdateTimeMs * 100) / 100) + "ms";
        renderTimeText.text = Std.string(Math.round(performanceInfo.renderTimeMs * 100) / 100) + "ms";
        systemTimeText.text = Std.string(Math.round(performanceInfo.systemTimeMs * 100) / 100) + "ms";
        memoryText.text = Std.string(Math.round(System.totalMemory * 100 / 1024 / 1024) / 100) + "MiB";
    }

    public function render(target:BitmapData, playfield:Playfield) {
        if (playfield != null && playfield.visible) {
            playfield.render(target, Static.origin, Static.identity);
        }

        target.draw(sprite);
    }
}
