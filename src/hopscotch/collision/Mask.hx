package hopscotch.collision;

import hopscotch.errors.ArgumentNullError;
import hopscotch.errors.IllegalOperationError;
import hopscotch.errors.NotImplementedError;

class Mask {
    var className:String;
    var tests:Hash<Mask->Float->Float->Float->Float->Bool>;

    public function new() {
        className = Type.getClassName(Type.getClass(this));
        tests = new Hash<Mask->Float->Float->Float->Float->Bool>();
    }

    public function implement (otherClass:Class<Mask>, test:Dynamic->Float->Float->Float->Float->Bool) {
        if (otherClass == null) {
            throw new ArgumentNullError("otherClass");
        }

        if (test == null) {
            throw new ArgumentNullError("test");
        }

        tests.set(Type.getClassName(otherClass), test);
    }

    public function collide (mask2:Mask, x1:Float=0, y1:Float=0, x2:Float=0, y2:Float=0) {
        if (tests.exists(mask2.className)) {
            return tests.get(mask2.className)(mask2, x1, y1, x2, y2);
        } else if (mask2.tests.exists(className)) {
            return tests.get(className)(this, x2, y2, x1, y1);
        } else {
            throw new NotImplementedError("Collision between " + className
                    + " and " + mask2.className
                    + " is not implemented");
        }
    }
}
