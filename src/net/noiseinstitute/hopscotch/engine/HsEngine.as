package net.noiseinstitute.hopscotch.engine {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Timer;
	
	import net.noiseinstitute.hopscotch.render.IRenderManager;
	import net.noiseinstitute.hopscotch.render.displayObject.DisplayObjectRenderManager;
	import net.noiseinstitute.hopscotch.update.IUpdateManager;
	
	public class HsEngine {
		
		private var frameEventDispatcher :IEventDispatcher;
		private var timeSource :ITimeSource;
		private var startTime :Number = 0;
		private var stopTweenFactor :Number = 0;
		private var now :Number = 0;
		private var _updateIntervalMs :Number = 10;
		private var updateCount :int = 0;
		private var running :Boolean = false;
		private var updateManagers :Vector.<IUpdateManager> = new Vector.<IUpdateManager>();
		private var renderManagers :Vector.<IRenderManager> = new Vector.<IRenderManager>();
		
		public function HsEngine (
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
		
		public function addUpdateManager (updateManager:IUpdateManager) :void {
			updateManagers[updateManagers.length] = updateManager;
		}
		
		public function removeUpdateManager (updateManager:IUpdateManager) :void {
			updateManagers.splice(updateManagers.indexOf(updateManager), 1);
		}
		
		public function addRenderManager (renderManager:IRenderManager) :void {
			renderManagers[renderManagers.length] = renderManager;
		}
		
		public function removeRenderManager (renderManager:IRenderManager) :void {
			renderManagers.splice(renderManagers.indexOf(renderManager), 1);
		}
		
		private function onEnterFrame (event:Event) :void {
			var previousUpdateCount:int = updateCount;
			
			now = timeSource.getTime();
			var fractionalUpdateCount:Number = 1 + (now - startTime) / _updateIntervalMs;
			updateCount = Math.floor(fractionalUpdateCount);
			var tweenFactor:Number = fractionalUpdateCount - updateCount;
			
			for (var i:int=previousUpdateCount; i<updateCount; ++i) {
				for each (var updateManager:IUpdateManager in updateManagers) {
					updateManager.update();
				}
			}
			
			for each (var renderManager:IRenderManager in renderManagers) {
				renderManager.render(tweenFactor);
			}
		}
		
		public function get updateIntervalMs () :Number {
			return _updateIntervalMs;
		}
		
		public function set updateIntervalMs (updateIntervalMs:Number) :void {
			if (updateIntervalMs <= 0 || isNaN(updateIntervalMs)) {
				throw new ArgumentError("updateIntervalMs must be > 0");
			}
			
			var fractionalUpdateCount:Number = 1 + (now - startTime) / this._updateIntervalMs;
			var unservedFractionalUpdates:Number = fractionalUpdateCount - updateCount;
			
			updateCount = 0;
			startTime = now - unservedFractionalUpdates * updateIntervalMs;
			
			this._updateIntervalMs = updateIntervalMs;
		}
		
		public function get updatesPerSecond () :Number {
			return 1000/_updateIntervalMs;
		}
		
		public function set updatesPerSecond (updatesPerSecond:Number) :void {
			_updateIntervalMs = updatesPerSecond/1000;
		}
		
	}
	
}