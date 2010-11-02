package net.noiseinstitute.hopscotch.update {
	
	public class UpdateGroup implements IUpdater {
		
		private var _members :Vector.<IUpdater> = new Vector.<IUpdater>();
		
		public function update (deferredActions:ActionQueue) :void {
			for each (var member:IUpdater in _members) {
				member.update(deferredActions);
			}
		}
		
		public function get members () :Vector.<IUpdater> {
			return _members;
		}
		
	}
	
}
