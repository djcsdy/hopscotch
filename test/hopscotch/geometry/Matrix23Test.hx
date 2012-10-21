package hopscotch.geometry;

import hopscotch.test.TestCase;

class Matrix23Test extends TestCase {
    public function new() {
        super();
    }

    public function testIdentity() {
        var m = new Matrix23(2, 3, 4, 5, 6, 7);

        m.identity();

        assertEquals(1.0, m.a);
        assertEquals(0.0, m.b);
        assertEquals(0.0, m.c);
        assertEquals(1.0, m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);
    }

    public function testScale() {
        var m = new Matrix23(2, 3, 4, 5, 6, 7);

        m.scale(2, 0.5);

        assertEquals(4.0, m.a);
        assertEquals(1.5, m.b);
        assertEquals(8.0, m.c);
        assertEquals(2.5, m.d);
        assertEquals(12.0, m.tx);
        assertEquals(3.5, m.ty);
    }

    public function testRotate() {
        var m = new Matrix23();

        m.rotate(0);

        assertEquals(1.0, m.a);
        assertEquals(0.0, m.b);
        assertEquals(0.0, m.c);
        assertEquals(1.0, m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m.rotate(Math.PI / 4);

        assertApproxEquals(Math.sqrt(0.5), m.a);
        assertApproxEquals(Math.sqrt(0.5), m.b);
        assertApproxEquals(-Math.sqrt(0.5), m.c);
        assertApproxEquals(Math.sqrt(0.5), m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23();
        m.rotate(Math.PI / 2);

        assertApproxEquals(0.0, m.a);
        assertEquals(1.0, m.b);
        assertEquals(-1.0, m.c);
        assertApproxEquals(0.0, m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23();
        m.rotate(3 * Math.PI / 4);

        assertApproxEquals(-Math.sqrt(0.5), m.a);
        assertApproxEquals(Math.sqrt(0.5), m.b);
        assertApproxEquals(-Math.sqrt(0.5), m.c);
        assertApproxEquals(-Math.sqrt(0.5), m.d);
        assertApproxEquals(0.0, m.tx);
        assertApproxEquals(0.0, m.ty);

        m = new Matrix23();
        m.rotate(Math.PI);

        assertEquals(-1.0, m.a);
        assertApproxEquals(0.0, m.b);
        assertApproxEquals(0.0, m.c);
        assertEquals(-1.0, m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23();
        m.rotate(5 * Math.PI / 4);

        assertApproxEquals(-Math.sqrt(0.5), m.a);
        assertApproxEquals(-Math.sqrt(0.5), m.b);
        assertApproxEquals(Math.sqrt(0.5), m.c);
        assertApproxEquals(-Math.sqrt(0.5), m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23();
        m.rotate(3 * Math.PI / 2);

        assertApproxEquals(0.0, m.a);
        assertEquals(-1.0, m.b);
        assertEquals(1.0, m.c);
        assertApproxEquals(0.0, m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23();
        m.rotate(7 * Math.PI / 4);

        assertApproxEquals(Math.sqrt(0.5), m.a);
        assertApproxEquals(-Math.sqrt(0.5), m.b);
        assertApproxEquals(Math.sqrt(0.5), m.c);
        assertApproxEquals(Math.sqrt(0.5), m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23(1, 0, 0, 1, 5, -3);
        m.rotate(Math.PI / 4);

        assertApproxEquals(Math.sqrt(0.5), m.a);
        assertApproxEquals(Math.sqrt(0.5), m.b);
        assertApproxEquals(-Math.sqrt(0.5), m.c);
        assertApproxEquals(Math.sqrt(0.5), m.d);
        assertApproxEquals(8 * Math.sqrt(0.5), m.tx);
        assertApproxEquals(2 * Math.sqrt(0.5), m.ty);

        m = new Matrix23(1, 0, 0, 1, 4, 9);
        m.rotate(5 * Math.PI / 8);

        assertApproxEquals(-Math.sin(Math.PI / 8), m.a);
        assertApproxEquals(Math.cos(Math.PI / 8), m.b);
        assertApproxEquals(-Math.cos(Math.PI / 8), m.c);
        assertApproxEquals(-Math.sin(Math.PI / 8), m.d);
        assertApproxEquals(4 * -Math.sin(Math.PI / 8) + 9 * -Math.cos(Math.PI / 8), m.tx);
        assertApproxEquals(4 * Math.cos(Math.PI / 8) + 9 * -Math.sin(Math.PI / 8), m.ty);

        m = new Matrix23(2, 3, 4, 5, 6, 7);
        m.rotate(Math.PI / 4);

        assertApproxEquals(-Math.sqrt(0.5), m.a);
        assertApproxEquals(5 * Math.sqrt(0.5), m.b);
        assertApproxEquals(-Math.sqrt(0.5), m.c);
        assertApproxEquals(9 * Math.sqrt(0.5), m.d);
        assertApproxEquals(-Math.sqrt(0.5), m.tx);
        assertApproxEquals(13 * Math.sqrt(0.5), m.ty);

        m = new Matrix23(2, 3, 4, 5, 6, 7);
        m.rotate(9 * Math.PI / 8);

        assertApproxEquals(-Math.cos(Math.PI / 8) * 2 + Math.sin(Math.PI / 8) * 3, m.a);
        assertApproxEquals(-Math.sin(Math.PI / 8) * 2 - Math.cos(Math.PI / 8) * 3, m.b);
        assertApproxEquals(-Math.cos(Math.PI / 8) * 4 + Math.sin(Math.PI / 8) * 5, m.c);
        assertApproxEquals(-Math.sin(Math.PI / 8) * 4 - Math.cos(Math.PI / 8) * 5, m.d);
        assertApproxEquals(-Math.cos(Math.PI / 8) * 6 + Math.sin(Math.PI / 8) * 7, m.tx);
        assertApproxEquals(-Math.sin(Math.PI / 8) * 6 - Math.cos(Math.PI / 8) * 7, m.ty);
    }

    public function testTranslate() {
        var m = new Matrix23();
        m.translate(7, 2);

        assertEquals(1.0, m.a);
        assertEquals(0.0, m.b);
        assertEquals(0.0, m.c);
        assertEquals(1.0, m.d);
        assertEquals(7.0, m.tx);
        assertEquals(2.0, m.ty);

        m = new Matrix23(2, 3, 4, 5, 6, 7);
        m.translate(7, 2);

        assertEquals(2.0, m.a);
        assertEquals(3.0, m.b);
        assertEquals(4.0, m.c);
        assertEquals(5.0, m.d);
        assertEquals(13.0, m.tx);
        assertEquals(9.0, m.ty);
    }

    public function testDeterminant() {
        var m = new Matrix23();
        assertEquals(1.0, m.determinant());

        m = new Matrix23(2, 3, 4, 5, 6, 7);
        assertEquals(-2.0, m.determinant());
    }

    public function testInvert() {
        var m = new Matrix23();
        m.invert();

        assertEquals(1.0, m.a);
        assertEquals(0.0, m.b);
        assertEquals(0.0, m.c);
        assertEquals(1.0, m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23(1, 0, 0, 1, 5, 10);
        m.invert();

        assertEquals(1.0, m.a);
        assertEquals(0.0, m.b);
        assertEquals(0.0, m.c);
        assertEquals(1.0, m.d);
        assertEquals(-5.0, m.tx);
        assertEquals(-10.0, m.ty);

        m = new Matrix23(2, 3, 4, 5, 6, 7);
        m.invert();

        assertEquals(-2.5, m.a);
        assertEquals(1.5, m.b);
        assertEquals(2.0, m.c);
        assertEquals(-1.0, m.d);
        assertEquals(1.0, m.tx);
        assertEquals(-2.0, m.ty);

        m = new Matrix23();
        m.translate(4, -1);
        m.rotate(3 * Math.PI / 8);
        m.scale(8, -2);
        m.translate(-7, 3);

        var n = new Matrix23();
        n.translate(7, -3);
        n.scale(1/8, -1/2);
        n.rotate(-3 * Math.PI / 8);
        n.translate(-4, 1);

        m.invert();

        assertApproxEquals(n.a, m.a);
        assertApproxEquals(n.b, m.b);
        assertApproxEquals(n.c, m.c);
        assertApproxEquals(n.d, m.d);
        assertApproxEquals(n.tx, m.tx);
        assertApproxEquals(n.ty, m.ty);
    }

    public function testConcat() {
        var m = new Matrix23();
        var n = new Matrix23();

        m.concat(n);

        assertEquals(1.0, m.a);
        assertEquals(0.0, m.b);
        assertEquals(0.0, m.c);
        assertEquals(1.0, m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23();
        n = new Matrix23(2, 3, 4, 5, 6, 7);

        m.concat(n);

        assertEquals(2.0, m.a);
        assertEquals(3.0, m.b);
        assertEquals(4.0, m.c);
        assertEquals(5.0, m.d);
        assertEquals(6.0, m.tx);
        assertEquals(7.0, m.ty);

        m = new Matrix23(2, 3, 4, 5, 6, 7);
        n = new Matrix23(6, 8, 2, -3, 4, -9);

        m.concat(n);

        assertEquals(18.0, m.a);
        assertEquals(7.0, m.b);
        assertEquals(34.0, m.c);
        assertEquals(17.0, m.d);
        assertEquals(54.0, m.tx);
        assertEquals(18.0, m.ty);

        m = new Matrix23();
        m.translate(-3, 2);
        m.scale(6, 7);
        m.rotate(7 * Math.PI / 8);

        n = new Matrix23();
        m.scale(0.5, 3);
        m.translate(7, 2);

        var o = new Matrix23();
        o.translate(-3, 2);
        o.scale(6, 7);
        o.rotate(7 * Math.PI / 8);
        o.scale(0.5, 3);
        o.translate(7, 2);

        m.concat(n);

        assertApproxEquals(o.a, m.a);
        assertApproxEquals(o.b, m.b);
        assertApproxEquals(o.c, m.c);
        assertApproxEquals(o.d, m.d);
        assertApproxEquals(o.tx, m.tx);
        assertApproxEquals(o.ty, m.ty);

        m = new Matrix23(2, 3, 4, 5, 6, 7);

        m.concat(m);

        assertEquals(16.0, m.a);
        assertEquals(21.0, m.b);
        assertEquals(28.0, m.c);
        assertEquals(37.0, m.d);
        assertEquals(46.0, m.tx);
        assertEquals(60.0, m.ty);
    }

    public function testTransform() {
        var m = new Matrix23();
        var v = new Vector2d(1, 2);

        m.transform(v);

        assertEquals(1.0, v.x);
        assertEquals(2.0, v.y);

        m = new Matrix23(2, 3, 4, 5, 6, 7);
        v = new Vector2d(1, 2);

        m.transform(v);

        assertEquals(16.0, v.x);
        assertEquals(20.0, v.y);

        m = new Matrix23();
        m.translate(4, -1);
        m.rotate(Math.PI / 8);
        m.scale(2, 0.5);

        v = new Vector2d(1, 2);

        m.transform(v);

        assertApproxEquals(Math.cos(Math.PI / 8) * 10 - Math.sin(Math.PI / 8) * 2, v.x);
        assertApproxEquals(Math.cos(Math.PI / 8) * 0.5 + Math.sin(Math.PI / 8) * 2.5, v.y);
    }

    public function testInvertTransform() {
        var m = new Matrix23();
        var v = new Vector2d(1, 2);

        m.invertTransform(v);

        assertEquals(1.0, v.x);
        assertEquals(2.0, v.y);

        m = new Matrix23(2, 3, 4, 5, 6, 7);
        v = new Vector2d(1, 2);

        m.invertTransform(v);

        assertEquals(2.5, v.x);
        assertEquals(-2.5, v.y);

        m = new Matrix23();
        m.translate(4, -1);
        m.rotate(Math.PI / 8);
        m.scale(2, 0.5);

        v = new Vector2d(Math.cos(Math.PI / 8) * 10 - Math.sin(Math.PI / 8) * 2,
                Math.cos(Math.PI / 8) * 0.5 + Math.sin(Math.PI / 8) * 2.5);

        m.invertTransform(v);

        assertApproxEquals(1.0, v.x);
        assertApproxEquals(2.0, v.y);
    }

    public function testCopyFrom() {
        var m = new Matrix23();
        var n = new Matrix23(2, 3, 4, 5, 6, 7);

        m.copyFrom(n);

        assertEquals(2.0, m.a);
        assertEquals(3.0, m.b);
        assertEquals(4.0, m.c);
        assertEquals(5.0, m.d);
        assertEquals(6.0, m.tx);
        assertEquals(7.0, m.ty);
    }

    public function testClone() {
        var m = new Matrix23(4, 5, 6, 7, 8, 9);

        var n = m.clone();

        assertFalse(m == n);
        assertEquals(4.0, n.a);
        assertEquals(5.0, n.b);
        assertEquals(6.0, n.c);
        assertEquals(7.0, n.d);
        assertEquals(8.0, n.tx);
        assertEquals(9.0, n.ty);
    }
}
