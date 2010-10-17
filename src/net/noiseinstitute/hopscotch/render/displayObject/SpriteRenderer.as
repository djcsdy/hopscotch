package net.noiseinstitute.hopscotch.render.displayObject {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import net.noiseinstitute.hopscotch.Entity;
	import net.noiseinstitute.hopscotch.HsPoint;
	
	public class SpriteRenderer implements IDisplayObjectRenderer {
		
		private static const RADIANS_TO_DEGREES :Number = 180/Math.PI;
		
		private var _entity :Entity;
		private var _displayObject :DisplayObject;
		public var origin :HsPoint = new HsPoint();
		
		public function SpriteRenderer (entity:Entity=null, displayObject:DisplayObject=null) {
			if (entity) {
				_entity = entity;
			} else {
				_entity = new Entity();
			}
			if (displayObject) {
				_displayObject = displayObject;
			} else {
				_displayObject = new Sprite();
			}
		}
		
		public function render (tweenFactor:Number) :void {
			_displayObject.x = _entity.x - origin.x;
			_displayObject.y = _entity.y - origin.y;
			_displayObject.rotation = _entity.rotation * RADIANS_TO_DEGREES;
		}
		
		public function get displayObject () :DisplayObject {
			return _displayObject;
		}
		
		public function get sprite () :Sprite {
			return _displayObject as Sprite;
		}
		
	}
	
}