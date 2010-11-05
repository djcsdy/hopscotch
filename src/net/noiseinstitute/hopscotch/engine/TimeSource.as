package net.noiseinstitute.hopscotch.engine {
	import flash.utils.getTimer;
	
	public class TimeSource implements ITimeSource {
		
		public function getTime () :Number {
			return getTimer();
		}
		
	}
	
}