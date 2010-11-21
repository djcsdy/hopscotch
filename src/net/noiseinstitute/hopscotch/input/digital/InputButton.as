package net.noiseinstitute.hopscotch.input.digital {
	import net.noiseinstitute.hopscotch.input.IInput;

	public class InputButton implements IInput {
		
		private var pressQueued :Boolean = false;
		private var _pressed :Boolean = false;
		private var _justPressed :Boolean = false;
		private var _justReleased :Boolean = false;
		private var _pressedTicks :uint = 0;
		private var _releasedTicks :uint = 1;
		
		public function press () :void {
			pressQueued = true;
		}
		
		public function release () :void {
			pressQueued = false;
		}
		
		public function update () :void {
			if (pressQueued) {
				_pressed = true;
				_justPressed = (_pressedTicks == 0);
				_releasedTicks = 0;
				_justReleased = false;
				_pressedTicks++;
			} else {
				_pressed = false;
				_justReleased = (_releasedTicks == 0);
				_pressedTicks = 0;
				_justPressed = false;
				_releasedTicks++;
			}
		}
		
		public function get pressed () :Boolean {
			return _pressed;
		}
		
		public function get justPressed () :Boolean {
			return _justPressed;
		}
		
		public function get justReleased () :Boolean {
			return _justReleased;
		}
		
		public function get pressedTicks () :uint {
			return _pressedTicks;
		}
		
		public function get releasedTicks () :uint {
			return _releasedTicks;
		}
		
	}
}