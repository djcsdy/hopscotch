package net.noiseinstitute.hopscotch.input.digital {
	import net.noiseinstitute.hopscotch.update.ActionQueue;
	import net.noiseinstitute.hopscotch.input.analogue.Throttle;

	public class ButtonThrottle extends Throttle {
		
		public var ease :Number = 0.2;
		
		private var button :InputButton;
		
		public function ButtonThrottle (button:InputButton=null) {
			this.button = button;
		}
		
		override public function update (deferredActions:ActionQueue) :void {
			super.update(deferredActions);
			button.update(deferredActions);
			
			var target:Number;
			if (button.pressed) {
				target = 1;
			} else {
				target = 0;
			}
			
			_position += (target-_position)*ease;
		}
		
	}
	
}