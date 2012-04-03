package hopscotch.camera;

import hopscotch.Entity;

class FollowCamera implements ICamera {
    public var target:Entity;

    private var targetX:Float;
    private var targetY:Float;

    public function new(target:Entity=null) {
        this.target = target;
        targetX = 0;
        targetY = 0;
    }

    public function update(frame:Int, matrix:Matrix):Void {
        if (target != null) {
            targetX = target.x;
            targetY = target.y;
        }

        matrix.a = matrix.d = 1;
        matrix.b = matrix.c = 0;
        matrix.tx = targetX;
        matrix.ty = targetY;
    }
}