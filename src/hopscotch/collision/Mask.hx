package hopscotch.collision;

import haxe.ds.StringMap;
import hopscotch.errors.ArgumentError;
import hopscotch.errors.ArgumentNullError;
import hopscotch.errors.IllegalOperationError;
import hopscotch.errors.NotImplementedError;

class Mask {
    var className:String;
    var tests:Map<String, Mask->Float->Float->Float->Float->Bool>;

    public function new() {
        className = Type.getClassName(Type.getClass(this));
        tests = new StringMap<Mask->Float->Float->Float->Float->Bool>();
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
        if (mask2 == null) {
            throw new ArgumentNullError("mask2");
        }

        if (!Math.isFinite(x1)) {
            throw new ArgumentError("x1 must be finite");
        }

        if (!Math.isFinite(y1)) {
            throw new ArgumentError("y1 must be finite");
        }

        if (!Math.isFinite(x2)) {
            throw new ArgumentError("x2 must be finite");
        }

        if (!Math.isFinite(y2)) {
            throw new ArgumentError("y2 must be finite");
        }

        if (tests.exists(mask2.className)) {
            return tests.get(mask2.className)(mask2, x1, y1, x2, y2);
        } else if (mask2.tests.exists(className)) {
            return mask2.tests.get(className)(this, x2, y2, x1, y1);
        } else {
            throw new NotImplementedError("Collision between " + className
                    + " and " + mask2.className
                    + " is not implemented");
        }
    }
}
