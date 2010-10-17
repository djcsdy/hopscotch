package net.noiseinstitute.hopscotch.render.bitmap {
	import net.noiseinstitute.hopscotch.render.IRenderer;
	
	public interface IBitmapRenderer {
		function render (renderState:BitmapRenderState) :void;
	}
	
}