package net.noiseinstitute.hopscotch.engine {
	
	public class TimeSource implements ITimeSource {
		
		public function getTime () :Number {
			return new Date().time;
		}
		
	}
	
}