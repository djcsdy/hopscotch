package hopscotch.engine;
import flash.events.Event;
import flash.events.IEventDispatcher;
import hopscotch.errors.ArgumentError;
import hopscotch.Playfield;

class Engine {
	public var playfield:Playfield;
	
	var frameEventDispatcher:IEventDispatcher;
	var timeSource:ITimeSource;
	var previousPlayfield:Playfield;
	
	var running:Bool;
	var framesPerMillisecond:Float;
	var startTime:Int;
	var previousFrame:Int;
	
	public function new(frameEventDispatcher:IEventDispatcher,
			timeSource:ITimeSource = null) {
		
		if (frameEventDispatcher == null) {
			throw new ArgumentError("frameEventDispatcher is null");
		}
		
		this.frameEventDispatcher = frameEventDispatcher;
		
		if (timeSource == null) {
			this.timeSource = new TimeSource();
		} else {
			this.timeSource = timeSource;
		}
		
		running = false;
		framesPerMillisecond = 60 / 1000;
	}
	
	public function setFramesPerSecond(framesPerSecond:Float):Void {
		framesPerMillisecond = framesPerSecond / 1000;
	}
	
	public function start():Void {
		if (!running) {
			running = true;
			startTime = Math.floor(timeSource.getTime() -
					(previousFrame - 1) / framesPerMillisecond);
			frameEventDispatcher.addEventListener(
					Event.ENTER_FRAME, onEnterFrame);
		}
	}
	
	public function stop():Void {
		if (running) {
			running = false;
			frameEventDispatcher.removeEventListener(
					Event.ENTER_FRAME, onEnterFrame);
		}
	}
	
	function onEnterFrame(event:Event):Void {
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
			
			render();
		}
	}
	
	function update(frame:Int):Void {
		if (playfield == null) {
			return;
		}
		
		if (playfield != previousPlayfield) {
			if (previousPlayfield != null) {
				previousPlayfield.end();
			}
			
			playfield.begin(frame-1);
			
			previousPlayfield = playfield;
		}
		
		playfield.update(frame);
	}
	
	function updateGraphic(frame:Int):Void {
		if (playfield != null) {
			playfield.updateGraphic(frame);
		}
	}
	
	function render():Void {
		// TODO
	}
}