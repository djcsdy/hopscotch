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
		
		public function buttonForKey (charCode:int) :InputButton {
			var button:InputButton = keyButtons[charCode];
			if (!button) {
				button = new InputButton();
				keyButtons[charCode] = button;
			}
			return button;
		}
		
		public function axesForKeys (upCharCode:int, downCharCode:int,
				leftCharCode:int, rightCharCode:int) :InputButtonAxes {
			var axes:InputButtonAxes = new InputButtonAxes();
			axes.upButton = buttonForKey(upCharCode);
			axes.downButton = buttonForKey(downCharCode);
			axes.leftButton = buttonForKey(leftCharCode);
			axes.rightButton = buttonForKey(rightCharCode);
			return axes;
		}
		
		private function onKeyDown (event:KeyboardEvent) :void {
			var button:InputButton = keyButtons[event.charCode];
			if (button) {
				button.press();
			}
		}
		
		private function onKeyUp (event:KeyboardEvent) :void {
			var button:InputButton = keyButtons[event.charCode];
			if (button) {
				button.release();
			}
		}
		
	}
	
}