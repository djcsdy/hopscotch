package net.noiseinstitute.hopscotch {
	import net.noiseinstitute.hopscotch.update.IUpdater;
	
	public class Entity implements IUpdater {
		
		private var _position :HsPoint = new HsPoint();
		private var _velocity :HsPoint = new HsPoint();
		private var _acceleration :HsPoint = new HsPoint();
		
		public function update () :void {
			_velocity.addInPlace(_acceleration);
			_position.addInPlace(_velocity);
		}
		
		public function get x () :Number {
			return _position.x;
		}
		
		public function set x (x:Number) :void {
			_position.x = x;
		}
		
		public function get y () :Number {
			return _position.y;
		}
		
		public function set (y:Number) :void {
			_position.y = y;
		}
		
	}
}