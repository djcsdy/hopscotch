package net.noiseinstitute.hopscotch {
	import net.noiseinstitute.hopscotch.geom.HsPoint;

	public class EntityTween {

		public var position :HsPoint = new HsPoint();
		public var angle :Number = 0;

		public function get x () :Number {
			return position.x;
		}

		public function set x (x:Number) :void {
			position.x = x;
		}

		public function get y () :Number {
			return position.y;
		}

		public function set y (y:Number) :void {
			position.y = y;
		}

	}

}
