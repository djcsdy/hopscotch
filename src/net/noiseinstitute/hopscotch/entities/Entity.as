package net.noiseinstitute.hopscotch.entities {
	import net.noiseinstitute.hopscotch.geom.HsPoint;
	import net.noiseinstitute.hopscotch.render.EntityRenderer;
	import net.noiseinstitute.hopscotch.reuse.IReusable;
	import net.noiseinstitute.hopscotch.reuse.ReusableImpl;

	public class Entity implements IReusable {
		
		public var position :HsPoint = new HsPoint();
		public var velocity :HsPoint = new HsPoint();
		public var acceleration :HsPoint = new HsPoint();
		public var rotation :Number = 0;
		public var rotationSpeed :Number = 0;
		public var rotationAcceleration :Number = 0;
		
		public var renderer :EntityRenderer;
		
		private var reusableImpl :ReusableImpl = new ReusableImpl();
		
		public function init () :void {
			reusableImpl.init();
			position.x = 0;
			position.y = 0;
			velocity.x = 0;
			velocity.y = 0;
			acceleration.x = 0;
			acceleration.y = 0;
			rotation = 0;
			rotationSpeed = 0;
			rotationAcceleration = 0;
		}
		
		public function kill () :void {
			reusableImpl.kill();
		}
		
		public function update () :void {
			if (!alive) {
				return;
			}
			
			velocity.addInPlace(acceleration);
			position.addInPlace(velocity);
			rotationSpeed += rotationAcceleration;
			rotation += rotationSpeed;
		}
		
		public function render (tweenFactor:Number) :void {
			if (!renderer) {
				return;
			}
			if (alive) {
				renderer.render(this);
			} else {
				renderer.hide();
			}
		}
		
		public function addDeadListener (listener:Function) :void {
			reusableImpl.addDeadListener(listener);
		}
		
		public function removeDeadListener (listener:Function) :void {
			reusableImpl.removeDeadListener(listener);
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
		
		public function get alive () :Boolean {
			return reusableImpl.alive;
		}
		
	}
}