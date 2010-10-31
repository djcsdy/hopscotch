package net.noiseinstitute.hopscotch.render.displayObject {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	
	import net.noiseinstitute.hopscotch.Entity;
	import net.noiseinstitute.hopscotch.geom.HsPoint;
	
	public class DisplayObjectRenderer implements IDisplayObjectRenderer {
		
		public var _entity :Entity;
		private var _displayObject :DisplayObject;
		public var origin :HsPoint = new HsPoint();
		
		public function DisplayObjectRenderer (displayObject:DisplayObject=null, entity:Entity=null) {
			if (displayObject) {
				_displayObject = displayObject;
			} else {
				_displayObject = new Sprite();
			}
			if (entity) {
				_entity = entity;
			} else {
				_entity = new Entity();
			}
		}
		
		public function render (tweenFactor:Number) :void {
			var matrix:Matrix = _displayObject.transform.matrix;
			matrix.identity();
			matrix.translate(-origin.x, -origin.y);
			matrix.rotate(_entity.rotation);
			matrix.translate(_entity.x, _entity.y);
			_displayObject.transform.matrix = matrix;
		}
		
		public function get entity () :Entity {
			return _entity;
		}
		
		public function get displayObject () :DisplayObject {
			return _displayObject;
		}
		
		public function get sprite () :Sprite {
			return _displayObject as Sprite;
		}
		
	}
	
}