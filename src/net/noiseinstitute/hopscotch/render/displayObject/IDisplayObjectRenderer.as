package net.noiseinstitute.hopscotch.render.displayObject {
	import flash.display.DisplayObject;
	
	import net.noiseinstitute.hopscotch.render.IRenderer;
	
	public interface IDisplayObjectRenderer extends IRenderer {
		
		function get displayObject () :DisplayObject;
		
	}
	
}