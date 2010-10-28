package net.noiseinstitute.hopscotch.reuse {
	import net.noiseinstitute.hopscotch.events.HsEventDispatcher;
	
	public class ReusableImpl implements IReusable {
		
		private var _alive :Boolean = false;
		
		private var aliveEventDispatcher :HsEventDispatcher =
				new HsEventDispatcher();
		private var deadEventDispatcher :HsEventDispatcher =
				new HsEventDispatcher();
		
		
		public function ReusableMixin () {
			this.consumer = consumer;
		}
		
		public dynamic function init () :void {
			alive = true;
		}
		
		public function get alive () :Boolean {
			return _alive;
		}
		
		public function set alive (alive:Boolean) :void {
			var wasAlive:Boolean = _alive;
			_alive = alive;
			if (alive != wasAlive) {
				if (alive) {
					aliveEventDispatcher.dispatchEvent();
				} else {
					deadEventDispatcher.dispatchEvent();
				}
			}
		}
		
		public function addAliveListener (listener:Function) :void {
			aliveEventDispatcher.addEventListener(listener);
		}
		
		public function removeAliveListener (listener:Function) :void {
			aliveEventDispatcher.removeEventListener(listener);
		}
		
		public function addDeadListener (listener:Function) :void {
			deadEventDispatcher.addEventListener(listener);
		}
		
		public function removeDeadListener (listener:Function) :void {
			deadEventDispatcher.removeEventListener(listener);
		}
		
	}
	
}
