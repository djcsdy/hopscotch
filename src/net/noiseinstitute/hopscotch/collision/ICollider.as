package net.noiseinstitute.hopscotch.collision {
	import flash.geom.Rectangle;
	
	public interface ICollider {
		function get boundingBox () :HsBox;
		function collides (collider:ICollider) :Boolean;
	}
	
}