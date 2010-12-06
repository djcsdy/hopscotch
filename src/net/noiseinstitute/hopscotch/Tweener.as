package net.noiseinstitute.hopscotch {
	import net.noiseinstitute.hopscotch.geom.HsPoint;

	public class Tweener implements ITweener {

		private var entity :Entity;
		private var entityTween :EntityTween = new EntityTween();
		private var oldPosition :HsPoint = new HsPoint();

		public function Tweener (entity:Entity) {
			this.entity = entity;
		}

		public function update () :void {
			oldPosition.copyFrom(entity.position);
		}

		function tween (tweenFactor:Number) :EntityTween {
			entityTween.position.copyFrom(entity.position);
			entityTween.position.subtractInPlace(oldPosition);
			entityTween.position.scaleInPlace(tweenFactor);
			entityTween.position.addInPlace(oldPosition);
			entityTween.angle = entity.angle;
			return entityTween;
		}
	}

}
