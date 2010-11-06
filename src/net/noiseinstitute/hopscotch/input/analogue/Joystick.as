package net.noiseinstitute.hopscotch.input.analogue {
	import net.noiseinstitute.hopscotch.engine.ActionQueue;
	import net.noiseinstitute.hopscotch.geom.HsPoint;
	
	/** A two-dimensional analogue input that gives a position in the range
	 * (-1,-1)..(1,1). */
	public class Joystick {
		
		protected var _position :HsPoint = new HsPoint();
		
		public function update (deferredActions:ActionQueue) :void {
		}
		
		public function get position () :HsPoint {
			return _position;
		}
		
		public function get x () :Number {
			return _position.x;
		}
		
		public function get y () :Number {
			return _position.y;
		}
		
	}
}