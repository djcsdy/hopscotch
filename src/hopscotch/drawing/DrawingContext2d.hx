package hopscotch.drawing;

import hopscotch.geometry.Matrix23;

/** API for drawing in 2D onto various types of surface.
 *
 * A DrawingContext2d has an internal transformation matrix that implicitly
 * transforms every drawing operation. The internal transformation matrix can
 * be modified by calling the scale, rotate, translate, transform, setTransform
 * and resetTransform methods, and can be retrieved using the getTransform
 * method.
 *
 * By default the internal transformation matrix is the identity matrix,
 * meaning that drawing operations are not transformed. */
interface DrawingContext2d {

    /** Applies a scaling transformation to the internal transformation matrix.
     * The x-axis is scaled by sx, and the y-axis is scaled by sy. */
    function scale(sx:Float, sy:Float):Void;

    /** Applies a rotation transformation to the internal transformation
     * matrix. The angle of rotation is clockwise and is measured in
     * radians. */
    function rotate(radians:Float):Void;

    /** Applies a translation transformation to the internal transformation
     * matrix. The translation is tx units along the x-axis, and ty pixels
     * along the y-axis. */
    function translate(tx:Float, ty:Float):Void;

    /** Concatenates a matrix with the internal transformation matrix. The
     * internal transformation matrix is replaced by the concatenated matrix.
     *
     * This effectively combines the affine transformations represented by the
     * two matrices. For example, if the internal transformation matrix
     * represents a transformation that scales an object by four times, and the
     * second matrix represents a transformation that rotates an object by pi
     * radians (a half-turn), then the combined matrix will represent a
     * transformation that is equivalent to scaling an object by four times and
     * then rotating it by pi radians.
     *
     * In mathematical terms this operation is equivalent to matrix
     * multiplication. */
    function transform(matrix:Matrix23):Void;

    /** Copies the values of the internal transformation matrix to the
     * specified matrix. */
    function getTransform(matrix:Matrix23):Void;

    /** Copies the values of the specified matrix to the internal
     * transformation matrix.*/
    function setTransform(matrix:Matrix23):Void;

    /** Resets the internal transformation matrix to the identity matrix. */
    function resetTransform():Void;
}
