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
    public function new(x = 0.0, y = 0.0) {
        this.x = x;
        this.y = y;
    }

    /** Adds the specified vector to the current vector. The current vector
     * is modified in place. */
    public inline function add(v:Vector2d) {
        x += v.x;
        y += v.y;
    }

    /** Subtracts the specified vector from the current vector. The current
     * vector is modified in place. */
    public inline function subtract(v:Vector2d) {
        x -= v.x;
        y -= v.y;
    }

    /** Computes the dot product of the current vector and the specified
     * vector. */
    public inline function dot(v:Vector2d) {
        return x * v.x + y * v.y;
    }

    /** Computes the cross product of the current vector and the specified
     * vector. */
    public inline function cross(v:Vector2d) {
        return x * v.y - y * v.x;
    }

    /** Scales the current vector by the specified scaling factor. The current
     * vector is modified in place. */
    public inline function scale(s:Float) {
        x *= s;
        y *= s;
    }

    /** Negates the current vector in place. */
    public inline function negate() {
        x = -x;
        y = -y;
    }

    /** Computes the angle of the current vector.
     *
     * The angle is measured clockwise in radians, relative to direction
     * in which the y-axis is negative (usually “up”).
     *
     * The angle returned by this function will be in the range -pi through
     * pi radians, inclusive.
     *
     * If the current vector has a magnitude of zero, then its angle is not
     * mathematically defined. In that case, this function arbitrarily returns
     * 0. */
    public inline function angle() {
        if (x == 0 && y == 0) {
            return 0.0;
        } else {
            return Math.atan2(x, -y);
        }
    }

    /** Computes the magnitude of the current vector. */
    public inline function magnitude() {
        return Math.sqrt(x * x + y * y);
    }

    /** Scales the current vector so that it has the specified magnitude.
     * The current vector is modified in place.
     *
     * It is not possible to normalize a vector whose magnitude is zero. In
     * that case, this function will set the x and y properties of the current
     * vector to NaN. */
    public inline function normalize(magnitude = 1.0) {
        var previousMagnitude = this.magnitude();

        x *= magnitude/previousMagnitude;
        y *= magnitude/previousMagnitude;
    }

    /** Computes the distance between the point whose coordinates are given by
     * the current vector, and the point whose coordinates are given by the
     * specified vector. */
    public inline function distance(v:Vector2d) {
        var dx = v.x - x;
        var dy = v.y - y;

        return Math.sqrt(dx * dx + dy * dy);
    }

    /** Rotates the current vector by the specified angle. The angle is
     * measured clockwise in radians. */
    public inline function rotate(radians:Float) {
        var sin = Math.sin(radians);
        var cos = Math.cos(radians);

        var x = this.x;
        var y = this.y;

        this.x = cos * x - sin * y;
        this.y = cos * y + sin * x;
    }

    /** Overwrites the values of the current vector so that it is the unit
     * vector with the specified angle. The angle is measured clockwise in
     * radians, relative to the direction in which the y-axis is negative
     * (usually “up”). */
    public inline function toUnitVector(radians:Float) {
        x = Math.sin(radians);
        y = -Math.cos(radians);
    }

    /** Overwrites the values of the current vector with the cartesian
     * representation of the specified polar coordinates. The angle is
     * measured in radians relative to the direction in which the y-axis is
     * negative (usually “up”). */
    public inline function toPolar(radians:Float, magnitude:Float) {
        x = Math.sin(radians) * magnitude;
        y = -Math.cos(radians) * magnitude;
    }

    /** Copies the value of the source vector to the current vector. */
    public inline function copyFrom(source:Vector2d) {
        x = source.x;
        y = source.y;
    }

    /** Constructs a new vector that has the same value as the current
     * vector. */
    public inline function clone() {
        return new Vector2d(x, y);
    }
}
