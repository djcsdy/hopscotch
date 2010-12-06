package net.noiseinstitute.hopscotch.engine {
	import net.noiseinstitute.hopscotch.HsSprite;
	import net.noiseinstitute.hopscotch.entities.*;
	import net.noiseinstitute.hopscotch.reuse.IReusable;
	import net.noiseinstitute.hopscotch.reuse.ReusableImpl;

	public class World implements IReusable {

		private var reusableImpl :ReusableImpl = new ReusableImpl();
		private var entities :Vector.<HsSprite> = new Vector.<HsSprite>();

		public function update () :void {
			for each (var entity:HsSprite in entities) {
				entity.update();
			}
		}

		public function render (tweenFactor:Number) :void {
			for each (var entity:HsSprite in entities) {
				entity.render(tweenFactor);
			}
		}

		public function add (entity:HsSprite) :void {
			entities[entities.length] = entity;
		}

		public function remove (entity:HsSprite) :void {
			entities.splice(entities.indexOf(entity), 1);
		}

		public function get alive () :Boolean {
			return reusableImpl.alive;
		}

		public function init () :void {
			reusableImpl.init();
		}

		public function kill () :void {
			reusableImpl.kill();
			for each (var entity:HsSprite in entities) {
				entity.kill();
			}
		}

		public function addDeadListener (listener:Function) :void {
			reusableImpl.addDeadListener(listener);
		}

		public function removeDeadListener (listener:Function ):void {
			reusableImpl.removeDeadListener(listener);
		}

	}

}
