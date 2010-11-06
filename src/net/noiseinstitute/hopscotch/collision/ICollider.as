package net.noiseinstitute.hopscotch.collision {
	
	public interface ICollider {
		function get boundingBox () :HsBox;
		function collides (collider:ICollider) :Boolean;
	}
	
}