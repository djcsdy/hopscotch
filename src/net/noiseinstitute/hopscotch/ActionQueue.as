package net.noiseinstitute.hopscotch {
	
	public class ActionQueue {
		
		private static function doNothing () :void {
		}
		
		private var actions :Function = doNothing
			
		public function enqueue (action:Function) :ActionQueue {
			var previousActions:Function = actions;
			actions = function () :void {
				previousActions();
				action();
			};
			return this;
		}
		
		public function execute () :ActionQueue {
			actions();
			actions = doNothing; 
			return this;
		}
		
	}
	
}