package net.noiseinstitute.hopscotch.input.digital {
	import net.noiseinstitute.hopscotch.update.ActionQueue;
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
		
		override public function update (deferredActions:ActionQueue) :void {
			super.update(deferredActions);
			leftButton.update(deferredActions);
			rightButton.update(deferredActions);
			
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