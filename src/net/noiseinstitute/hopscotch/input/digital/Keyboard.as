package net.noiseinstitute.hopscotch.input.digital {
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;
	
	public class Keyboard {

		/** Key code for the A key. */
		public static const A :uint = 65;

		/** Key code for the Alternate/Alt/Option key. */
		public static const ALTERNATE :uint = 18;

		/** Key code for the B key. */
		public static const B :uint = 66;

		/** Key code for the backquote (`) key. */
		public static const BACKQUOTE :uint = 192;

		/** Key code for the backslash (\) key. */
		public static const BACKSLASH :uint = 220;

		/** Key code for the backspace key. */
		public static const BACKSPACE :uint = 8;

		/** Key code for the C key. */
		public static const C :uint = 67;

		/** Key code for the caps lock key. */
		public static const CAPS_LOCK :uint = 20;

		/** Key code for the comma (,) key. */
		public static const COMMA :uint = 118;

		/** Key code for the Macintosh command key. */
		public static const COMMAND :uint = 15;

		/** Key code for the control/ctrl key. */
		public static const CONTROL :uint = 17;

		/** Key code for the D key. */
		public static const D :uint = 68;

		/** Key code for the delete key. */
		public static const DELETE :uint = 46;

		/** Key code for the down arrow key. */
		public static const DOWN :uint = 40;

		/** Key code for the E key. */
		public static const E :uint = 69;

		/** Key code for the end key. */
		public static const END :uint = 35;

		/** Key code for the enter key. */
		public static const ENTER :uint = 13;

		/** Key code for the equal (=) key. */
		public static const EQUAL :uint = 187;

		/** Key code for the escape/esc key. */
		public static const ESCAPE :uint = 27;

		/** Key code for the F key. */
		public static const F :uint = 70;

		/** Key code for the F1 key. */
		public static const F1 :uint = 112;

		/** Key code for the F10 key. */
		public static const F10 :uint = 121;

		/** Key code for the F11 key. */
		public static const F11 :uint = 122;

		/** Key code for the F12 key. */
		public static const F12 :uint = 123;

		/** Key code for the F13 key. */
		public static const F13 :uint = 124;

		/** Key code for the F14 key. */
		public static const F14 :uint = 125;

		/** Key code for the F15 key. */
		public static const F15 :uint = 126;

		/** Key code for the F2 key. */
		public static const F2 :uint = 113;

		/** Key code for the F3 key. */
		public static const F3 :uint = 114;

		/** Key code for the F4 key. */
		public static const F4 :uint = 115;

		/** Key code for the F5 key. */
		public static const F5 :uint = 116;

		/** Key code for the F6 key. */
		public static const F6 :uint = 117;

		/** Key code for the F7 key. */
		public static const F7 :uint = 118;

		/** Key code for the F8 key. */
		public static const F8 :uint = 119;

		/** Key code for the F9 key. */
		public static const F9 :uint = 120;

		/** Key code for the G key. */
		public static const G :uint = 71;

		/** Key code for the H key. */
		public static const H :uint = 72;

		/** Key code for the home key. */
		public static const HOME :uint = 36;

		/** Key code for the I key. */
		public static const I :uint = 73;

		/** Key code for the insert key. */
		public static const INSERT :uint = 45;

		/** Key code for the J key. */
		public static const J :uint = 74;

		/** Key code for the K key. */
		public static const K :uint = 75;

		/** Key code for the L key. */
		public static const L :uint = 76;

		/** Key code for the left arrow key. */
		public static const LEFT :uint = 37;

		/** Key code for the left bracket ([) key. */
		public static const LEFT_BRACKET :uint = 219;

		/** Key code for the M key. */
		public static const M :uint = 77;

		/** Key code for the minus (-) key. */
		public static const MINUS :uint = 189;

		/** Key code for the N key. */
		public static const N :uint = 78;

		/** Key code for the 0 key. */
		public static const NUMBER_0 :uint = 48;

		/** Key code for the 1 key. */
		public static const NUMBER_1 :uint = 49;

		/** Key code for the 2 key. */
		public static const NUMBER_2 :uint = 50;

		/** Key code for the 3 key. */
		public static const NUMBER_3 :uint = 51;

		/** Key code for the 4 key. */
		public static const NUMBER_4 :uint = 52;

		/** Key code for the 5 key. */
		public static const NUMBER_5 :uint = 53;

		/** Key code for the 6 key. */
		public static const NUMBER_6 :uint = 54;

		/** Key code for the 7 key. */
		public static const NUMBER_7 :uint = 55;

		/** Key code for the 8 key. */
		public static const NUMBER_8 :uint = 56;

		/** Key code for the 9 key. */
		public static const NUMBER_9 :uint = 57;

		/** Key code for the 0 key on the numeric pad. */
		public static const NUMPAD_0 :uint = 96;

		/** Key code for the 1 key on the numeric pad. */
		public static const NUMPAD_1 :uint = 97;

		/** Key code for the 2 key on the numeric pad. */
		public static const NUMPAD_2 :uint = 98;

		/** Key code for the 3 key on the numeric pad. */
		public static const NUMPAD_3 :uint = 99;

		/** Key code for the 4 key on the numeric pad. */
		public static const NUMPAD_4 :uint = 100;

		/** Key code for the 5 key on the numeric pad. */
		public static const NUMPAD_5 :uint = 101;

		/** Key code for the 6 key on the numeric pad. */
		public static const NUMPAD_6 :uint = 102;

		/** Key code for the 7 key on the numeric pad. */
		public static const NUMPAD_7 :uint = 103;

		/** Key code for the 8 key on the numeric pad. */
		public static const NUMPAD_8 :uint = 104;

		/** Key code for the 9 key on the numeric pad. */
		public static const NUMPAD_9 :uint = 105;

		/** Key code for the addition (+) key on the numeric pad. */
		public static const NUMPAD_ADD :uint = 107;

		/** Key code for the decimal (.) key on the numeric pad. */
		public static const NUMPAD_DECIMAL :uint = 110;

		/** Key code for the division (/) key on the numeric pad. */
		public static const NUMPAD_DIVIDE :uint = 111;

		/** Key code for the enter key on the numeric pad. */
		public static const NUMPAD_ENTER :uint = 108;

		/** Key code for the multiplication (*) key on the numeric pad. */
		public static const NUMPAD_MULTIPLY :uint = 106;

		/** Key code for the subtraction (-) key on the numeric pad. */
		public static const NUMPAD_SUBTRACT :uint = 109;

		/** Key code for the O key. */
		public static const O :uint = 79;

		/** Key code for the P key. */
		public static const P :uint = 80;

		/** Key code for the page down key. */
		public static const PAGE_DOWN :uint = 34;

		/** Key code for the page up key. */
		public static const PAGE_UP :uint = 33;

		/** Key code for the period (.) key. */
		public static const PERIOD :uint = 190;

		/** Key code for the Q key. */
		public static const Q :uint = 81;

		/** Key code for the quote/apostrophe (') key. */
		public static const QUOTE :uint = 222;

		/** Key code for the R key. */
		public static const R :uint = 82;

		/** Key code for the right arrow key. */
		public static const RIGHT :uint = 39;

		/** Key code for the right bracket (]) key. */
		public static const RIGHT_BRACKET :uint = 221;

		/** Key code for the S key. */
		public static const S :uint = 83;

		/** Key code for the semicolon (;) key. */
		public static const SEMICOLON :uint = 186;

		/** Key code for the shift key. */
		public static const SHIFT :uint = 16;

		/** Key code for the slash (/) key. */
		public static const SLASH :uint = 191;

		/** Key code for the space bar. */
		public static const SPACE :uint = 32;

		/** Key code for the T key. */
		public static const T :uint = 84;

		/** Key code for the tab key. */
		public static const TAB :uint = 9;

		/** Key code for the U key. */
		public static const U :uint = 85;

		/** Key code for the up arrow key. */
		public static const UP :uint = 38;

		/** Key code for the V key. */
		public static const V :uint = 86;

		/** Key code for the W key. */
		public static const W :uint = 87;

		/** Key code for the X key. */
		public static const X :uint = 88;

		/** Key code for the Y key. */
		public static const Y :uint = 89;

		/** Key code for the Z key. */
		public static const Z :uint = 90;

		private var keyboardEventDispatcher :IEventDispatcher;
		private var keyButtons :Dictionary = new Dictionary();
		
		public function Keyboard (keyboardEventDispatcher:IEventDispatcher=null) {
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
		
		public function buttonForKey (keyCode:uint) :Button {
			var button:Button = keyButtons[keyCode];
			if (!button) {
				button = new Button();
				keyButtons[keyCode] = button;
			}
			return button;
		}
		
		public function throttleForKey (keyCode:uint) :ButtonThrottle {
			var button:Button = buttonForKey(keyCode);
			return new ButtonThrottle(button);
		}
		
		public function wheelForKeys (leftKeyCode:uint, rightKeyCode:uint) :ButtonWheel {
			var leftButton:Button = buttonForKey(leftKeyCode);
			var rightButton:Button = buttonForKey(rightKeyCode);
			return new ButtonWheel(leftButton, rightButton);
		}
		
		public function joystickForKeys (upKeyCode:uint, downKeyCode:uint,
				leftKeyCode:uint, rightKeyCode:uint) :ButtonJoystick {
			var upButton:Button = buttonForKey(upKeyCode);
			var downButton:Button = buttonForKey(downKeyCode);
			var leftButton:Button = buttonForKey(leftKeyCode);
			var rightButton:Button = buttonForKey(rightKeyCode);
			return new ButtonJoystick(upButton, downButton, leftButton, rightButton);
		}
		
		private function onKeyDown (event:KeyboardEvent) :void {
			var button:Button = keyButtons[event.keyCode];
			if (button) {
				button.press();
			}
		}
		
		private function onKeyUp (event:KeyboardEvent) :void {
			var button:Button = keyButtons[event.keyCode];
			if (button) {
				button.release();
			}
		}
		
	}
	
}