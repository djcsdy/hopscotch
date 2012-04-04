package hopscotch.collision;

import hopscotch.Static;
import hopscotch.math.VectorMath;

class CircleMask extends Mask {
    public var x:Float;
    public var y:Float;
    public var radius:Float;

    public function new(x:Float=0, y:Float=0, radius:Float=0) {
        super();

        this.x = x;
        this.y = y;
        this.radius = radius;

        implement(CircleMask, collideCircle);
    }

    function collideCircle(mask:CircleMask):Bool {
        Static.point.x = x;
        Static.point.y = y;
        Static.point2.x = mask.x;
        Static.point2.y = mask.y;

        VectorMath.subtract(Static.point, Static.point2);

        return VectorMath.magnitude(Static.point) > radius + mask.radius;
    }
}
