package net.noiseinstitute.hopscotch.input.analogue {
	import net.noiseinstitute.hopscotch.engine.ActionQueue;
	
	/** A one-dimensional analogue controller that gives a signal in the
	 * range 0..1. **/
	public class Throttle {
		
		protected var _position :Number = 0;
		
		public function update (deferredActions:ActionQueue) :void {
		}
				
		public function get position () :Number {
			return _position;
		}
		
	}
	
}