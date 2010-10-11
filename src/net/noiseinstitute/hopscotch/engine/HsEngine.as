package net.noiseinstitute.hopscotch.engine {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Timer;
	
	public class HsEngine {
		
		private var frameEventDispatcher :IEventDispatcher;
		private var timeSource :ITimeSource;
		private var startTime :Number = 0;
		private var stopTweenFactor :Number = 0;
		private var now :Number = 0;
		private var updateIntervalMs :Number = 10;
		private var updateCount :int = 0;
		private var running :Boolean = false;
		
		public function HsEngine (
				frameEventDispatcher:IEventDispatcher,
				timeSource:ITimeSource=new TimeSource()) {
			if (!frameEventDispatcher) {
				throw new TypeError("frameEventDispatcher must be non-null");
			}
			this.frameEventDispatcher = frameEventDispatcher;
			this.timeSource = timeSource;
		}
		
		public function start () :void {
			if (!running) {
				running = true;
				startTime = now = timeSource.getTime() - stopTweenFactor*updateIntervalMs;
				frameEventDispatcher.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		public function stop () :void {
			if (running) {
				running = false;
				var fractionalUpdateCount:Number = (now - startTime) / updateIntervalMs;
				stopTweenFactor = fractionalUpdateCount - updateCount;
				frameEventDispatcher.removeEventListener(Event.ENTER_FRAME, onEnterFrame); 
			}
		}
		
		private function onEnterFrame () :void {
			var previousUpdateCount:int = updateCount;
			
			now = timeSource.getTime();
			var fractionalUpdateCount:Number = (now - startTime) / updateIntervalMs;
			updateCount = Math.floor(fractionalUpdateCount);
			var tweenFactor:Number = fractionalUpdateCount - updateCount;
			
			for (var i:int=previousUpdateCount; i<updateCount; ++i) {
				for each (var entity:Entity in entities) {
					entity.update();
				}
			}
			
			for each (var entity:Entity in entities) {
				entity.render(tweenFactor);
			}
		}
		
		public function get updateIntervalMs () :Number {
			return updateIntervalMs;
		}
		
		public function set updateIntervalMs (updateIntervalMs:Number) :void {
			if (updateIntervalMs <= 0 || isNaN(updateIntervalMs)) {
				throw new ArgumentError("updateIntervalMs must be > 0");
			}
			
			var fractionalUpdateCount:Number = (now - startTime) / this.updateIntervalMs;
			var unservedFractionalUpdates:Number = fractionalUpdateCount - updateCount;
			
			updateCount = 0;
			startTime = now - unservedFractionalUpdates * updateIntervalMs;
			
			this.updateIntervalMs = updateIntervalMs;
		}
		
		public function get updatesPerSecond () :Number {
			return 1000/updateIntervalMs;
		}
		
		public function set updatesPerSecond (updatesPerSecond:Number) :void {
			updateIntervalMs = updatesPerSecond/1000;
		}
		
	}
	
}