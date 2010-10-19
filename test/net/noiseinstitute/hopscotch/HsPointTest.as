package net.noiseinstitute.hopscotch {
	import org.flexunit.Assert;
	
	public class HsPointTest {		
		
		private var p1 :HsPoint;
		private var p2 :HsPoint;
		
		[Before]
		public function setup () :void {
			p1 = new HsPoint();
			p2 = new HsPoint();
		}
		
		[Test]
		public function testConstructor () :void {
			p1 = new HsPoint();
			Assert.assertEquals(0, p1.x);
			Assert.assertEquals(0, p1.y);
			
			p1 = new HsPoint(6);
			Assert.assertEquals(6, p1.x);
			Assert.assertEquals(0, p1.y);
			
			p1 = new HsPoint(6, -5);
			Assert.assertEquals(6, p1.x);
			Assert.assertEquals(-5, p1.y);
		}
		
		[Test]
		public function testAdd () :void {
			p1.x = 2;
			p1.y = 3;
			
			p2 = p1.add(new HsPoint(-1, 4));
			Assert.assertEquals(2, p1.x);
			Assert.assertEquals(3, p1.y);
			Assert.assertEquals(1, p2.x);
			Assert.assertEquals(7, p2.y);
		}
		
		[Test]
		public function testAddInPlace () :void {
			p1.x = 2;
			p1.y = 3;
			
			p1.addInPlace(new HsPoint(-1, 4));
			Assert.assertEquals(1, p1.x);
			Assert.assertEquals(7, p1.y);
		}
		
		[Test]
		public function testCross () :void {
			p1.x = 2;
			p1.y = 3;
			
			var n:Number = p1.cross(new HsPoint(4, -5));
			Assert.assertEquals(-22, n);
		}
		
		[Test]
		public function testDistance () :void {
			p1.x = 2;
			p1.y = 3;
			
			var n:Number = p1.distance(new HsPoint(4, -5));
			Assert.assertEquals(Math.sqrt(68), n);
		}
		
		[Test]
		public function testDot () :void {
			p1.x = 2;
			p1.y = 3;
			
			var n:Number = p1.dot(new HsPoint(4, -5));
			Assert.assertEquals(-7, n);
		}
		
		[Test]
		public function testMagnitude () :void {
			p1.x = 2;
			p1.y = 3;
			
			var n:Number = p1.magnitude();
			Assert.assertEquals(Math.sqrt(13), n);
		}
		
		[Test]
		public function testMultiply () :void {
			p1.x = 2;
			p1.y = 3;
			
			p2 = p1.multiply(4);
			Assert.assertEquals(2, p1.x);
			Assert.assertEquals(3, p1.y);
			Assert.assertEquals(8, p2.x);
			Assert.assertEquals(12, p2.y);
		}
		
		[Test]
		public function testMultiplyInPlace () :void {
			p1.x = 2;
			p1.y = 3;
			
			p1.multiplyInPlace(4);
			Assert.assertEquals(8, p1.x);
			Assert.assertEquals(12, p1.y);
		}
		
		[Test]
		public function testNegate () :void {
			p1.x = 2;
			p1.y = 3;
			
			p2 = p1.negate();
			Assert.assertEquals(2, p1.x);
			Assert.assertEquals(3, p1.y);
			Assert.assertEquals(-2, p2.x);
			Assert.assertEquals(-3, p2.y);
		}
		
		[Test]
		public function testNegateInPlace () :void {
			p1.x = 2;
			p1.y = 3;
			
			p1.negateInPlace();
			Assert.assertEquals(-2, p1.x);
			Assert.assertEquals(-3, p1.y);
		}
		
		[Test]
		public function testNormalize () :void {
			p1.x = 2;
			p1.y = 3;
			
			p2 = p1.normalize();
			Assert.assertEquals(2, p1.x);
			Assert.assertEquals(3, p1.y);
			Assert.assertEquals(2/Math.sqrt(13), p2.x);
			Assert.assertEquals(3/Math.sqrt(13), p2.y);
		}
		
		[Test]
		public function testNormalizeInPlace () :void {
			p1.x = 2;
			p1.y = 3;
			
			p1.normalizeInPlace();
			Assert.assertEquals(2/Math.sqrt(13), p1.x);
			Assert.assertEquals(3/Math.sqrt(13), p1.y);
		}
		
		[Test]
		public function testSubtract():void {
			p1.x = 2;
			p1.y = 3;
			
			p2 = p1.subtract(new HsPoint(4, -5));
			Assert.assertEquals(2, p1.x);
			Assert.assertEquals(3, p1.y);
			Assert.assertEquals(-2, p2.x);
			Assert.assertEquals(8, p2.y);
		}
		
		[Test]
		public function testSubtractInPlace () :void {
			p1.x = 2;
			p1.y = 3;
			
			p1.subtractInPlace(new HsPoint(4, -5));
			Assert.assertEquals(-2, p1.x);
			Assert.assertEquals(8, p1.y);
		}
		
		[Test]
		[Test]
		public function testUnitVector () :void {
			// Up
			p1 = HsPoint.unitVector(0); 
			Assert.assertEquals(0, p1.x);
			Assert.assertEquals(-1, p1.y);
			
			// Up-right
			p1 = HsPoint.unitVector(Math.PI/4);
			Assert.assertEquals(Math.sin(Math.PI/4), p1.x);
			Assert.assertEquals(-Math.cos(Math.PI/4), p1.y);
			Assert.assertTrue(p1.x > 0);
			Assert.assertTrue(p1.y < 0);
			
			// Right
			p1 = HsPoint.unitVector(Math.PI/2);
			Assert.assertEquals(1, p1.x);
			Assert.assertTrue(Math.abs(p1.y) < 1e-15); // approximately zero, due to rounding errors.
			
			// Down-right
			p1 = HsPoint.unitVector(3*Math.PI/4);
			Assert.assertEquals(Math.sin(3*Math.PI/4), p1.x);
			Assert.assertEquals(-Math.cos(3*Math.PI/4), p1.y);
			Assert.assertTrue(p1.x > 0);
			Assert.assertTrue(p1.y > 0);
			
			// Down
			p1 = HsPoint.unitVector(Math.PI);
			Assert.assertTrue(Math.abs(p1.x) < 1e-15); // approximately zero, due to rounding errors.
			Assert.assertEquals(1, p1.y);
			
			// Down-left
			p1 = HsPoint.unitVector(5*Math.PI/4);
			Assert.assertEquals(Math.sin(5*Math.PI/4), p1.x);
			Assert.assertEquals(-Math.cos(5*Math.PI/4), p1.y);
			Assert.assertTrue(p1.x < 0);
			Assert.assertTrue(p1.y > 0);
			
			// Left
			p1 = HsPoint.unitVector(3*Math.PI/2);
			Assert.assertEquals(-1, p1.x);
			Assert.assertTrue(Math.abs(p1.y) < 1e-15); // approximately zero, due to rounding errors.
			
			// Up-left
			p1 = HsPoint.unitVector(7*Math.PI/4);
			Assert.assertEquals(Math.sin(7*Math.PI/4), p1.x);
			Assert.assertEquals(-Math.cos(7*Math.PI/4), p1.y);
			Assert.assertTrue(p1.x < 0);
			Assert.assertTrue(p1.y < 0);
		}
	}
}