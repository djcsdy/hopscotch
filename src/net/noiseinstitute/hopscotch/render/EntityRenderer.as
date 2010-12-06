package net.noiseinstitute.hopscotch.render {
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Matrix;

import net.noiseinstitute.hopscotch.engine.RenderInfo;
import net.noiseinstitute.hopscotch.entities.Entity;
import net.noiseinstitute.hopscotch.geom.HsPoint;

public class EntityRenderer {
		
		private var _entity :Entity;
		private var _displayObject :DisplayObject;
		public var origin :HsPoint = new HsPoint();
		
		public function EntityRenderer (entity:Entity,
				displayObject:DisplayObject=null) {
			_entity = entity;
			if (displayObject) {
				_displayObject = displayObject;
			} else {
				_displayObject = new Sprite();
			}
		}
		
		public function render (renderInfo:RenderInfo) :void {
			_displayObject.visible = true;
			
			var matrix:Matrix = _displayObject.transform.matrix;
			matrix.identity();
			matrix.translate(-origin.x, -origin.y);
			matrix.rotate(entity.rotation);
			matrix.translate(entity.x, entity.y);
			_displayObject.transform.matrix = matrix;
		}
		
		public function hide () :void {
			_displayObject.visible = false;
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
