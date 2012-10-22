package hopscotch;

import flash.geom.Matrix;
import hopscotch.geometry.Matrix23;
import flash.geom.Point;
import hopscotch.geometry.Vector2d;
import flash.geom.Rectangle;
import flash.geom.ColorTransform;

class Static {
    public static var origin = new Vector2d();
    public static var vector2d = new Vector2d();
    public static var vector2db = new Vector2d();

    public static var originPoint = new Point();
    public static var point = new Point();
    public static var point2 = new Point();

    public static var rect = new Rectangle();
    public static var rect2 = new Rectangle();

    public static var identity = new Matrix23();
    public static var matrix = new Matrix23();

    public static var identityFlash = new Matrix();
    public static var matrixFlash = new Matrix();

    public static var colorTransform = new ColorTransform();
}
