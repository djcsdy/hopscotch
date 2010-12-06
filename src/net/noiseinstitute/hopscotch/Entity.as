package net.noiseinstitute.hopscotch {
	import net.noiseinstitute.hopscotch.geom.HsPoint;

	public class Entity implements IUpdater {

		public var position :HsPoint = new HsPoint();
		public var velocity :HsPoint = new HsPoint();
		public var acceleration :HsPoint = new HsPoint();
		public var angle :Number = 0;
		public var angularVelocity :Number = 0;
		public var angularAcceleration :Number = 0;

		public function update () :void {
			velocity.addInPlace(acceleration);
			position.addInPlace(velocity);
			angularVelocity += angularAcceleration;
			angle += angularVelocity;
		}

	}

}
