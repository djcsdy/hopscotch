package hopscotch.geometry;

/** A 2-row, 3-column matrix, used to represent an affine transformation in 2D.
 *
 * It is not necessary to understand matrix mathematics to use this class. You
 * can think of a matrix as simply being a box that efficiently stores a
 * sequence of 2D geometric transformations (translation, rotation and
 * scaling), which you can then apply to a point or other geometry in a single
 * step.
 *
 * The matrix values are arranged in the following orientation.
 *
 * <table><tr><td>a</td><td>b</td><td>tx</td></tr>
 * <tr><td>c</td><td>d</td><td>ty</td></tr></table>
 *
 * When used as an affine transformation, the matrix has an implicit third row
 * with the values [0 0 1].
 *
 * <table><tr><td>a</td><td>b</td><td>tx</td></tr>
 * <tr><td>c</td><td>d</td><td>ty</td></tr>
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

    /** The value at coordinates (2,1) in the matrix. */
    public var b:Float;

    /** The value at coordinates (1,2) in the matrix. */
    public var c:Float;

    /** The value at coordinates (2,2) in the matrix. */
    public var d:Float;

    /** The value at coordinates (3,1) in the matrix. */
    public var tx:Float;

    /** The value at coordinates (3,2) in the matrix. */
    public var ty:Float;

    public function new(a=1.0, b=0.0, c=0.0, d=1.0, tx=0.0, ty=0.0) {
        this.a = a;
        this.b = b;
        this.c = c;
        this.d = d;
        this.tx = tx;
        this.ty = ty;
    }
}
