package net.noiseinstitute.hopscotch.engine {
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	import net.noiseinstitute.hopscotch.engine.World;

	public class Engine {
		
		private var frameEventDispatcher :IEventDispatcher;
		private var timeSource :ITimeSource;
		private var startTime :Number = 0;
		private var stopTweenFactor :Number = 0;
		private var now :Number = 0;
		private var _updateIntervalMs :Number = 10;
		private var updateCount :int = 0;
		private var running :Boolean = false;
		private var deferredActions :ActionQueue = new ActionQueue();

		public var world :World = new World();
		
		public function Engine (
				frameEventDispatcher:IEventDispatcher,
				timeSource:ITimeSource=null) {
			if (!frameEventDispatcher) {
				throw new TypeError("frameEventDispatcher must be non-null");
			}
			if (!timeSource) {
				timeSource = new TimeSource();
			}
			this.frameEventDispatcher = frameEventDispatcher;
			this.timeSource = timeSource;
		}
		
		public function start () :void {
			if (!running) {
				running = true;
				startTime = now = timeSource.getTime() - stopTweenFactor*_updateIntervalMs;
				frameEventDispatcher.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		public function stop () :void {
			if (running) {
				running = false;
				var fractionalUpdateCount:Number = 1 + (now - startTime) / _updateIntervalMs;
				stopTweenFactor = fractionalUpdateCount - updateCount;
				frameEventDispatcher.removeEventListener(Event.ENTER_FRAME, onEnterFrame); 
			}
		}
		
		private function onEnterFrame (event:Event) :void {
			var previousUpdateCount:int = updateCount;

			now = timeSource.getTime();
			var fractionalUpdateCount:Number = 1 + (now - startTime) / _updateIntervalMs;
			updateCount = Math.floor(fractionalUpdateCount);
			var tweenFactor:Number = fractionalUpdateCount - updateCount;

			for (var i:int=previousUpdateCount; i<updateCount; ++i) {
				world.update(deferredActions);
				deferredActions.execute();
			}

			world.render(tweenFactor);
		}
		
		public function get updateIntervalMs () :Number {
			return _updateIntervalMs;
		}
		
		public function set updateIntervalMs (updateIntervalMs:Number) :void {
			if (updateIntervalMs <= 0 || isNaN(updateIntervalMs)) {
				throw new ArgumentError("updateIntervalMs must be > 0");
			}
			
			var fractionalUpdateCount:Number = 1 + (now - startTime) / _updateIntervalMs;
			var unservedFractionalUpdates:Number = fractionalUpdateCount - updateCount;
			
			updateCount = 1;
			startTime = now - unservedFractionalUpdates * _updateIntervalMs;
			
			_updateIntervalMs = updateIntervalMs;
		}
		
		public function get updatesPerSecond () :Number {
			return 1000/_updateIntervalMs;
		}
		
		public function set updatesPerSecond (updatesPerSecond:Number) :void {
			_updateIntervalMs = 1000/updatesPerSecond;
		}
		
	}
	
}