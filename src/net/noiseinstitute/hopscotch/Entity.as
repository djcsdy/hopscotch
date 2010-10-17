package net.noiseinstitute.hopscotch {
	import net.noiseinstitute.hopscotch.update.IUpdater;
	
	public class Entity implements IUpdater {
		
		public var position :HsPoint = new HsPoint();
		public var velocity :HsPoint = new HsPoint();
		public var acceleration :HsPoint = new HsPoint();
		public var rotation :Number = 0;
		public var rotationSpeed :Number = 0;
		public var rotationAcceleration :Number = 0;
		
		public function update () :void {
			velocity.addInPlace(_acceleration);
			position.addInPlace(_velocity);
			rotationSpeed += rotationAcceleration;
			rotation += rotationSpeed;
		}
		
		public function get x () :Number {
			return position.x;
		}
		
		public function set x (x:Number) :void {
			position.x = x;
		}
		
		public function get y () :Number {
			return position.y;
		}
		
		public function set (y:Number) :void {
			position.y = y;
		}
		
	}
}