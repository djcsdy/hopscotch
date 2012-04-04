package hopscotch.collision;

import hopscotch.errors.ArgumentNullError;
import hopscotch.errors.IllegalOperationError;
import hopscotch.errors.NotImplementedError;

class Mask {
    var className:String;
    var tests:Hash<Mask->Bool>;

    public function new() {
        className = Type.getClassName(Type.getClass(this));
        tests = new Hash<Mask->Bool>();
    }

    public function implement(otherClass:Class<Mask>, test:Dynamic->Bool) {
        if (otherClass == null) {
            throw new ArgumentNullError("otherClass");
        }

        if (test == null) {
            throw new ArgumentNullError("test");
        }

        tests.set(Type.getClassName(otherClass), test);
    }

    public function collide(mask:Mask):Bool {
        if (tests.exists(mask.className)) {
            return tests.get(mask.className)(mask);
        } else if (mask.tests.exists(className)) {
            return tests.get(className)(this);
        } else {
            throw new NotImplementedError("Collision between " + className
                    + " and " + mask.className
                    + " is not implemented");
        }
    }
}
