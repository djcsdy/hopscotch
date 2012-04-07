package hopscotch.engine;

import hopscotch.debug.IConsole;
import hopscotch.errors.ArgumentNullError;
import hopscotch.input.IInput;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.IEventDispatcher;
import hopscotch.errors.ArgumentError;
import hopscotch.Playfield;

class Engine {
    public var playfield:Playfield;
    public var inputs(default, null):Array<IInput>;
    public var console:IConsole;

    var screenSize:ScreenSize;
    var renderTarget:DisplayObjectContainer;
    var targetBitmap:Bitmap;
    var targetBitmapData:BitmapData;
    var timeSource:ITimeSource;
    var framesPerMillisecond:Float;
    var running:Bool;
    var startTime:Int;
    var consoleActive:Bool;

    var previousPlayfield:Playfield;
    var previousFrame:Int;
    var previousConsoleActive:Bool;
    var previousConsole:IConsole;

    public function new (renderTarget:DisplayObjectContainer,
            width:Int, height:Int, framesPerSecond:Float,
            timeSource:ITimeSource = null) {

        if (renderTarget == null) {
            throw new ArgumentNullError("renderTarget");
        }

        if (width <= 0) {
            throw new ArgumentError("width out of range");
        }

        if (height < 0) {
            throw new ArgumentError("height out of range");
        }

        this.renderTarget = renderTarget;
        this.screenSize = new ScreenSize(width, height);

        inputs = [];

        setFramesPerSecond(framesPerSecond);

        if (timeSource == null) {
            this.timeSource = new TimeSource();
        } else {
            this.timeSource = timeSource;
        }

        running = false;

        consoleActive = false;
        previousConsoleActive = false;
        previousConsole = null;
    }

    public function setFramesPerSecond (framesPerSecond:Float):Void {
        if (framesPerSecond <= 0) {
            throw new ArgumentError("framesPerSecond out of range");
        }

        framesPerMillisecond = framesPerSecond / 1000;
    }

    public function start ():Void {
        if (!running) {
            running = true;
            startTime = Math.floor(timeSource.getTime() -
                    (previousFrame - 1) / framesPerMillisecond);

            targetBitmapData = new BitmapData(screenSize.width, screenSize.height,
                    false, 0x000000);
            targetBitmap = new Bitmap(targetBitmapData);
            renderTarget.addChild(targetBitmap);

            renderTarget.addEventListener(
                Event.ENTER_FRAME, onEnterFrame);
        }
    }

    public function stop ():Void {
        if (running) {
            running = false;

            renderTarget.removeChild(targetBitmap);
            targetBitmap = null;
            targetBitmapData.dispose();
            targetBitmapData = null;

            renderTarget.removeEventListener(
                Event.ENTER_FRAME, onEnterFrame);
        }
    }

    function onEnterFrame (event:Event):Void {
        if (!running) {
            return;
        }

        var now = timeSource.getTime();
        var targetFrame:Int = Math.floor(1 + (now - startTime) * framesPerMillisecond);

        if (targetFrame > previousFrame) {
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

    function update (frame:Int):Void {
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

    function updateGraphic (frame:Int):Void {
        if (playfield != null && playfield.active) {
            playfield.updateGraphic(frame, screenSize);
        }
    }

    function render ():Void {
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