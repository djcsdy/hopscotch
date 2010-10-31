package net.noiseinstitute.hopscotch.update {
	
	public class UpdateGroup implements IUpdater {
		
		private var members :Vector.<IUpdater> = new Vector.<IUpdater>();
		
		public function update (deferredActions:ActionQueue) :void {
			for each (var member:IUpdater in members) {
				member.update(deferredActions);
			}
		}
		
	}
	
}
