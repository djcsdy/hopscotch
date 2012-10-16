package hopscotch.geometry;

/** A two-dimensional vector.
*
* Used, for example, to represent a point in a two-dimensional space, where x
* represents the position on the horizontal axis, and y represents the position
* on the vertical axis. */
class Vector2d {
    /** The x value. */
    public var x:Float;

    /** The y value. */
    public var y:Float;

    /** Constructs a new vector with the specified x and y values. */
    public function new(x=0.0, y=0.0) {
        this.x = x;
        this.y = y;
    }
}
