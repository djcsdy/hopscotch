package net.noiseinstitute.hopscotch {
	import net.noiseinstitute.hopscotch.update.IUpdater;
	import net.noiseinstitute.hopscotch.update.ActionQueue;
	import net.noiseinstitute.hopscotch.geom.HsPoint;
	
	public class Entity implements IUpdater {
		
		public var position :HsPoint = new HsPoint();
		public var velocity :HsPoint = new HsPoint();
		public var acceleration :HsPoint = new HsPoint();
		public var rotation :Number = 0;
		public var rotationSpeed :Number = 0;
		public var rotationAcceleration :Number = 0;
		
		private var savedVelocity :HsPoint = new HsPoint();
		private var savedAcceleration :HsPoint = new HsPoint();
		private var savedRotationSpeed :Number = 0;
		private var savedRotationAcceleration :Number = 0;
		
		public function update (deferredActions:ActionQueue) :void {
			savedVelocity.copyFrom(velocity);
			savedAcceleration.copyFrom(acceleration);
			savedRotationSpeed = rotationSpeed;
			savedRotationAcceleration = rotationAcceleration;
			
			deferredActions.enqueue(function () :void {
				velocity.addInPlace(savedAcceleration);
				savedVelocity.addInPlace(savedAcceleration);
				position.addInPlace(savedVelocity);
				rotationSpeed += savedRotationAcceleration;
				savedRotationSpeed += savedRotationAcceleration;
				rotation += savedRotationSpeed;
			});
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
		
		public function set y (y:Number) :void {
			position.y = y;
		}
		
	}
}