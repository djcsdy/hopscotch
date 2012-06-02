package hopscotch.input.digital;

import flash.Lib;
import flash.events.KeyboardEvent;
import flash.events.EventDispatcher;

class Keyboard {
    private var keyboardEventDispatcher:EventDispatcher;
    private var keyButtons:Array<Button>;

    public function new (keyboardEventDispatcher:EventDispatcher = null) {
        keyButtons = [];
        bind(keyboardEventDispatcher);
    }

    public function bind (keyboardEventDispatcher:EventDispatcher = null) {
        if (keyboardEventDispatcher == null) {
            keyboardEventDispatcher = Lib.current.stage;
        }

        if (keyboardEventDispatcher == this.keyboardEventDispatcher) {
            return;
        }

        unbind();

        keyboardEventDispatcher.addEventListener(
                KeyboardEvent.KEY_DOWN, onKeyDown);
        keyboardEventDispatcher.addEventListener(
                KeyboardEvent.KEY_UP, onKeyUp);

        this.keyboardEventDispatcher = keyboardEventDispatcher;
    }

    public function unbind () {
        for (button in keyButtons) {
            if (button != null) {
                button.release();
            }
        }

        if (this.keyboardEventDispatcher != null) {
            this.keyboardEventDispatcher.removeEventListener(
                    KeyboardEvent.KEY_DOWN, onKeyDown);
            this.keyboardEventDispatcher.removeEventListener(
                    KeyboardEvent.KEY_UP, onKeyUp);
        }
    }

    public function buttonForKey (key:Key) {
        var keycode = keycodeForKey(key);
        if (keyButtons[keycode] != null) {
            return keyButtons[keycode];
        } else {
            return keyButtons[keycode] = new Button();
        }
    }

    public function throttleForKey (key:Key, ease:Float = 0.4) {
        return new ButtonThrottle(buttonForKey(key), ease);
    }

    public function wheelForKeys (left:Key, right:Key, ease:Float = 0.4) {
        return new ButtonWheel(buttonForKey(left), buttonForKey(right), ease);
    }

    public function joystickForKeys (up:Key, down:Key,
            left:Key, right:Key, ease:Float=0.4) {
        return new ButtonJoystick(buttonForKey(up), buttonForKey(down),
                buttonForKey(left), buttonForKey(right), ease);
    }

    private function onKeyDown (event:KeyboardEvent) {
        var button:Button = keyButtons[event.keyCode];
        if (button != null) {
            button.press();
        }
    }

    private function onKeyUp (event:KeyboardEvent) {
        var button:Button = keyButtons[event.keyCode];
        if (button != null) {
            button.release();
        }
    }

    private function keycodeForKey (key:Key) {
        return switch (key) {
            case A: 65;
            case B: 66;
            case C: 67;
            case D: 68;
            case E: 69;
            case F: 70;
            case G: 71;
            case H: 72;
            case I: 73;
            case J: 74;
            case K: 75;
            case L: 76;
            case M: 77;
            case N: 78;
            case O: 79;
            case P: 80;
            case Q: 81;
            case R: 82;
            case S: 83;
            case T: 84;
            case U: 85;
            case V: 86;
            case W: 87;
            case X: 88;
            case Y: 89;
            case Z: 90;

            case Number0: 48;
            case Number1: 49;
            case Number2: 50;
            case Number3: 51;
            case Number4: 52;
            case Number5: 53;
            case Number6: 54;
            case Number7: 55;
            case Number8: 56;
            case Number9: 57;

            case Backtick: 192;
            case Backslash: 220;
            case Comma: 118;
            case Equals: 187;
            case LeftBracket: 219;
            case Minus: 189;
            case Period: 190;
            case Quote: 222;
            case RightBracket: 221;
            case Semicolon: 186;
            case Slash: 191;
            case Space: 32;
            case Tab: 9;

            case Numpad0: 96;
            case Numpad1: 97;
            case Numpad2: 98;
            case Numpad3: 99;
            case Numpad4: 100;
            case Numpad5: 101;
            case Numpad6: 102;
            case Numpad7: 103;
            case Numpad8: 104;
            case Numpad9: 105;
            case NumpadAdd: 107;
            case NumpadDecimal: 110;
            case NumpadDivide: 111;
            case NumpadEnter: 108;
            case NumpadMultiply: 106;
            case NumpadSubtract: 109;

            case Up: 38;
            case Down: 40;
            case Left: 37;
            case Right: 39;

            case Backspace: 8;
            case Delete: 46;
            case End: 35;
            case Enter: 13;
            case Home: 36;
            case Insert: 45;
            case PageDown: 34;
            case PageUp: 33;

            case Alt: 18;
            case CapsLock: 20;
            case Command: 15;
            case Control: 17;
            case Shift: 16;

            case F1: 112;
            case F2: 113;
            case F3: 114;
            case F4: 115;
            case F5: 116;
            case F6: 117;
            case F7: 118;
            case F8: 119;
            case F9: 120;
            case F10: 121;
            case F11: 122;
            case F12: 123;
            case F13: 124;
            case F14: 125;
            case F15: 126;

            case Escape: 27;
        };
    }
}
