package net.noiseinstitute.hopscotch.update {

	public interface IUpdater {
		function update (deferredActions:ActionQueue) :void;
		function render (tweenFactor:Number) :void;
	}
}