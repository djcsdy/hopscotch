package net.noiseinstitute.hopscotch.reuse {
	import net.noiseinstitute.hopscotch.events.HsEventDispatcher;
	
	public class ReusableImpl implements IReusable {
		
		private var _alive :Boolean = false;
		
		private var deadEventDispatcher :HsEventDispatcher =
				new HsEventDispatcher();
		
		
		public function init () :void {
			_alive = true;
		}
		
		public function kill () :void {
			if (_alive) {
				_alive = false;
				deadEventDispatcher.dispatchEvent();
			}
		}
		
		public function addDeadListener (listener:Function) :void {
			deadEventDispatcher.addEventListener(listener);
		}
		
		public function removeDeadListener (listener:Function) :void {
			deadEventDispatcher.removeEventListener(listener);
		}
		
		public function get alive () :Boolean {
			return _alive;
		}
		
	}
	
}
