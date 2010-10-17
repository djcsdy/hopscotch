package net.noiseinstitute.hopscotch.render.displayObject {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import net.noiseinstitute.hopscotch.HsPoint;
	
	public class SpriteRenderer implements IDisplayObjectRenderer {
		
		private var _displayObject :DisplayObject;
		public var origin :HsPoint = new HsPoint();
		
		public function SpriteRenderer (displayObject:DisplayObject=null) {
			if (displayObject) {
				_displayObject = displayObject;
			} else {
				_displayObject = new Sprite();
			}
		}
		
		public function get displayObject () :DisplayObject {
			return null;
		}
		
		public function render (tweenFactor:Number) :void {
			_displayObject.x = _entity.x - origin.x;
			_displayObject.y = _entity.y - origin.y;
		}
		
		public function get sprite () :Sprite {
			return _displayObject as Sprite;
		}
		
	}
	
}