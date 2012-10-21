package hopscotch.geometry;

/** A 2-row, 3-column matrix, used to represent an affine transformation in
 * two dimensions.
 *
 * It is not necessary to understand matrix mathematics to use this class. You
 * can think of a matrix as simply being a box that efficiently stores a
 * sequence of two-dimensional geometric transformations (translation, rotation
 * and scaling), which can then be applied to a Vector2d or other geometry in a
 * single step.
 *
 * The identity matrix can be thought of as an empty box that is ready to store
 * a sequence of transformations. The identity matrix is a matrix that applies
 * the null or identity affine transformation; an object that is transformed by
 * the identity matrix will be identical to the original.
 *
 * The matrix values are arranged in the following orientation.
 *
 * <table><tr><td>a</td><td>c</td><td>tx</td></tr>
 * <tr><td>b</td><td>d</td><td>ty</td></tr></table>
 *
 * When used as an affine transformation, the matrix has an implicit third row
 * with the values [0 0 1].
 *
 * <table><tr><td>a</td><td>c</td><td>tx</td></tr>
 * <tr><td>b</td><td>d</td><td>ty</td></tr>
 * <tr><td>0</td><td>0</td><td>1</td></table>
 *
 * To transform source coordinates (x,y) to destination coordinates (x',y'),
 * the source coordinates are treated as a column vector [x;y;1] and multiplied
 * by the matrix, including its implicit third row.
 *
 * In other words:
 *
 * <ul><li>x' =  a.x + c.y + tx</li>
 * <li>y' = b.x + d.y + ty</li></ul> */
class Matrix23 {

    /** The value at coordinates (1,1) in the matrix. */
    public var a:Float;

    /** The value at coordinates (1,2) in the matrix. */
    public var b:Float;

    /** The value at coordinates (2,1) in the matrix. */
    public var c:Float;

    /** The value at coordinates (2,2) in the matrix. */
    public var d:Float;

    /** The value at coordinates (3,1) in the matrix. */
    public var tx:Float;

    /** The value at coordinates (3,2) in the matrix. */
    public var ty:Float;

    /** Construct a new matrix with the specified values.
     *
     * With the default values, constructs a new identity matrix. */
    public function new(a=1.0, b=0.0, c=0.0, d=1.0, tx=0.0, ty=0.0) {
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
        this.tx = tx;
        this.ty = ty;
    }

    /** Sets the properties of the matrix so that it is the identity matrix.
     *
     * The identity matrix can be thought of as an empty box that is ready to
     * store a sequence of transformations. The identity matrix is a matrix
     * that applies the null or identity affine transformation; an object that
     * is transformed by the identity matrix will be identical to the original.
     *
     * An identity matrix has the values a=1, b=0, c=0, d=1, tx=0, ty=0. */
    public function identity() {
        a = d = 1;
        b = c = tx = ty = 0;
    }

    /** Applies a scaling transformation to the matrix. The x-axis is scaled
     * by sx, and the y-axis is scaled by sy. */
    public function scale(sx:Float, sy:Float) {
        a *= sx;
        b *= sy;
        c *= sx;
        d *= sy;
        tx *= sx;
        ty *= sy;
    }

    /** Applies a rotation transformation to the matrix. The angle of rotation
     * is clockwise and is measured in radians. */
    public function rotate(radians:Float) {
        var cos = Math.cos(radians);
        var sin = Math.sin(radians);

        var a = this.a;
        var b = this.b;
        var c = this.c;
        var d = this.d;
        var tx = this.tx;
        var ty = this.ty;

        this.a = cos * a + -sin * b;
        this.b = sin * a + cos * b;
        this.c = cos * c + -sin * d;
        this.d = sin * c + cos * d;
        this.tx = cos * tx + -sin * ty;
        this.ty = sin * tx + cos * ty;
    }

    /** Applies a translation transformation to the matrix. The translation is
     * tx units along the x-axis, and ty pixels along the y-axis. */
    public function translate(tx:Float, ty:Float) {
        this.tx += tx;
        this.ty += ty;
    }

    /** Computes the determinant of the matrix.
     *
     * The determinant gives the proportional change in area of a shape that is
     * transformed by the affine transformation represented by matrix.
     *
     * If the determinant is zero, then the matrix is a singular matrix, meaning
     * that it transforms every shape into a single point. */
    public function determinant() {
        return a * d - b * c;
    }

    /** Inverts the matrix.
     *
     * The inverse of a matrix represents the inverse of the affine
     * transformation represented by the original matrix. For example, if the
     * original matrix represented a transformation equivalent to scaling an
     * object by four times and then rotating it by pi radians, its inverse will
     * represent a transformation equivalent to rotating an object -pi radians
     * and then scaling it by one quarter.
     *
     * If the matrix is a singular matrix, meaning that its determinant is
     * zero, and that it represents an affine transformation that transforms
     * every shape into a single point, then the matrix has no valid inverse.
     * In that case, this function will instead set the values of the matrix to
     * infinite values. */
    public function invert() {
        var determinant = this.determinant();
        var inverseDeterminant = 1/determinant;

        var a = this.a;
        var b = this.b;
        var c = this.c;
        var d = this.d;
        var tx = this.tx;
        var ty = this.ty;

        this.a = d * inverseDeterminant;
        this.b = -b * inverseDeterminant;
        this.c = -c * inverseDeterminant;
        this.d = a * inverseDeterminant;
        this.tx = ((c * ty) - (d * tx)) * inverseDeterminant;
        this.ty = ((b * tx) - (a * ty)) * inverseDeterminant;
    }

    /** Concatenates a matrix with the current matrix. The current matrix is
     * replaced by the concatenated matrix.
     *
     * This effectively combines the affine transformations represented by the
     * two matrices. For example, if the current matrix represents a
     * transformation that scales an object by four times, and the second
     * matrix represents a transformation that rotates an object by pi radians
     * (a half-turn), then the combined matrix will represent a transformation
     * that is equivalent to scaling an object by four times and then rotating
     * it by pi radians.
     *
     * In mathematical terms this operation is equivalent to matrix
     * multiplication. */
    public function concat(matrix:Matrix23) {
        var a = this.a;
        var b = this.b;
        var c = this.c;
        var d = this.d;
        var tx = this.tx;
        var ty = this.ty;

        this.a = matrix.a * a + matrix.c * b;
        this.b = matrix.b * a + matrix.d * b;
        this.c = matrix.a * c + matrix.c * d;
        this.d = matrix.b * c + matrix.d * d;
        this.tx = matrix.a * tx + matrix.c * ty + matrix.tx;
        this.ty = matrix.b * tx + matrix.d * ty + matrix.ty;
    }

    /** Applies the affine transformation represented by the current matrix
     * to the specified vector. The vector is modified in place.
     *
     * If ignoreTranslation is true, then the transformation is performed as
     * if the tx and ty properties of the matrix were both zero. */
    public function transform(point:Vector2d, ignoreTranslation = false) {
        var x = point.x;
        var y = point.y;

        point.x = a * x + c * y;
        point.y = b * x + d * y;

        if (!ignoreTranslation) {
            point.x += tx;
            point.y += ty;
        }
    }

    /** Applies the inverse of the affine transformation represented by the
     * current matrix to the specified vector. The vector is modified in
     * place.
     *
     * If ignoreTranslation is true, then the transformation is performed as
     * if the tx and ty properties of the matrix were both zero. */
    public function invertTransform(point:Vector2d, ignoreTranslation = false) {
        var x = point.x;
        var y = point.y;

        var determinant = this.determinant();
        var inverseDeterminant = 1/determinant;

        var a = this.a;
        var b = this.b;
        var c = this.c;
        var d = this.d;
        var tx = this.tx;
        var ty = this.ty;

        a = d * inverseDeterminant;
        b = -b * inverseDeterminant;
        c = -c * inverseDeterminant;
        d = a * inverseDeterminant;
        tx = ((c * ty) - (d * tx)) * inverseDeterminant;
        ty = ((b * tx) - (a * ty)) * inverseDeterminant;

        point.x = a * x + c * y + tx;
        point.y = b * x + d * y + ty;
    }

    /** Copies the values of the source matrix to the current matrix. */
    public function copyFrom(source:Matrix23) {
        a = source.a;
        b = source.b;
        c = source.c;
        d = source.d;
        tx = source.tx;
        ty = source.ty;
    }

    /** Constructs a new matrix with the same values as the current
     * matrix. */
    public function clone() {
        return new Matrix23(a, b, c, d, tx, ty);
    }
}
