package net.noiseinstitute.hopscotch {
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class HsEngine {
		
		private var root :DisplayObject;
		private var startTime :Number = 0;
		private var now :Number = 0;
		private var updateIntervalMs :Number = 10;
		private var updateCount :int = 0;
		private var running :Boolean = false;
		
		public function HsEngine (root:DisplayObject) {
			if (!root) {
				throw new TypeError("root must be non-null");
			}
			this.root = root;
		}
		
		public function start () :void {
			if (!running) {
				running = true;
				startTime = now = new Date().time;
				root.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		private function onEnterFrame () :void {
			var previousUpdateCount:int = updateCount;
			
			now = new Date().time;
			var fractionalUpdateCount:Number = (now - startTime) / updateIntervalMs;
			updateCount = Math.floor(fractionalUpdateCount);
			var mu:Number = fractionalUpdateCount - updateCount;
			
			for (var i:int=previousUpdateCount; i<updateCount; ++i) {
				for each (entity:Entity in entities) {
					entity.update();
				}
			}
			
			for each (entity:Entity in entities) {
				entity.render(mu);
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