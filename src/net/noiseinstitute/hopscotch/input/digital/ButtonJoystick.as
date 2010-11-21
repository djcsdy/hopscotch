package net.noiseinstitute.hopscotch.input.digital {
	import net.noiseinstitute.hopscotch.geom.HsPoint;
	import net.noiseinstitute.hopscotch.input.analogue.Joystick;

	public class ButtonJoystick extends Joystick {
		
		public var circular :Boolean = true;
		public var ease :Number = 0.2;
		
		private var upButton :InputButton;
		private var downButton :InputButton;
		private var leftButton :InputButton;
		private var rightButton :InputButton;
		
		private var target :HsPoint = new HsPoint();
		
		public function ButtonJoystick (
				upButton:InputButton, downButton:InputButton,
				leftButton:InputButton, rightButton:InputButton) {
			this.upButton = upButton;
			this.downButton = downButton;
			this.leftButton = leftButton;
			this.rightButton = rightButton;
		}
		
		override public function update () :void {
			super.update();
			upButton.update();
			downButton.update();
			leftButton.update();
			rightButton.update();
			
			target.x = 0;
			target.y = 0;
			if (upButton.pressed) {
				target.y = -1;
			}
			if (downButton.pressed) {
				target.y += 1;
			}
			if (leftButton.pressed) {
				target.x = -1;
			}
			if (rightButton.pressed) {
				target.x += 1;
			}
			
			if (circular) {
				target.normalize();
			}
			
			_position.x += (target.x-_position.x)*ease;
			_position.y += (target.y-_position.y)*ease;
		}
		
	}
	
}