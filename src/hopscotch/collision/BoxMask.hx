package hopscotch.collision;

import hopscotch.Static;

class BoxMask extends Mask {
    public var x:Float;
    public var y:Float;
    public var width:Float;
    public var height:Float;

    public function new (x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0) {
        super();

        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;

        implement(BoxMask, collideBox);
    }

    function collideBox (mask2:BoxMask, x1:Float, y1:Float, x2:Float, y2:Float) {
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
}
