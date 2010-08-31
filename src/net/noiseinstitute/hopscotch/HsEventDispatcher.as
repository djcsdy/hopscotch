package net.noiseinstitute.hopscotch {
	
	public class HsEventDispatcher {
		
		private var listeners :Vector.<Function>;
		
		public function HsEventDispatcher() {
			listeners = new Vector.<Function>();
		}
		
		public function addEventListener (listener:Function) :void {
			listeners.push(listener);
		}
		
		public function removeEventListener (listener:Function) :void {
			listeners.splice(listeners.indexOf(listener), 1);
		}
		
		public function dispatchEvent (event:HsEvent) :void {
			for each (var listener:Function in listeners) {
				listener(event);
			}
		}
		
	}
}