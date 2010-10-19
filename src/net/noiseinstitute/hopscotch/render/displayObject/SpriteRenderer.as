package net.noiseinstitute.hopscotch.render.displayObject {
	import flash.display.Sprite;
	
	import net.noiseinstitute.hopscotch.Entity;
	
	public class SpriteRenderer extends DisplayObjectRenderer {
		
		private var _sprite :Sprite;
		
		public function SpriteRenderer (entity:Entity) {
			_sprite = new Sprite();
			super(_sprite, entity);
		}
		
		public function get sprite () :Sprite {
			return _sprite;
		}
		
	}
	
}