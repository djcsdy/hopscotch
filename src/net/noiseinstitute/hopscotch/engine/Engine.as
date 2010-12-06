package net.noiseinstitute.hopscotch.engine {
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class Engine {

		private var frameEventDispatcher :IEventDispatcher;
		private var timeSource :ITimeSource;
		private var startTime :Number = 0;
		private var stopTweenFactor :Number = 0;
		private var now :Number = 0;
		private var _updateIntervalMs :Number = 10;
		private var _updateCount :int = 0;
		private var _fractionalUpdateCount :Number = 0;
		private var running :Boolean = false;

		public function Engine (
				frameEventDispatcher:IEventDispatcher,
				timeSource:ITimeSource=null) {
			if (!frameEventDispatcher) {
				throw new TypeError("displayObject must be non-null");
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
				stopTweenFactor = fractionalUpdateCount - _updateCount;
				frameEventDispatcher.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}

		private function onEnterFrame (event:Event) :void {
			now = timeSource.getTime();
			_fractionalUpdateCount = 1 + (now - startTime) / _updateIntervalMs;
			_updateCount = Math.floor(_fractionalUpdateCount);
		}

		public function get updateCount () :int {
			return _updateCount;
		}

		public function get tweenFactor () :Number {
			return _fractionalUpdateCount - _updateCount;
		}
		
		public function get fractionalUpdateCount () :Number {
			return _fractionalUpdateCount;
		}

		public function get updateIntervalMs () :Number {
			return _updateIntervalMs;
		}

		public function set updateIntervalMs (updateIntervalMs:Number) :void {
			if (updateIntervalMs <= 0 || isNaN(updateIntervalMs)) {
				throw new ArgumentError("updateIntervalMs must be > 0");
			}

			var fractionalUpdateCount:Number = 1 + (now - startTime) / _updateIntervalMs;
			var unservedFractionalUpdates:Number = fractionalUpdateCount - _updateCount;

			_updateCount = 1;
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