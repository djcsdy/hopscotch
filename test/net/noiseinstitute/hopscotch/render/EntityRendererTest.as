package net.noiseinstitute.hopscotch.render {
import asmock.framework.MockRepository;

import flash.display.DisplayObject;
import flash.display.Sprite;

import net.noiseinstitute.hopscotch.engine.RenderInfo;
import net.noiseinstitute.hopscotch.entities.Entity;
import net.noiseinstitute.hopscotch.test.TestCaseWithMocks;

import org.flexunit.Assert;

public class EntityRendererTest extends TestCaseWithMocks {

		private var mocker :MockRepository;
		private var renderer :EntityRenderer;
		private var renderInfo :RenderInfo;
		private var entity :Entity;
		private var displayObject :DisplayObject;

		public function EntityRendererTest () {
			super(RenderInfo);
		}

		[Before]
		public function setup () :void {
			mocker = new MockRepository();
			entity = new Entity();
			displayObject = new Sprite();
			renderer = new EntityRenderer(entity, displayObject);
			renderInfo = mocker.createStub(RenderInfo) as RenderInfo;
		}

		public function testConstructor () :void {
			renderer = new EntityRenderer(entity);
			Assert.assertEquals(entity, renderer.entity);
			Assert.assertNotNull(renderer.displayObject);

			renderer = new EntityRenderer(entity, displayObject);
			Assert.assertEquals(entity, renderer.entity);
			Assert.assertEquals(displayObject, renderer.displayObject);
		}

		[Test]
		public function testRender () :void {
			entity.x = 2;
			entity.y = 3;

			renderer.render(renderInfo);
			Assert.assertEquals(2, displayObject.x);
			Assert.assertEquals(3, displayObject.y);

			entity.rotation = Math.PI;

			renderer.render(renderInfo);
			Assert.assertEquals(2, displayObject.x);
			Assert.assertEquals(3, displayObject.y);
			Assert.assertEquals(180, displayObject.rotation);

			entity.rotation = Math.PI/4;

			renderer.render(renderInfo);
			Assert.assertEquals(2, displayObject.x);
			Assert.assertEquals(3, displayObject.y);
			Assert.assertEquals(45, displayObject.rotation);

			entity.x = 0;
			entity.y = 0;

			renderer.render(renderInfo);
			Assert.assertEquals(0, displayObject.x);
			Assert.assertEquals(0, displayObject.y);
			Assert.assertEquals(45, displayObject.rotation);
		}
	}
}
