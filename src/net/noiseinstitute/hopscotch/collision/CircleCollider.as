package net.noiseinstitute.hopscotch.collision {
	import flash.utils.getQualifiedClassName;
	
	import net.noiseinstitute.hopscotch.entities.Entity;
	import net.noiseinstitute.hopscotch.geom.HsPoint;
	
	final public class CircleCollider implements ICollider {
		
		public var entity :Entity;
		public var radius :Number;
		public var origin :HsPoint;
		private var testingReverseCollision :Boolean = false;
		
		public function CircleCollider (
				entity:Entity=null,
				radius:Number=0,
				offset:HsPoint=new HsPoint()) {
			this.entity = entity;
			this.radius = radius;
			this.origin = offset;
		}
		
		public function get boundingBox () :HsBox {
			return new HsBox(
					entity.x - origin.x,
					entity.y - origin.y,
					radius*2,
					radius*2);
		}
		
		public function collides (collider:ICollider,
				unknownColliderHandler:Function=null) :Boolean {
			if (testingReverseCollision) {
				testingReverseCollision = false;
				if (unknownColliderHandler) {
					return unknownColliderHandler(this, collider);
				} else {
					throw new ArgumentError(
							"Don't know how to collide CircleCollider with " +
							getQualifiedClassName(collider));
				}
			} else {
				if (collider is CircleCollider) {
					var other:CircleCollider = collider as CircleCollider;
					var thisCentre:HsPoint =
							entity.position.subtract(origin);
					var otherCentre:HsPoint =
							other.entity.position.subtract(other.origin);
					return thisCentre.distance(otherCentre) <
							(radius + other.radius);
				} else {
					return collider.collides(this);
				}
			}
		}
		
	}
	
}