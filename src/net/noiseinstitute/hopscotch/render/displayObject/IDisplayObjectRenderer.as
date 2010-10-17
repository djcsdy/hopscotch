package net.noiseinstitute.hopscotch.render.displayObject {
	import flash.display.DisplayObject;
	
	public interface IDisplayObjectRenderer {
		
		function render (tweenFactor:Number) :void;
		
		function get displayObject () :DisplayObject;
		
	}
	
}