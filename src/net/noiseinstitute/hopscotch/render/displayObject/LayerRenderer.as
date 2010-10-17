package net.noiseinstitute.hopscotch.render.displayObject {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.Dictionary;
	
	import net.noiseinstitute.hopscotch.Entity;
	
	public class LayerRenderer extends DisplayObjectRenderer {
		
		private var _container :DisplayObjectContainer;
		private var renderers :Vector.<IDisplayObjectRenderer> =
				new Vector.<IDisplayObjectRenderer>();
		private var rendererIndices :Dictionary;
		
		public function LayerRenderer (entity:Entity=null, container:DisplayObjectContainer=null) {
			if (container) {
				_container = container;
			} else {
				_container = new DisplayObjectContainer();
			}
			super(entity, _container);
		}
		
		override public function render (tweenFactor:Number) :void {
			super.render(tweenFactor);
			
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
		
		public function get container () :DisplayObjectContainer {
			return _container;
		}
		
	}
}