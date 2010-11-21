package net.noiseinstitute.hopscotch.input.digital {
	import net.noiseinstitute.hopscotch.engine.ActionQueue;
	import net.noiseinstitute.hopscotch.input.analogue.Wheel;
	
	public class ButtonWheel extends Wheel {
		
		public var ease :Number = 0.2;
		
		private var leftButton :InputButton;
		private var rightButton :InputButton;
		
		public function ButtonWheel (
				leftButton:InputButton, rightButton:InputButton) {
			this.leftButton = leftButton;
			this.rightButton = rightButton;
		}
		
		override public function update () :void {
			super.update();
			leftButton.update();
			rightButton.update();
			
			var target:Number = 0;
			if (leftButton.pressed) {
				target = -1;
			}
			if (rightButton.pressed) {
				target += 1;
			}
			
			_position += (target-_position)*ease;
		}
		
	}
}