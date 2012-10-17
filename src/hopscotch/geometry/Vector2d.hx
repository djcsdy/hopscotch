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

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Adds the specified vector to the current vector. The current vector
     * is modified in place. */
    public inline function add(v:Vector2d) {
        Vector2d.add(this, v);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Subtracts the specified vector from the current vector. The current
     * vector is modified in place. */
    public inline function subtract(v:Vector2d) {
        Vector2d.subtract(this, v);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Computes the dot product of the current vector and the specified
     * vector. */
    public inline function dot(v:Vector2d) {
        return Vector2d.dot(this, v);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Computes the cross product of the current vector and the specified
     * vector. */
    public inline function cross(v:Vector2d) {
        return Vector2d.cross(this, v);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Scales the current vector by the specified scaling factor. The current
     * vector is modified in place. */
    public inline function scale(s:Float) {
        Vector2d.scale(this, s);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Negates the current vector in place. */
    public inline function negate() {
        Vector2d.negate(this);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
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
        return Vector2d.angle(this);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Computes the magnitude of the current vector. */
    public inline function magnitude() {
        return Vector2d.magnitude(this);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Scales the current vector so that it has the specified magnitude.
     * The current vector is modified in place.
     *
     * It is not possible to normalize a vector whose magnitude is zero. In
     * that case, this function will set the magnitude of the current vector
     * to an infinite value, and the angle to an arbitrary value. */
    public inline function normalize(magnitude = 1.0) {
        Vector2d.normalize(this, magnitude);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Computes the distance between the point whose coordinates are given by
     * the current vector, and the point whose coordinates are given by the
     * specified vector. */
    public inline function distance(v:Vector2d) {
        return Vector2d.distance(this, v);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Rotates the current vector by the specified angle. The angle is
     * measured clockwise in radians. */
    public inline function rotate(radians:Float) {
        Vector2d.rotate(this, radians);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Overwrites the values of the current vector so that it is the unit
     * vector with the specified angle. The angle is measured clockwise in
     * radians, relative to the direction in which the y-axis is negative
     * (usually “up”). */
    public inline function toUnitVector(radians:Float) {
        Vector2d.toUnitVector(this, radians);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Overwrites the values of the current vector with the cartesian
     * representation of the specified polar coordinates. The angle is
     * measured in radians relative to the direction in which the y-axis is
     * negative (usually “up”). */
    public inline function toPolar(radians:Float, magnitude:Float) {
        Vector2d.toPolar(this, radians, magnitude);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Copies the value of the source vector to the current vector. */
    public inline function copyFrom(source:Vector2d) {
        copyTo(this, source);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Vector2d. This reduces memory
    // consumption on some platforms.
    //
    /** Constructs a new vector that has the same value as the current
     * vector. */
    public inline function clone() {
        return clone(this);
    }

    /** Overwrites the first specified vector, v, with the sum of the specified
     * vectors, v and w. */
    public static inline function add(v:Vector2d, w:Vector2d) {
        v.x += w.x;
        v.y += w.y;
    }

    /** Computes the result of subtracting the second specified vector, w,
     * from the first specified vector, v, and overwrites v with the result. */
    public static inline function subtract(v:Vector2d, w:Vector2d) {
        v.x -= w.x;
        v.y -= w.y;
    }

    /** Computes the dot product of the specified vectors. */
    public static inline function dot(v:Vector2d, w:Vector2d) {
        return v.x * w.x + v.y * w.y;
    }

    /** Computes the cross product of the specified vectors. */
    public static inline function cross(v:Vector2d, w:Vector2d) {
        return v.x * w.y - v.y * w.x;
    }

    /** Scales the specified vector by the specified scaling factor. The
     * vector is modified in place. */
    public static inline function scale(v:Vector2d, s:Float) {
        v.x *= s;
        v.y *= s;
    }

    /** Negates the specified vector. The vector is modified in place. */
    public static inline function negate(v:Vector2d) {
        v.x = -v.x;
        v.y = -v.y;
    }

    /** Computes the angle of the specified vector.
     *
     * The angle is measured clockwise in radians, relative to direction
     * in which the y-axis is negative (usually “up”).
     *
     * The angle returned by this function will be in the range -pi through
     * pi radians, inclusive.
     *
     * If the vector has a magnitude of zero, then its angle is not
     * mathematically defined. In that case, this function arbitrarily returns
     * 0. */
    public static inline function angle(v:Vector2d) {
        if (v.x == 0 && v.y == 0) {
            return 0.0;
        } else {
            return Math.atan2(v.x, -v.y);
        }
    }

    /** Computes the magnitude of the specified vector. */
    public static inline function magnitude(v:Vector2d) {
        return Math.sqrt(v.x * v.x + v.y * v.y);
    }

    /** Scales the specified vector so that it has the specified magnitude.
     * The vector is modified in place.
     *
     * It is not possible to normalize a vector whose magnitude is zero. In
     * that case, this function will set the magnitude of the vector to an
      * infinite value, and the angle to an arbitrary value. */
    public static inline function normalize(v:Vector2d, magnitude = 1.0) {
        var previousMagnitude = Vector2d.magnitude(v);

        v.x *= magnitude/previousMagnitude;
        v.y *= magnitude/previousMagnitude;
    }

    /** Computes the distance between the points whose coordinates are given by
     * the specified vectors. */
    public static inline function distance(v:Vector2d, w:Vector2d) {
        var dx = w.x - v.x;
        var dy = w.y - v.y;

        return Math.sqrt(dx * dx + dy * dy);
    }

    /** Rotates the specified vector by the specified angle. The angle is
     * measured clockwise in radians. */
    public static inline function rotate(v:Vector2d, radians:Float) {
        var sin = Math.sin(radians);
        var cos = Math.cos(radians);

        var x = v.x;
        var y = v.y;

        v.x = cos * x - sin * y;
        v.y = cos * y + sin * x;
    }

    /** Overwrites the values of the specified vector so that it is the unit
     * vector with the specified angle. The angle is measured clockwise in
     * radians, relative to the direction in which the y-axis is negative
     * (usually “up”). */
    public static inline function toUnitVector(v:Vector2d, radians:Float) {
        v.x = Math.sin(radians);
        v.y = -Math.cos(radians);
    }

    /** Overwrites the values of the specified vector with the cartesian
     * representation of the specified polar coordinates. The angle is
     * measured in radians relative to the direction in which the y-axis is
     * negative (usually “up”). */
    public static inline function toPolar(v:Vector2d, radians:Float, magnitude:Float) {
        v.x = Math.sin(radians) * magnitude;
        v.y = -Math.cos(radians) * magnitude;
    }

    /** Copies the values of the source vector to the destination vector. */
    public static inline function copyTo(dest:Vector2d, source:Vector2d) {
        v.x = w.x;
        v.y = w.y;
    }

    /** Constructs a new vector that has the same value as the specified
     * vector. */
    public static inline function clone(v:Vector2d) {
        return new Vector2d(v.x, v.y);
    }
}
