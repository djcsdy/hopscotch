package net.noiseinstitute.hopscotch.update {
	import net.noiseinstitute.hopscotch.ActionQueue;
	
	public class UpdateGroup implements IUpdater {
		
		private var members :Vector.<IUpdater> = new Vector.<IUpdater>();
		
		public function update (deferredActions:ActionQueue) :void {
			for each (var member:IUpdater in members) {
				member.update(deferredActions);
			}
		}
		
	}
	
}
