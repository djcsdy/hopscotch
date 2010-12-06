package net.noiseinstitute.hopscotch.engine {
	
	public class RenderInfo {
		
		internal var _tweenFactor :Number = 0;
		internal var _fractionalUpdateCount :Number = 0;
		internal var _updateCount :int = 0;
		internal var _skippedUpdates :int = 0;
		
		public function get tweenFactor () :Number {
			return _tweenFactor;
		}
		
		public function get fractionalUpdateCount () :Number {
			return _fractionalUpdateCount;
		}
		
		public function get updateCount () :int {
			return _updateCount;
		}
		
		public function get skippedUpdates () :int {
			return _skippedUpdates;
		}
		
	}
	
}
