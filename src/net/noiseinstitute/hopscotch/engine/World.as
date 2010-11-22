package net.noiseinstitute.hopscotch.engine {
	import net.noiseinstitute.hopscotch.entities.*;
	import net.noiseinstitute.hopscotch.reuse.IReusable;
	import net.noiseinstitute.hopscotch.reuse.ReusableImpl;

	public class World implements IReusable {

		private var reusableImpl :ReusableImpl = new ReusableImpl();
		private var entities :Vector.<Entity> = new Vector.<Entity>();

		public function update () :void {
			for each (var entity:Entity in entities) {
				entity.update();
			}
		}

		public function render (tweenFactor:Number) :void {
			for each (var entity:Entity in entities) {
				entity.render(tweenFactor);
			}
		}

		public function add (entity:Entity) :void {
			entities[entities.length] = entity;
		}

		public function remove (entity:Entity) :void {
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
			for each (var entity:Entity in entities) {
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