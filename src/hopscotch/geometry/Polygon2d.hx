package hopscotch.geometry;

class Polygon2d {
    public var vertices(default, null):Array<Vector2d>;

    public static inline function box(width:Float, height:Float) {
        return rectangle(-width * 0.5, -height * 0.5, width, height);
    }

    public static function rectangle(x:Float, y:Float, width:Float, height:Float) {
        return new Polygon2d([
            new Vector2d(x, y),
            new Vector2d(x + width, y),
            new Vector2d(x + width, y + height),
            new Vector2d(x, y + height)
        ]);
    }

    public static function regular(numSides:Int, radius:Float, angleOffset = 0.0, x = 0.0, y = 0.0) {
        var i = 0;
        var vertices = {
            hasNext: function () {
                return i < numSides;
            },
            next: function () {
                var angle = angleOffset + i * Math.PI * 2 / numSides;
                ++i;
                return new Vector2d(Math.sin(angle) * radius, -Math.cos(angle) * radius);
            }
        }

        return new Polygon2d(vertices);
    }

    private function new(vertices:Iterable<Vector2d> = null) {
        this.vertices = if (vertices == null) new Array<Vector2d>() else Lambda.array(vertices);
    }
}
