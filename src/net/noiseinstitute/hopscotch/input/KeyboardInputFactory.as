package net.noiseinstitute.hopscotch.input {
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
		
		public function axesForKeys (upKeyCode:uint, downKeyCode:uint,
				leftKeyCode:uint, rightKeyCode:uint) :InputButtonAxes {
			var axes:InputButtonAxes = new InputButtonAxes();
			axes.upButton = buttonForKey(upKeyCode);
			axes.downButton = buttonForKey(downKeyCode);
			axes.leftButton = buttonForKey(leftKeyCode);
			axes.rightButton = buttonForKey(rightKeyCode);
			return axes;
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