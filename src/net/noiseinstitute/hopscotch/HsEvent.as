package net.noiseinstitute.hopscotch {
	
	public class HsEvent {
		
		private var _target :Object;
		
		public function get target () :Object {
			return _target;
		}
		
		public function HsEvent (target:Object) {
			this._target = target;
		}
		
	}
	
}
