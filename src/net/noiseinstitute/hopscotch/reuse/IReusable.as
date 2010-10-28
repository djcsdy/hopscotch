package net.noiseinstitute.hopscotch.reuse {
	
	public interface IReusable {
		
		function get alive () :Boolean;
		function set alive (alive:Boolean) :void;
		
		function init () :void;
		
		function addAliveListener (listener:Function) :void;
		function removeAliveListener (listener:Function) :void;
		
		function addDeadListener (listener:Function) :void;
		function removeDeadListener (listener:Function) :void;
		
	}
	
}
