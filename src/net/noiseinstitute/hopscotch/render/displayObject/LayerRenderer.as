package net.noiseinstitute.hopscotch.render.displayObject {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import net.noiseinstitute.hopscotch.render.IRenderer;
	
	public class LayerRenderer implements IDisplayObjectRenderer {
		
		private var _container :DisplayObjectContainer;
		private var renderers :Vector.<IDisplayObjectRenderer> =
				new Vector.<IDisplayObjectRenderer>();
		private var rendererIndices :Dictionary;
		
		public function LayerRenderer (container:DisplayObjectContainer=null) {
			if (container) {
				_container = container;
			} else {
				_container = new DisplayObjectContainer();
			}
		}
		
		public function render (tweenFactor:Number) :void {
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
				_container.removeChild(displayObject);
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