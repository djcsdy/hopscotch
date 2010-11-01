package net.noiseinstitute.hopscotch.input {
	import net.noiseinstitute.hopscotch.geom.HsPoint;
	
	public class InputButtonAxes implements IInputAxes {
		
		public var upButton :InputButton;
		public var downButton :InputButton;
		public var leftButton :InputButton;
		public var rightButton :InputButton;
		
		public var circular :Boolean = true;
		public var ease :Number = 0.2;
		
		private var target :HsPoint = new HsPoint();
		private var _position :HsPoint = new HsPoint();
		
		public function update () :void {
			upButton.update();
			downButton.update();
			leftButton.update();
			rightButton.update();
			
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
			
			position.x += (target.x - position.x) * ease;
			position.y += (target.y - position.y) * ease;
		}
		
		public function get position () :HsPoint {
			return position;
		}
		
	}
	
}