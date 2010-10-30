package net.noiseinstitute.hopscotch {
	
	public class ActionQueue {
		
		private var actions :Vector.<Function> = new Vector.<Function>();
			
		public function enqueue (action:Function) :ActionQueue {
			actions[actions.length] = action;
			return this;
		}
		
		public function execute () :ActionQueue {
			for each (var action:Function in actions) {
				action();
			}
			actions = new Vector.<Function>();
			return this;
		}
		
	}
	
}