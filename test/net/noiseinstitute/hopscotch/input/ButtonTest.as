package net.noiseinstitute.hopscotch.input {
	import net.noiseinstitute.hopscotch.engine.ActionQueue;
	
	import org.flexunit.Assert;
	import net.noiseinstitute.hopscotch.input.digital.Button;
	
	public class ButtonTest {
		
		private var button :Button;
		
		[Before]
		public function setup () :void {
			button = new Button();
		}
		
		[Test]
		public function testInitialState () :void {
			Assert.assertFalse(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
		}
		
		[Test]
		public function testStateAfterFirstUpdate () :void {
			button.update();
			Assert.assertFalse(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
		}
		
		[Test]
		public function testPressAndRelease () :void {
			button.press();
			Assert.assertFalse(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
			Assert.assertEquals(0, button.pressedTicks);
			Assert.assertEquals(1, button.releasedTicks);
			
			button.update();
			Assert.assertTrue(button.pressed);
			Assert.assertTrue(button.justPressed);
			Assert.assertFalse(button.justReleased);
			Assert.assertEquals(1, button.pressedTicks);
			Assert.assertEquals(0, button.releasedTicks);
			
			button.update();
			Assert.assertTrue(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
			Assert.assertEquals(2, button.pressedTicks);
			Assert.assertEquals(0, button.releasedTicks);
			
			button.update();
			Assert.assertTrue(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
			Assert.assertEquals(3, button.pressedTicks);
			Assert.assertEquals(0, button.releasedTicks);
			
			button.release();
			Assert.assertTrue(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
			Assert.assertEquals(3, button.pressedTicks);
			Assert.assertEquals(0, button.releasedTicks);
			
			button.update();
			Assert.assertFalse(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertTrue(button.justReleased);
			Assert.assertEquals(0, button.pressedTicks);
			Assert.assertEquals(1, button.releasedTicks); 
			
			button.update();
			Assert.assertFalse(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
			Assert.assertEquals(0, button.pressedTicks);
			Assert.assertEquals(2, button.releasedTicks);
			
			button.press();
			Assert.assertFalse(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
			Assert.assertEquals(0, button.pressedTicks);
			Assert.assertEquals(2, button.releasedTicks);
			
			button.update();
			Assert.assertTrue(button.pressed);
			Assert.assertTrue(button.justPressed);
			Assert.assertFalse(button.justReleased);
			Assert.assertEquals(1, button.pressedTicks);
			Assert.assertEquals(0, button.releasedTicks);
		}
		
	}

}