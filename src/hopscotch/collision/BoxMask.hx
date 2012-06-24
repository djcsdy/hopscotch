package hopscotch.collision;

import hopscotch.errors.ArgumentError;
import hopscotch.errors.IllegalOperationError;
import hopscotch.Static;

class BoxMask extends Mask {
    public var x:Float;
    public var y:Float;
    public var width:Float;
    public var height:Float;

    public function new (x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
        super();

        if (!Math.isFinite(x)) {
            throw new ArgumentError("x must be finite");
        }

        if (!Math.isFinite(y)) {
            throw new ArgumentError("y must be finite");
        }

        if (!Math.isFinite(width)) {
            throw new ArgumentError("width must be finite");
        }

        if (width < 0) {
            throw new ArgumentError("width must not be negative");
        }

        if (!Math.isFinite(height)) {
            throw new ArgumentError("height must be finite");
        }

        if (height < 0) {
            throw new ArgumentError("height must not be negative");
        }

        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;

        implement(BoxMask, collideBox);
    }

    function collideBox (mask2:BoxMask, x1:Float, y1:Float, x2:Float, y2:Float) {
        checkProperties();
        mask2.checkProperties();

        Static.rect.x = x + x1;
        Static.rect.y = y + y1;
        Static.rect.width = width;
        Static.rect.height = height;

        Static.rect2.x = mask2.x + x2;
        Static.rect2.y = mask2.y + y2;
        Static.rect2.width = mask2.width;
        Static.rect2.height = mask2.height;

        return Static.rect.intersects(Static.rect2);
    }

    public inline function checkProperties () {
        if (!Math.isFinite(x)) {
            throw new IllegalOperationError("BoxMask.x must be finite");
        }

        if (!Math.isFinite(y)) {
            throw new IllegalOperationError("BoxMask.y must be finite");
        }

        if (!Math.isFinite(width)) {
            throw new IllegalOperationError("BoxMask.width must be finite");
        }

        if (width < 0) {
            throw new IllegalOperationError("BoxMask.width must not be negative");
        }

        if (!Math.isFinite(height)) {
            throw new IllegalOperationError("BoxMask.height must be finite");
        }

        if (height < 0) {
            throw new IllegalOperationError("BoxMask.height must not be negative");
        }
    }
}
