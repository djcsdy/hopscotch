package hopscotch.collision;

import hopscotch.errors.IllegalOperationError;
import hopscotch.errors.ArgumentError;
import hopscotch.Static;
import hopscotch.math.VectorMath;

class CircleMask extends Mask {
    public var x:Float;
    public var y:Float;
    public var radius:Float;

    public function new (x:Float = 0, y:Float = 0, radius:Float = 0) {
        super();

        if (!Math.isFinite(x)) {
            throw new ArgumentError("x must be finite");
        }

        if (!Math.isFinite(y)) {
            throw new ArgumentError("y must be finite");
        }

        if (!Math.isFinite(radius)) {
            throw new ArgumentError("radius must be finite");
        }

        if (radius < 0) {
            throw new ArgumentError("radius must not be negative");
        }

        this.x = x;
        this.y = y;
        this.radius = radius;

        implement(CircleMask, collideCircle);
        implement(BoxMask, collideBox);
    }

    function collideCircle (mask2:CircleMask, x1:Float, y1:Float, x2:Float, y2:Float) {
        checkProperties();
        mask2.checkProperties();

        Static.point.x = x + x1;
        Static.point.y = y + y1;
        Static.point2.x = mask2.x + x2;
        Static.point2.y = mask2.y + y2;

        VectorMath.subtract(Static.point, Static.point2);

        return VectorMath.magnitude(Static.point) < radius + mask2.radius;
    }

    function collideBox (mask2:BoxMask, x1:Float, y1:Float, x2:Float, y2:Float) {
        checkProperties();
        mask2.checkProperties();

        Static.point.x = Math.abs(x + x1 - mask2.x - x2 - mask2.width * 0.5);
        Static.point.y = Math.abs(y + y1 - mask2.y - y2 - mask2.height * 0.5);
        var distance = VectorMath.magnitude(Static.point);
        VectorMath.normalize(Static.point);

        Static.point2.x = mask2.width * 0.5;
        Static.point2.y = mask2.height * 0.5;

        return distance < VectorMath.dot(Static.point2, Static.point) + radius;
    }

    public inline function checkProperties () {
        if (!Math.isFinite(x)) {
            throw new IllegalOperationError("CircleMask.x must be finite");
        }

        if (!Math.isFinite(y)) {
            throw new IllegalOperationError("CircleMask.y must be finite");
        }

        if (!Math.isFinite(radius)) {
            throw new IllegalOperationError("CircleMask.radius must be finite");
        }

        if (radius < 0) {
            throw new IllegalOperationError("CircleMask.radius must not be negative");
        }
    }
}
