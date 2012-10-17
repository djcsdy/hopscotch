#if flash

package hopscotch.platform.flash.drawing;

import flash.geom.Matrix;
import hopscotch.geometry.Matrix23;
import flash.display.Sprite;
import flash.display.BitmapData;
import hopscotch.drawing.DrawingContext2d;

class BitmapDataDrawingContext2d implements DrawingContext2d {
    var bitmapData:BitmapData;
    var sprite:Sprite;
    var matrix:Matrix;
    var matrix2:Matrix;

    public function new(bitmapData:BitmapData) {
        this.bitmapData = bitmapData;
        sprite = new Sprite();
        matrix = new Matrix();
        matrix2 = new Matrix();
    }

    public function scale(sx:Float, sy:Float) {
        matrix.scale(sx, sy);
    }

    public function rotate(radians:Float) {
        matrix.rotate(radians);
    }

    public function translate(tx:Float, ty:Float) {
        matrix.translate(tx, ty);
    }

    public function transform(matrix:Matrix23) {
        matrix2.a = matrix.a;
        matrix2.b = matrix.b;
        matrix2.c = matrix.c;
        matrix2.d = matrix.d;
        matrix2.tx = matrix.tx;
        matrix2.ty = matrix.ty;

        this.matrix.concat(matrix2);
    }

    public function getTransform(matrix:Matrix23) {
        matrix.a = this.matrix.a;
        matrix.b = this.matrix.b;
        matrix.c = this.matrix.c;
        matrix.d = this.matrix.d;
        matrix.tx = this.matrix.tx;
        matrix.ty = this.matrix.ty;
    }

    public function setTransform(matrix:Matrix23) {
        this.matrix.a = matrix.a;
        this.matrix.b = matrix.b;
        this.matrix.c = matrix.c;
        this.matrix.d = matrix.d;
        this.matrix.tx = matrix.tx;
        this.matrix.ty = matrix.ty;
    }

    public function resetTransform() {
        matrix.identity();
    }
}

#end