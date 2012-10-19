package hopscotch.geometry;

/** A 2D ray.
 *
 * A ray is a line that starts a specified origin and stretches infinitely in a
 * specified direction. */
class Ray2d {

    /** The origin of the ray.
     *
     * It is acceptable to modify the x and y properties of the origin
     * directly. */
    public var origin(default, null):Vector2d;

    /** The direction of the ray, expressed as a unit vector.
     *
     * The direction must be a unit vector (its magnitude must be 1), but for
     * performance the ray does not verify this requirement. If the direction
     * is not a unit vector, then some subsequent operations involving the ray
     * will not give correct results.
     *
     * Keeping the above in mind, it is acceptable to modify the x and y
     * properties of the direction directly. */
    public var direction(default, null):Vector2d;

    /** Constructs a new ray with the specified origin and direction.
     *
     * The direction must be a unit vector (its magnitude must be 1), but for
     * performance the constructor does not verify this requirement. If the
     * direction is not a unit vector, then some subsequent operations
     * involving the ray will not give correct results.
     *
     * This constructor makes a copy of the origin and direction, so you may
     * safely modify and reuse those vectors after passing them to this
     * function.
     *
     * If the origin is not specified, then the default is (0, 0).
     *
     * If a direction is not specified, then the default is (0, -1) (usually
     * “up”). */
    public function new(origin:Vector2d = null, direction:Vector2d = null) {
        this.origin = if (origin == null) new Vector2d() else origin.clone();
        this.direction = if (direction == null) new Vector2d(0, -1) else direction.clone();
    }

    /** Sets the origin from the specified vector.
     *
     * The value of the specified vector is copied over the origin, so you
     * may safely modify and reuse the specified vector after passing it to
     * this function. */
    public inline function setOrigin(origin:Vector2d) {
        this.origin.copyFrom(origin);
    }

    /** Sets the direction from the specified vector.
     *
     * The direction must be a unit vector (its magnitude must be 1), but for
     * for performance the function does not verify this requirement. If the
     * direction is not a unit vector, then some subsequent operations
     * involving the ray will not give correct results.
     *
     * The value of the specified vector is copied over the direction, so you
     * may safely modify and reuse the specified vector after passing it to
     * this function. */
    public inline function setDirection(direction:Vector2d) {
        this.direction.copyFrom(direction);
    }

    /** Sets the direction from the specified angle.
     *
     * The angle is measured clockwise in radians, relative to direction
     * in which the y-axis is negative (usually “up”). */
    public inline function setAngle(radians:Float) {
        this.direction.toUnitVector(radians);
    }
}
