package net.noiseinstitute.hopscotch.render.displayObject {
	import flash.display.DisplayObject;
	
	import net.noiseinstitute.hopscotch.render.IEntityRenderer;
	
	public interface IDisplayObjectRenderer extends IEntityRenderer {
		
		function get displayObject () :DisplayObject;
		
	}
	
}