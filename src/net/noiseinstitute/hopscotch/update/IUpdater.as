package net.noiseinstitute.hopscotch.update {
	import net.noiseinstitute.hopscotch.ActionQueue;

	public interface IUpdater {
		function update (deferredActions:ActionQueue) :void;
	}
}