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
}
