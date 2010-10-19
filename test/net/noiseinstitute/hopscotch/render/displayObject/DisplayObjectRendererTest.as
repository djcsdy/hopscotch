package net.noiseinstitute.hopscotch.render.displayObject {
	import asmock.framework.Expect;
	import asmock.framework.MockRepository;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import net.noiseinstitute.hopscotch.Entity;
	import net.noiseinstitute.hopscotch.test.TestCaseWithMocks;
	
	import org.flexunit.Assert;
	
	public class DisplayObjectRendererTest extends TestCaseWithMocks {
		
		private var mocker :MockRepository;
		private var renderer :DisplayObjectRenderer;
		private var entity :Entity;
		private var displayObject :DisplayObject;
		
		public function DisplayObjectRendererTest () {
			super(DisplayObject);
		}
		
		[Before]
		public function setup () :void {
			mocker = new MockRepository();
			entity = new Entity();
			displayObject = new Sprite();
			renderer = new DisplayObjectRenderer(displayObject, entity);
		}
		
		public function testConstructor () :void {
			renderer = new DisplayObjectRenderer();
			Assert.assertNotNull(renderer.entity);
			Assert.assertNotNull(renderer.displayObject);
			
			renderer = new DisplayObjectRenderer(displayObject);
			Assert.assertNotNull(renderer.entity);
			Assert.assertEquals(displayObject, renderer.displayObject);
			
			renderer = new DisplayObjectRenderer(null, entity);
			Assert.assertEquals(entity, renderer.entity);
			Assert.assertNotNull(renderer.displayObject);
			
			renderer = new DisplayObjectRenderer(displayObject, entity);
			Assert.assertEquals(entity, renderer.entity);
			Assert.assertEquals(displayObject, renderer.displayObject);
		}
		
		[Test]
		public function testRender () :void {
			entity.x = 2;
			entity.y = 3;
			
			renderer.render(0);
			Assert.assertEquals(2, displayObject.x);
			Assert.assertEquals(3, displayObject.y);
			
			entity.rotation = Math.PI;
			
			renderer.render(0);
			Assert.assertEquals(2, displayObject.x);
			Assert.assertEquals(3, displayObject.y);
			Assert.assertEquals(180, displayObject.rotation);
			
			entity.rotation = Math.PI/4;
			
			renderer.render(0);
			Assert.assertEquals(2, displayObject.x);
			Assert.assertEquals(3, displayObject.y);
			Assert.assertEquals(45, displayObject.rotation);
			
			entity.x = 0;
			entity.y = 0;
			
			renderer.render(0);
			Assert.assertEquals(0, displayObject.x);
			Assert.assertEquals(0, displayObject.y);
			Assert.assertEquals(45, displayObject.rotation);
		}
	}
}