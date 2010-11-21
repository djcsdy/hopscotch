package net.noiseinstitute.hopscotch.engine {
	import net.noiseinstitute.hopscotch.entities.*;
	import net.noiseinstitute.hopscotch.engine.ActionQueue;

	public class World {

		private var entities :Vector.<Entity> = new Vector.<Entity>();

		public function update (deferredActions:ActionQueue) :void {
			for each (var entity:Entity in entities) {
				entity.update(deferredActions);
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

	}

}