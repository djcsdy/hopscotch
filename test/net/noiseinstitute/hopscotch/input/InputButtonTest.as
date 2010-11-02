package net.noiseinstitute.hopscotch.input {
	import net.noiseinstitute.hopscotch.update.ActionQueue;
	
	import org.flexunit.Assert;
	
	public class InputButtonTest {
		
		private var button :InputButton;
		
		[Before]
		public function setup () :void {
			button = new InputButton();
		}
		
		[Test]
		public function testInitialState () :void {
			Assert.assertFalse(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
		}
		
		[Test]
		public function testStateAfterFirstUpdate () :void {
			button.update(null);
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
			
			button.update(null);
			Assert.assertTrue(button.pressed);
			Assert.assertTrue(button.justPressed);
			Assert.assertFalse(button.justReleased);
			
			button.update(null);
			Assert.assertTrue(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
			
			button.update(null);
			Assert.assertTrue(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
			
			button.release();
			Assert.assertTrue(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
			
			button.update(null);
			Assert.assertFalse(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertTrue(button.justReleased);
			
			button.update(null);
			Assert.assertFalse(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
			
			button.press();
			Assert.assertFalse(button.pressed);
			Assert.assertFalse(button.justPressed);
			Assert.assertFalse(button.justReleased);
			
			button.update(null);
			Assert.assertTrue(button.pressed);
			Assert.assertTrue(button.justPressed);
			Assert.assertFalse(button.justReleased);
			
		}
		
	}

}