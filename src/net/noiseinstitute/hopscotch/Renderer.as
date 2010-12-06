package net.noiseinstitute.hopscotch {
	import flash.display.Sprite;
	import flash.geom.Matrix;

	import net.noiseinstitute.hopscotch.geom.HsPoint;

	public class Renderer implements IRenderer {

		public var origin :HsPoint = new HsPoint();
		private var sprite :Sprite;
		private var tweener :Tweener;

		public function Renderer (sprite:Sprite, tweener:Tweener) {
			this.sprite = sprite;
			this.tweener = tweener;
		}

		public function render (tweenFactor:Number) :void {
			var tween:EntityTween = tweener.tween(tweenFactor);
			var matrix:Matrix = sprite.transform.matrix;
			matrix.identity();
			matrix.translate(-origin.x, -origin.y);
			matrix.rotate(tween.angle);
			matrix.translate(tween.x, tween.y);
			sprite.transform.matrix = matrix;
		}
	}

}
