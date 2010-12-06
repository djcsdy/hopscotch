package net.noiseinstitute.hopscotch {
	import flash.display.Sprite;
	import flash.events.Event;

	import net.noiseinstitute.hopscotch.engine.*;

	public class HsSprite extends Sprite {

		public var updater :IUpdater;
		public var tweener :ITweener;
		public var renderer :IRenderer;

		private var engine :Engine;
		private var updateCount :int = -1;

		public function HsSprite (engine:Engine) {
			super();

			var entity:Entity = new Entity();
			updater = entity;
			var tweener:Tweener = new Tweener(entity);
			this.tweener = tweener;
			renderer = new Renderer(this, tweener);

			this.engine = engine;
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function get entity () :Entity {
			return updater as Entity;
		}

		public function set entity (entity:Entity) {
			updater = entity;
		}

		private function onEnterFrame (event:Event) :void {
			while (updateCount < engine.updateCount) {
				updater.update();
				tweener.update();
				++updateCount;
			}

			renderer.render(engine.tweenFactor);
		}

	}

}
