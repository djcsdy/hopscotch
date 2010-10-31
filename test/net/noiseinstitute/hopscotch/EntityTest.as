package net.noiseinstitute.hopscotch {
	import org.flexunit.Assert;
	import net.noiseinstitute.hopscotch.update.ActionQueue;
	
	public class EntityTest {
		
		private var entity :Entity;
		private var deferredActions :ActionQueue;
		
		[Before]
		public function setup () :void {
			entity = new Entity();
			deferredActions = new ActionQueue();
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
			entity.update(deferredActions);
			deferredActions.execute();
			Assert.assertEquals(0, entity.position.x);
			Assert.assertEquals(0, entity.position.y);
			Assert.assertEquals(0, entity.velocity.x);
			Assert.assertEquals(0, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(0, entity.acceleration.y);
			
			entity.velocity.x = 5;
			entity.update(deferredActions);
			deferredActions.execute();
			Assert.assertEquals(5, entity.position.x);
			Assert.assertEquals(0, entity.position.y);
			Assert.assertEquals(5, entity.velocity.x);
			Assert.assertEquals(0, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(0, entity.acceleration.y);
			
			entity.acceleration.y = -5;
			entity.update(deferredActions);
			deferredActions.execute();
			Assert.assertEquals(10, entity.position.x);
			Assert.assertEquals(-5, entity.position.y);
			Assert.assertEquals(5, entity.velocity.x);
			Assert.assertEquals(-5, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(-5, entity.acceleration.y);
			
			entity.acceleration.x = 1;
			entity.update(deferredActions);
			deferredActions.execute();
			Assert.assertEquals(16, entity.position.x);
			Assert.assertEquals(-15, entity.position.y);
			Assert.assertEquals(6, entity.velocity.x);
			Assert.assertEquals(-10, entity.velocity.y);
			Assert.assertEquals(1, entity.acceleration.x);
			Assert.assertEquals(-5, entity.acceleration.y);
			
			entity.acceleration.x = 0;
			entity.acceleration.y = 0;
			entity.update(deferredActions);
			deferredActions.execute();
			Assert.assertEquals(22, entity.position.x);
			Assert.assertEquals(-25, entity.position.y);
			Assert.assertEquals(6, entity.velocity.x);
			Assert.assertEquals(-10, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(0, entity.acceleration.y);
		}
		
		[Test]
		public function testThatDefaultUpdateActionsAreCorrectlyDeferred () :void {
			entity.velocity.x = 5;
			entity.update(deferredActions);
			Assert.assertEquals(0, entity.position.x);
			Assert.assertEquals(0, entity.position.y);
			Assert.assertEquals(5, entity.velocity.x);
			Assert.assertEquals(0, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(0, entity.acceleration.y);
			
			deferredActions.execute();
			Assert.assertEquals(5, entity.position.x);
			Assert.assertEquals(0, entity.position.y);
			Assert.assertEquals(5, entity.velocity.x);
			Assert.assertEquals(0, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(0, entity.acceleration.y);
			
			entity.acceleration.y = -5;
			entity.update(deferredActions);
			Assert.assertEquals(5, entity.position.x);
			Assert.assertEquals(0, entity.position.y);
			Assert.assertEquals(5, entity.velocity.x);
			Assert.assertEquals(0, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(-5, entity.acceleration.y);
			
			deferredActions.execute();
			Assert.assertEquals(10, entity.position.x);
			Assert.assertEquals(-5, entity.position.y);
			Assert.assertEquals(5, entity.velocity.x);
			Assert.assertEquals(-5, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(-5, entity.acceleration.y);
			
			entity.acceleration.x = 1;
			entity.update(deferredActions);
			Assert.assertEquals(10, entity.position.x);
			Assert.assertEquals(-5, entity.position.y);
			Assert.assertEquals(5, entity.velocity.x);
			Assert.assertEquals(-5, entity.velocity.y);
			Assert.assertEquals(1, entity.acceleration.x);
			Assert.assertEquals(-5, entity.acceleration.y);
			
			deferredActions.execute();
			Assert.assertEquals(16, entity.position.x);
			Assert.assertEquals(-15, entity.position.y);
			Assert.assertEquals(6, entity.velocity.x);
			Assert.assertEquals(-10, entity.velocity.y);
			Assert.assertEquals(1, entity.acceleration.x);
			Assert.assertEquals(-5, entity.acceleration.y);
			
			entity.acceleration.x = 0;
			entity.acceleration.y = 0;
			entity.update(deferredActions);
			Assert.assertEquals(16, entity.position.x);
			Assert.assertEquals(-15, entity.position.y);
			Assert.assertEquals(6, entity.velocity.x);
			Assert.assertEquals(-10, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(0, entity.acceleration.y);
			
			deferredActions.execute();
			Assert.assertEquals(22, entity.position.x);
			Assert.assertEquals(-25, entity.position.y);
			Assert.assertEquals(6, entity.velocity.x);
			Assert.assertEquals(-10, entity.velocity.y);
			Assert.assertEquals(0, entity.acceleration.x);
			Assert.assertEquals(0, entity.acceleration.y);
			
			entity.acceleration.x = 1;
			entity.acceleration.y = 2;
			entity.update(deferredActions);
			Assert.assertEquals(22, entity.position.x);
			Assert.assertEquals(-25, entity.position.y);
			Assert.assertEquals(6, entity.velocity.x);
			Assert.assertEquals(-10, entity.velocity.y);
			Assert.assertEquals(1, entity.acceleration.x);
			Assert.assertEquals(2, entity.acceleration.y);
			
			entity.velocity.x = 3;
			entity.velocity.y = 4;
			
			deferredActions.execute();
			Assert.assertEquals(29, entity.position.x);
			Assert.assertEquals(-33, entity.position.y);
			Assert.assertEquals(4, entity.velocity.x);
			Assert.assertEquals(6, entity.velocity.y);
			Assert.assertEquals(1, entity.acceleration.x);
			Assert.assertEquals(2, entity.acceleration.y);
			
			entity.update(deferredActions);
			Assert.assertEquals(29, entity.position.x);
			Assert.assertEquals(-33, entity.position.y);
			Assert.assertEquals(4, entity.velocity.x);
			Assert.assertEquals(6, entity.velocity.y);
			Assert.assertEquals(1, entity.acceleration.x);
			Assert.assertEquals(2, entity.acceleration.y);
			
			deferredActions.execute();
			Assert.assertEquals(34, entity.position.x);
			Assert.assertEquals(-25, entity.position.y);
			Assert.assertEquals(5, entity.velocity.x);
			Assert.assertEquals(8, entity.velocity.y);
			Assert.assertEquals(1, entity.acceleration.x);
			Assert.assertEquals(2, entity.acceleration.y);
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