package net.noiseinstitute.hopscotch.reuse {
	
	public interface IReusable {
		
		function get alive () :Boolean;
		
		function init () :void;
		function kill () :void;
		
		function addDeadListener (listener:Function) :void;
		function removeDeadListener (listener:Function) :void;
		
	}
	
}
