package net.noiseinstitute.hopscotch.input {
	import net.noiseinstitute.hopscotch.update.IUpdater;
	
	public class InputButton implements IUpdater {
		
		private var _pressed :Boolean = false;
		private var _justPressed :Boolean = false;
		private var _justReleased :Boolean = false;
		private var _pressedTicks :uint = 0;
		private var _releasedTicks :uint = 0;
		
		public function press () :void {
			_pressed = true;
		}
		
		public function release () :void {
			_pressed = false;
		}
		
		public function update () :void {
			if (_pressed) {
				_justPressed = (_pressedTicks == 0);
				_releasedTicks = 0;
				_justReleased = false;
				_pressedTicks++;
			} else {
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