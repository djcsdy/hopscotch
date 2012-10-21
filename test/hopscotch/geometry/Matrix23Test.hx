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
        assertApproxEquals(-Math.sqrt(0.5), m.b);
        assertApproxEquals(Math.sqrt(0.5), m.c);
        assertApproxEquals(Math.sqrt(0.5), m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23();
        m.rotate(Math.PI / 2);

        assertApproxEquals(0.0, m.a);
        assertEquals(-1.0, m.b);
        assertEquals(1.0, m.c);
        assertApproxEquals(0.0, m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23();
        m.rotate(3 * Math.PI / 4);

        assertApproxEquals(-Math.sqrt(0.5), m.a);
        assertApproxEquals(-Math.sqrt(0.5), m.b);
        assertApproxEquals(Math.sqrt(0.5), m.c);
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
        assertApproxEquals(Math.sqrt(0.5), m.b);
        assertApproxEquals(-Math.sqrt(0.5), m.c);
        assertApproxEquals(-Math.sqrt(0.5), m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23();
        m.rotate(3 * Math.PI / 2);

        assertApproxEquals(0.0, m.a);
        assertEquals(1.0, m.b);
        assertEquals(-1.0, m.c);
        assertApproxEquals(0.0, m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23();
        m.rotate(7 * Math.PI / 4);

        assertApproxEquals(Math.sqrt(0.5), m.a);
        assertApproxEquals(Math.sqrt(0.5), m.b);
        assertApproxEquals(-Math.sqrt(0.5), m.c);
        assertApproxEquals(Math.sqrt(0.5), m.d);
        assertEquals(0.0, m.tx);
        assertEquals(0.0, m.ty);

        m = new Matrix23(1, 0, 0, 1, 5, -3);
        m.rotate(Math.PI / 4);

        assertApproxEquals(Math.sqrt(0.5), m.a);
        assertApproxEquals(-Math.sqrt(0.5), m.b);
        assertApproxEquals(Math.sqrt(0.5), m.c);
        assertApproxEquals(Math.sqrt(0.5), m.d);
        assertApproxEquals(8 * Math.sqrt(0.5), m.tx);
        assertApproxEquals(2 * Math.sqrt(0.5), m.ty);

        m = new Matrix23(2, 3, 4, 5, 6, 7);
        m.rotate(Math.PI / 4);

        assertApproxEquals(5 * Math.sqrt(0.5), m.a);
        assertApproxEquals(Math.sqrt(0.5), m.b);
        assertApproxEquals(9 * Math.sqrt(0.5), m.c);
        assertApproxEquals(Math.sqrt(0.5), m.d);
        assertApproxEquals(-Math.sqrt(0.5), m.tx);
        assertApproxEquals(13 * Math.sqrt(0.5), m.ty);
    }
}
