package net.noiseinstitute.hopscotch.input {
	import net.noiseinstitute.hopscotch.geom.HsPoint;
	import net.noiseinstitute.hopscotch.update.ActionQueue;
	
	public class InputButtonAxes implements IInputAxes {
		
		public var upButton :InputButton;
		public var downButton :InputButton;
		public var leftButton :InputButton;
		public var rightButton :InputButton;
		
		public var circular :Boolean = true;
		public var ease :Number = 0.2;
		
		private var target :HsPoint = new HsPoint();
		private var _position :HsPoint = new HsPoint();
		
		public function update (deferredActions:ActionQueue) :void {
			upButton.update(deferredActions);
			downButton.update(deferredActions);
			leftButton.update(deferredActions);
			rightButton.update(deferredActions);
			
			if (upButton.pressed) {
				target.y = -1;
			} else {
				target.y = 0;
			}
			if (downButton.pressed) {
				target.y += 1;
			}
			
			if (leftButton.pressed) {
				target.x = -1;
			} else {
				target.x = 0;
			}
			if (rightButton.pressed) {
				target.x += 1;
			}
			
			if (circular) {
				target.normalizeInPlace();
			}
			
			_position.x += (target.x - _position.x) * ease;
			_position.y += (target.y - _position.y) * ease;
		}
		
		public function get position () :HsPoint {
			return position;
		}
		
	}
	
}