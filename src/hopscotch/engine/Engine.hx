package hopscotch.engine;

import hopscotch.Static;
import hopscotch.Playfield;
import hopscotch.debug.Console;
import hopscotch.debug.IConsole;
import flash.events.Event;
import flash.display.Bitmap;
import flash.display.BitmapData;
import hopscotch.errors.ArgumentError;
import hopscotch.errors.ArgumentNullError;
import hopscotch.input.IInput;
import hopscotch.engine.ScreenSize;
import flash.display.DisplayObjectContainer;

class Engine {
    public var playfield:Playfield;
    public var inputs(default, null):Array<IInput>;
    public var console:IConsole;

    var renderTarget:DisplayObjectContainer;
    var screenSize:ScreenSize;

    var targetBitmapData:BitmapData;
    var targetBitmap:Bitmap;

    var framesPerMillisecond:Float;

    var timeSource:ITimeSource;

    var running:Bool;
    var startTime:Int;

    var previousFrame:Int;

    var previousPlayfield:Playfield;

    var previousConsole:IConsole;
    var consoleActive:Bool;
    var previousConsoleActive:Bool;

    public function new (renderTarget:DisplayObjectContainer,
            width:Int, height:Int, framesPerSecond:Float,
            timeSource:ITimeSource=null) {
        if (renderTarget == null) {
            throw new ArgumentNullError("renderTarget");
        }

        if (width <= 0) {
            throw new ArgumentError("width out of range");
        }

        if (height <= 0) {
            throw new ArgumentError("height out of range");
        }

        if (framesPerSecond <= 0) {
            throw new ArgumentError("framesPerSecond out of range");
        }

        this.renderTarget = renderTarget;
        this.screenSize = new ScreenSize(width, height);

        targetBitmapData = new BitmapData(width, height, false, 0x000000);
        targetBitmap = new Bitmap(targetBitmapData);

        framesPerMillisecond = framesPerSecond / 1000;

        this.timeSource =
                if (timeSource == null) new TimeSource()
                else timeSource;

        playfield = null;

        inputs = [];

        running = false;
        startTime = 0;

        previousFrame = 0;

        previousPlayfield = null;

        console = new Console();
        previousConsole = null;
        consoleActive = false;
        previousConsoleActive = false;
    }

    public function start():Void {
        if (!running) {
            running = true;
            startTime = Math.floor(timeSource.getTime() -
                    (previousFrame - 1) / framesPerMillisecond);

            renderTarget.addChild(targetBitmap);

            renderTarget.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
    }

    public function stop():Void {
        if (running) {
            running = false;

            renderTarget.removeChild(targetBitmap);

            renderTarget.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
        }
    }

    function onEnterFrame(event:Event):Void {
        if (!running) {
            return;
        }

        var now = timeSource.getTime();
        var targetFrame:Int = Math.floor(1 + (now - startTime) * framesPerMillisecond);

        if (targetFrame > previousFrame) {
            if (targetFrame > previousFrame + 5) {
                startTime += Math.ceil((targetFrame - previousFrame - 5) * framesPerMillisecond);
                targetFrame = previousFrame + 5;
            }

            var frame = previousFrame + 1;
            while (frame <= targetFrame) {
                update(frame);
                updateGraphic(frame);
                ++frame;
            }
            previousFrame = frame;

            render();
        }
    }

    function update(frame:Int):Void {
        if (playfield != previousPlayfield) {
            if (previousPlayfield != null) {
                previousPlayfield.end();
            }

            if (playfield != null) {
                playfield.begin(frame - 1);
            }

            previousPlayfield = playfield;
        }

        if ((previousConsoleActive && !consoleActive)
                || console != previousConsole) {
            if (previousConsole != null) {
                previousConsole.end();
            }

            if (consoleActive && console != null) {
                console.begin(frame);
            }

            previousConsole = console;
        }
        previousConsoleActive = consoleActive;

        for (input in inputs) {
            if (input != null) {
                input.update(frame);
            }
        }

        if (playfield != null && playfield.active) {
            playfield.update(frame);
        }

        if (consoleActive && console != null && console.enabled) {
            console.update(frame);
        }
    }

    function updateGraphic(frame:Int):Void {
        if (playfield != null && playfield.active) {
            playfield.updateGraphic(frame, screenSize);
        }
    }

    function render():Void {
        targetBitmapData.fillRect(targetBitmapData.rect, 0x000000);

        if (!consoleActive || console == null || !console.enabled) {
            if (playfield != null && playfield.visible) {
                playfield.render(targetBitmapData, Static.origin, Static.identity);
            }
        } else {
            console.render(targetBitmapData, playfield);
        }
    }
}