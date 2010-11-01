package net.noiseinstitute.hopscotch.input {
	import net.noiseinstitute.hopscotch.geom.HsPoint;
	import net.noiseinstitute.hopscotch.update.IUpdater;
	
	public interface IInputAxes extends IUpdater {
		public function get position () :HsPoint;
	}
	
}