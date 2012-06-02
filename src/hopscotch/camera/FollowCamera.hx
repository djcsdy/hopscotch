package hopscotch.camera;

import hopscotch.engine.ScreenSize;
import flash.geom.Matrix;
import hopscotch.Entity;

class FollowCamera implements ICamera {
    public var target:Entity;

    private var targetX:Float;
    private var targetY:Float;

    public function new (target:Entity = null) {
        this.target = target;
        targetX = 0;
        targetY = 0;
    }

    public function begin (frame:Int) {
    }

    public function end () {
    }

    public function update (frame:Int, screenSize:ScreenSize, matrix:Matrix) {
        if (target != null) {
            targetX = target.x;
            targetY = target.y;
        }

        matrix.tx += targetX - screenSize.width * 0.5;
        matrix.ty += targetY - screenSize.height * 0.5;
    }
}
