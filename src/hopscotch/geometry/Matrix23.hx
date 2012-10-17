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

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Matrix23. This reduces memory
    // consumption on some platforms.
    //
    /** Sets the properties of the matrix so that it is the identity matrix.
     *
     * The identity matrix can be thought of as an empty box that is ready to
     * store a sequence of transformations. The identity matrix is a matrix
     * that applies the null or identity affine transformation; an object that
     * is transformed by the identity matrix will be identical to the original.
     *
     * An identity matrix has the values a=1, b=0, c=0, d=1, tx=0, ty=0. */
    public inline function identity() {
        Matrix23.identity(this);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Matrix23. This reduces memory
    // consumption on some platforms.
    //
    /** Applies a scaling transformation to the matrix. The x-axis is scaled
     * by sx, and the y-axis is scaled by sy. */
    public inline function scale(sx:Float, sy:Float) {
        Matrix23.scale(this, sx, sy);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Matrix23. This reduces memory
    // consumption on some platforms.
    //
    /** Applies a rotation transformation to the matrix. The angle of rotation
     * is clockwise and is measured in radians. */
    public inline function rotate(radians:Float) {
        Matrix23.rotate(this, radians);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Matrix23. This reduces memory
    // consumption on some platforms.
    //
    /** Applies a translation transformation to the matrix. The translation is
     * tx units along the x-axis, and ty pixels along the y-axis. */
    public inline function translate(tx:Float, ty:Float) {
        Matrix23.translate(this, tx, ty);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Matrix23. This reduces memory
    // consumption on some platforms.
    //
    /** Computes the determinant of the matrix.
     *
     * The determinant gives the proportional change in area of a shape that is
     * transformed by the affine transformation represented by matrix.
     *
     * If the determinant is zero, then the matrix is a singular matrix, meaning
     * that it transforms every shape into a single point. */
    public inline function determinant() {
        return Matrix23.determinant(this);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Matrix23. This reduces memory
    // consumption on some platforms.
    //
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
    public inline function invert() {
        Matrix23.invert(this);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Matrix23. This reduces memory
    // consumption on some platforms.
    //
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
    public inline function concat(matrix:Matrix23) {
        Matrix23.concat(this, matrix);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Matrix23. This reduces memory
    // consumption on some platforms.
    //
    /** Applies the affine transformation represented by the current matrix
    * to the specified vector. The vector is modified in place. */
    public inline function transform(point:Vector2d) {
        Matrix23.transform(point, this);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Matrix23. This reduces memory
    // consumption on some platforms.
    //
    /** Applies the inverse of the affine transformation represented by the
     * current matrix to the specified vector. The vector is modified in
     * place. */
    public inline function invertTransform(point:Vector2d) {
        Matrix23.invertTransform(point, this);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Matrix23. This reduces memory
    // consumption on some platforms.
    //
    /** Copies the values of the source matrix to the current matrix. */
    public inline function copyFrom(source:Matrix23) {
        Matrix23.copyTo(this, source);
    }

    // This function is defined as a more convenient way to call the equivalent
    // static function. It is declared inline so that it will not create an
    // extra property on every instance of Matrix23. This reduces memory
    // consumption on some platforms.
    //
    /** Constructs a new matrix with the same values as the current
     * matrix. */
    public inline function clone() {
        return Matrix23.clone(this);
    }

    /** Sets the properties of the specified matrix so that it is the identity
     * matrix.
     *
     * The identity matrix can be thought of as an empty box that is ready to
     * store a sequence of transformations. The identity matrix is a matrix
     * that applies the null or identity affine transformation; an object that
     * is transformed by the identity matrix will be identical to the original.
     *
     * An identity matrix has the values a=1, b=0, c=0, d=1, tx=0, ty=0. */
    public static function identity(matrix:Matrix23) {
        matrix.a = matrix.d = 1;
        matrix.b = matrix.c = matrix.tx = matrix.ty = 0;
    }

    /** Applies a scaling transformation to the specified matrix. The x-axis is
     * scaled by sx, and the y-axis is scaled by sy. */
    public static function scale(matrix:Matrix23, sx:Float, sy:Float) {
        matrix.a *= sx;
        matrix.b *= sy;
        matrix.c *= sx;
        matrix.d *= sy;
        matrix.tx *= sx;
        matrix.ty *= sy;
    }

    /** Applies a rotation transformation to the specified matrix. The angle of
     * rotation is clockwise and is measured in radians. */
    public static function rotate(matrix:Matrix23, radians:Float) {
        var cos = Math.cos(radians);
        var sin = Math.sin(radians);

        var a = matrix.a;
        var b = matrix.b;
        var c = matrix.c;
        var d = matrix.d;
        var tx = matrix.tx;
        var ty = matrix.ty;

        matrix.a = cos * a + -sin * b;
        matrix.b = sin * a + cos * b;
        matrix.c = cos * c + -sin * d;
        matrix.d = sin * c + cos * d;
        matrix.tx = cos * tx + -sin * ty;
        matrix.ty = sin * tx + cos * ty;
    }

    /** Applies a translation transformation to the specified matrix. The
     * translation is tx units along the x-axis, and ty pixels along the
     * y-axis. */
    public static function translate(matrix:Matrix23, tx:Float, ty:Float) {
        matrix.tx += tx;
        matrix.ty += ty;
    }

    /** Computes the determinant of the specified matrix.
     *
     * The determinant gives the proportional change in area of a shape that is
     * transformed by the affine transformation represented by matrix.
     *
     * If the determinant is zero, then the matrix is a singular matrix, meaning
     * that it transforms every shape into a single point. */
    public static inline function determinant(matrix:Matrix23) {
        return a * d - b * c;
    }

    /** Inverts the specified matrix.
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
    public static function invert(matrix:Matrix23) {
        var determinant = Matrix23.determinant(matrix);
        var inverseDeterminant = 1/determinant;

        var a = matrix.a;
        var b = matrix.b;
        var c = matrix.c;
        var d = matrix.d;
        var tx = matrix.tx;
        var ty = matrix.ty;

        matrix.a = d * inverseDeterminant;
        matrix.b = -b * inverseDeterminant;
        matrix.c = -c * inverseDeterminant;
        matrix.d = a * inverseDeterminant;
        matrix.tx = ((c * ty) - (d * tx)) * inverseDeterminant;
        matrix.ty = ((b * tx) - (a * ty)) * inverseDeterminant;
    }

    /** Concatenates two matrices. The first matrix is replaced by the
     * concatenated matrix.
     *
     * This effectively combines the affine transformations represented by the
     * two matrices. For example, if the first matrix represents a
     * transformation that scales an object by four times, and the second
     * matrix represents a transformation that rotates an object by pi radians
     * (a half-turn), then the combined matrix will represent a transformation
     * that is equivalent to scaling an object by four times and then rotating
     * it by pi radians.
     *
     * In mathematical terms this operation is equivalent to matrix
     * multiplication. */
    public static function concat(matrix1:Matrix23, matrix2:Matrix23) {
        var a = matrix1.a;
        var b = matrix1.b;
        var c = matrix1.c;
        var d = matrix1.d;
        var tx = matrix1.tx;
        var ty = matrix1.ty;

        matrix1.a = matrix2.a * a + matrix2.c * b;
        matrix1.b = matrix2.b * a + matrix2.d * b;
        matrix1.c = matrix2.a * c + matrix2.c * d;
        matrix1.d = matrix2.b * c + matrix2.d * d;
        matrix1.tx = matrix2.a * tx + matrix2.c * ty + matrix2.tx;
        matrix1.ty = matrix2.b * tx + matrix2.d * ty + matrix2.ty;
    }

    /** Applies the affine transformation represented by the specified matrix
    * to the specified vector. The vector is modified in place. */
    public static function transform(point:Vector2d, matrix:Matrix23) {
        var x = point.x;
        var y = point.y;

        point.x = matrix.a * x + matrix.c * y + matrix.tx;
        point.y = matrix.b * x + matrix.d * y + matrix.ty;
    }

    /** Applies the inverse of the affine transformation represented by the
     * specified matrix to the specified vector. The vector is modified in
     * place. */
    public static function invertTransform(point:Vector2d, matrix:Matrix23) {
        var x = point.x;
        var y = point.y;

        var determinant = Matrix23.determinant(matrix);
        var inverseDeterminant = 1/determinant;

        var a = matrix.a;
        var b = matrix.b;
        var c = matrix.c;
        var d = matrix.d;
        var tx = matrix.tx;
        var ty = matrix.ty;

        a = d * inverseDeterminant;
        b = -b * inverseDeterminant;
        c = -c * inverseDeterminant;
        d = a * inverseDeterminant;
        tx = ((c * ty) - (d * tx)) * inverseDeterminant;
        ty = ((b * tx) - (a * ty)) * inverseDeterminant;

        point.x = a * x + c * y + tx;
        point.y = b * x + d * y + ty;
    }

    /** Copies the values of the source matrix to the destination matrix. */
    public static function copyTo(dest:Matrix23, source:Matrix23) {
        dest.a = source.a;
        dest.b = source.b;
        dest.c = source.c;
        dest.d = source.d;
        dest.tx = source.tx;
        dest.ty = source.ty;
    }

    /** Constructs a new matrix with the same values as the specified
     * matrix. */
    public static inline function clone(matrix:Matrix23) {
        return new Matrix23(matrix.a, matrix.b, matrix.c, matrix.d, matrix.tx, matrix.ty);
    }
}
