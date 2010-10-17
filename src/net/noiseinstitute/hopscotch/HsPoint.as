package net.noiseinstitute.hopscotch {
	
	public class HsPoint {
		
		public var x :Number;
		public var y :Number;
		
		public function HsPoint (x:Number=0, y:Number=0) {
			this.x = x;
			this.y = y;
		}
		
		public function addInPlace (point:HsPoint) :void {
			this.x += point.x;
			this.y += point.y;
		}
		
		public static function add (p1:HsPoint, p2:HsPoint) :HsPoint {
			return new HsPoint(p1.x + p2.x, p1.y + p2.y);
		}
		
	}
	
}