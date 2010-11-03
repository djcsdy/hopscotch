package net.noiseinstitute.hopscotch.input.digital {
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	public class KeyboardInputFactory {
		
		private var keyboardEventDispatcher :IEventDispatcher;
		private var keyButtons :Dictionary = new Dictionary();
		
		public function KeyboardInputFactory (keyboardEventDispatcher:IEventDispatcher=null) {
			bind(keyboardEventDispatcher);
		}
		
		public function bind (keyboardEventDispatcher:IEventDispatcher) :void {
			this.keyboardEventDispatcher = keyboardEventDispatcher;
			keyboardEventDispatcher.addEventListener(
					KeyboardEvent.KEY_DOWN, onKeyDown);
			keyboardEventDispatcher.addEventListener(
					KeyboardEvent.KEY_UP, onKeyUp);
			keyButtons = new Dictionary();
		}
		
		public function unbind () :void {
			this.keyboardEventDispatcher = null;
			keyboardEventDispatcher.removeEventListener(
					KeyboardEvent.KEY_DOWN, onKeyDown);
			keyboardEventDispatcher.removeEventListener(
					KeyboardEvent.KEY_UP, onKeyUp);
			keyButtons = new Dictionary();
		}
		
		public function buttonForKey (keyCode:uint) :InputButton {
			var button:InputButton = keyButtons[keyCode];
			if (!button) {
				button = new InputButton();
				keyButtons[keyCode] = button;
			}
			return button;
		}
		
		public function throttleForKey (keyCode:uint) :ButtonThrottle {
			var button:InputButton = buttonForKey(keyCode);
			return new ButtonThrottle(button);
		}
		
		public function wheelForKeys (leftKeyCode:uint, rightKeyCode:uint) :ButtonWheel {
			var leftButton:InputButton = buttonForKey(leftKeyCode);
			var rightButton:InputButton = buttonForKey(rightKeyCode);
			return new ButtonWheel(leftButton, rightButton);
		}
		
		public function joystickForKeys (upKeyCode:uint, downKeyCode:uint,
				leftKeyCode:uint, rightKeyCode:uint) :ButtonJoystick {
			var upButton:InputButton = buttonForKey(upKeyCode);
			var downButton:InputButton = buttonForKey(downKeyCode);
			var leftButton:InputButton = buttonForKey(leftKeyCode);
			var rightButton:InputButton = buttonForKey(rightKeyCode);
			return new ButtonJoystick(upButton, downButton, leftButton, rightButton);
		}
		
		private function onKeyDown (event:KeyboardEvent) :void {
			var button:InputButton = keyButtons[event.keyCode];
			if (button) {
				button.press();
			}
		}
		
		private function onKeyUp (event:KeyboardEvent) :void {
			var button:InputButton = keyButtons[event.keyCode];
			if (button) {
				button.release();
			}
		}
		
	}
	
}