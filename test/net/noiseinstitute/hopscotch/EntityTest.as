package net.noiseinstitute.hopscotch {
	import net.noiseinstitute.hopscotch.test.TestCaseWithMocks;
	
	import org.flexunit.Assert;
	
	public class EntityTest extends TestCaseWithMocks {
		
		private var entity :Entity;
		
		public function EntityTest () {
			super();
		}
		
		[Before]
		public function setup () :void {
			entity = new Entity();
		}
		
		[Test]
		public function testDefaultValues () :void {
			Assert.assertEquals(0, entity.position.x);
			Assert.assertEquals(0, entity.position.y);
			Assert.assertEquals(0, entity.velocity.x);
			Assert.assertEquals(0, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(0, entity.acceleration.y);
		}
		
		[Test]
		public function testUpdate () :void {
			entity.update();
			Assert.assertEquals(0, entity.position.x);
			Assert.assertEquals(0, entity.position.y);
			Assert.assertEquals(0, entity.velocity.x);
			Assert.assertEquals(0, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(0, entity.acceleration.y);
			
			entity.velocity.x = 5;
			entity.update();
			Assert.assertEquals(5, entity.position.x);
			Assert.assertEquals(0, entity.position.y);
			Assert.assertEquals(5, entity.velocity.x);
			Assert.assertEquals(0, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(0, entity.acceleration.y);
			
			entity.acceleration.y = -5;
			entity.update();
			Assert.assertEquals(10, entity.position.x);
			Assert.assertEquals(-5, entity.position.y);
			Assert.assertEquals(5, entity.velocity.x);
			Assert.assertEquals(-5, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(-5, entity.acceleration.y);
			
			entity.acceleration.x = 1;
			entity.update();
			Assert.assertEquals(16, entity.position.x);
			Assert.assertEquals(-15, entity.position.y);
			Assert.assertEquals(6, entity.velocity.x);
			Assert.assertEquals(-10, entity.velocity.y);
			Assert.assertEquals(1, entity.acceleration.x);
			Assert.assertEquals(-5, entity.acceleration.y);
			
			entity.acceleration.x = 0;
			entity.acceleration.y = 0;
			entity.update();
			Assert.assertEquals(22, entity.position.x);
			Assert.assertEquals(-25, entity.position.y);
			Assert.assertEquals(6, entity.velocity.x);
			Assert.assertEquals(-10, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(0, entity.acceleration.y);
		}
		
		[Test]
		public function testX () :void {
			Assert.assertEquals(0, entity.position.x);
			Assert.assertEquals(0, entity.x);
			
			entity.position.x = 5;
			Assert.assertEquals(5, entity.position.x);
			Assert.assertEquals(5, entity.x);
			
			entity.x = -2;
			Assert.assertEquals(-2, entity.position.x);
			Assert.assertEquals(-2, entity.x);
		}
		
		[Test]
		public function testY () :void {
			Assert.assertEquals(0, entity.position.y);
			Assert.assertEquals(0, entity.y);
			
			entity.position.y = 5;
			Assert.assertEquals(5, entity.position.y);
			Assert.assertEquals(5, entity.y);
			
			entity.y = -2;
			Assert.assertEquals(-2, entity.position.y);
			Assert.assertEquals(-2, entity.y);
		}
		
	}
	
}