package net.noiseinstitute.hopscotch.render.displayObject {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import net.noiseinstitute.hopscotch.Entity;
	
	public class LayerRenderer extends DisplayObjectRenderer {
		
		public var sortComparison :Function;
		
		private var _container :DisplayObjectContainer;
		private var renderers :Vector.<IDisplayObjectRenderer> =
				new Vector.<IDisplayObjectRenderer>();
		private var rendererIndices :Dictionary = new Dictionary();
		
		public function LayerRenderer (container:DisplayObjectContainer=null, entity:Entity=null) {
			super(container, entity);
			_container = sprite;
		}
		
		override public function render (tweenFactor:Number) :void {
			super.render(tweenFactor);
			
			var renderer:IDisplayObjectRenderer;
			for each (renderer in renderers) {
				renderer.render(tweenFactor);
			}
			
			if (sortComparison != null) {
				var sortedRenderers:Vector.<IDisplayObjectRenderer> =
						renderers.sort(sortComparison);
				for (var i:Number=0; i<sortedRenderers.length; ++i) {
					renderer = renderers[i];
					_container.setChildIndex(renderer.displayObject, i);
				}
			}
		}
		
		public function addRenderer (renderer:IDisplayObjectRenderer) :void {
			if (rendererIndices[renderer] == null) {
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