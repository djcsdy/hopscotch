package net.noiseinstitute.hopscotch {
	import org.flexunit.Assert;
	
	public class ActionQueueTest {		
		
		private var actionQueue :ActionQueue;
		
		[Before]
		public function setup () :void {
			actionQueue = new ActionQueue();
		}
		
		[Test]
		public function testThatActionsExecuteInTheCorrectOrder () :void {
			var aDone:Boolean = false;
			var bDone:Boolean = false;
			var cDone:Boolean = false;
			
			function a () :void {
				Assert.assertFalse(aDone);
				Assert.assertFalse(bDone);
				Assert.assertFalse(cDone);
				aDone = true;
			}
			
			function b () :void {
				Assert.assertTrue(aDone);
				Assert.assertFalse(bDone);
				Assert.assertFalse(cDone);
				bDone = true;
			}
			
			function c () :void {
				Assert.assertTrue(aDone);
				Assert.assertTrue(bDone);
				Assert.assertFalse(cDone);
				cDone = true;
			}
			
			actionQueue.enqueue(a);
			actionQueue.enqueue(b);
			actionQueue.enqueue(c);
			
			Assert.assertFalse(aDone);
			Assert.assertFalse(bDone);
			Assert.assertFalse(cDone);
			
			actionQueue.execute();
			
			Assert.assertTrue(aDone);
			Assert.assertTrue(bDone);
			Assert.assertTrue(cDone);
			
			aDone = false;
			bDone = false;
			cDone = false;
			actionQueue.execute();
			
			Assert.assertFalse(aDone);
			Assert.assertFalse(bDone);
			Assert.assertFalse(cDone);
			
			actionQueue.enqueue(a);
			actionQueue.execute();
			
			Assert.assertTrue(aDone);
			Assert.assertFalse(bDone);
			Assert.assertFalse(cDone);
		}
		
	}
	
}