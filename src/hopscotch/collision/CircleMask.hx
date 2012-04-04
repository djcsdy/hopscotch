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

    function collideCircle(mask2:CircleMask, x1:Float, y1:Float, x2:Float, y2:Float):Bool {
        Static.point.x = x + x1;
        Static.point.y = y + y1;
        Static.point2.x = mask2.x + x2;
        Static.point2.y = mask2.y + y2;

        VectorMath.subtract(Static.point, Static.point2);

        return VectorMath.magnitude(Static.point) > radius + mask2.radius;
    }
}
