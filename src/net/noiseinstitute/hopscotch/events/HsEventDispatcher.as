package net.noiseinstitute.hopscotch.events {
	
	public class HsEventDispatcher {
		
		private var listeners :Vector.<Function>;
		
		public function HsEventDispatcher() {
			listeners = new Vector.<Function>();
		}
		
		public function addEventListener (listener:Function) :void {
			listeners[listeners.length] = listener;
		}
		
		public function removeEventListener (listener:Function) :void {
			listeners.splice(listeners.indexOf(listener), 1);
		}
		
		public function dispatchEvent (target:Object=null, ...args) :void {
			for each (var listener:Function in listeners) {
				listener.apply(target, args);
			}
		}
		
	}
}