package net.noiseinstitute.hopscotch.render.displayObject {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	
	import net.noiseinstitute.hopscotch.Entity;
	import net.noiseinstitute.hopscotch.HsPoint;
	import net.noiseinstitute.hopscotch.render.IRenderer;
	
	public class LayerRenderer implements IDisplayObjectRenderer {
		
		private var _entity :Entity;
		private var _container :DisplayObjectContainer;
		public var origin :HsPoint = new HsPoint(); 
		private var renderers :Vector.<IDisplayObjectRenderer> =
				new Vector.<IDisplayObjectRenderer>();
		private var rendererIndices :Dictionary;
		
		public function LayerRenderer (entity:Entity=null, container:DisplayObjectContainer=null) {
			if (entity) {
				_entity = entity;
			} else {
				_entity = new Entity();
			}
			if (container) {
				_container = container;
			} else {
				_container = new DisplayObjectContainer();
			}
		}
		
		public function render (tweenFactor:Number) :void {
			_container.x = _entity.x - origin.x;
			_container.y = _entity.y - origin.y;
			
			for each (var renderer:IDisplayObjectRenderer in renderers) {
				renderer.render(tweenFactor);
			}
		}
		
		public function addRenderer (renderer:IDisplayObjectRenderer) :void {
			if (rendererIndices[renderer] != null) {
				var i:uint = renderers.length;
				rendererIndices[renderer] = i
				renderers[i] = renderer;
				
				var displayObject:DisplayObject = renderer.displayObject;
				_container.addChild(displayObject);
			}
		}
		
		public function removeRenderer (renderer:IDisplayObjectRenderer) :void {
			if (rendererIndices[renderer] != null) {
				var i:uint = rendererIndices[renderer];
				if (renderers[i] != renderer) {
					i = renderers.indexOf(renderer);
				}
				renderers.splice(i, 1);
				delete rendererIndices[renderer];
				
				var displayObject:DisplayObject = renderer.displayObject;
				if (displayObject.parent == container) {
					_container.removeChild(displayObject);
				}
			}
		}
		
		public function get displayObject () :DisplayObject {
			return _container;
		}
		
		public function get container () :DisplayObjectContainer {
			return _container;
		}
		
	}
}