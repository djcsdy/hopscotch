package net.noiseinstitute.hopscotch.geom {
	
	public class HsPoint {
		
		public var x :Number;
		public var y :Number;
		
		public function HsPoint (x:Number=0, y:Number=0) {
			this.x = x;
			this.y = y;
		}
		
		public function copyFrom (p:HsPoint) :void {
			x = p.x;
			y = p.y;
		}
		
		public function add (p:HsPoint) :HsPoint {
			return new HsPoint(x+p.x, y+p.y);
		}
		
		public function addInPlace (p:HsPoint) :void {
			x += p.x;
			y += p.y;
		}
		
		public function subtract (p:HsPoint) :HsPoint {
			return new HsPoint(x-p.x, y-p.y);
		}
		
		public function subtractInPlace (p:HsPoint) :void {
			x -= p.x;
			y -= p.y;
		}
		
		public function dot (p:HsPoint) :Number {
			return x*p.x + y*p.y;
		}
		
		public function cross (p:HsPoint) :Number {
			return x*p.y - y*p.x;
		}
		
		public function multiply (n:Number) :HsPoint {
			return new HsPoint(x*n, y*n);
		}
		
		public function multiplyInPlace (n:Number) :void {
			x *= n;
			y *= n;
		}
		
		public function negate () :HsPoint {
			return new HsPoint(-x, -y);
		}
		
		public function negateInPlace () :void {
			x = -x;
			y = -y;
		}
		
		public function magnitude () :Number {
			return Math.sqrt(x*x + y*y);
		}
		
		public function normalize () :HsPoint {
			var m:Number = magnitude();
			if (m == 0) {
				return new HsPoint(0, 0);
			} else {
				return new HsPoint(x/m, y/m);
			}
		}
		
		public function normalizeInPlace () :void {
			var m:Number = magnitude();
			if (m == 0) {
				x = 0;
				y = 0;
			} else {
				x /= m;
				y /= m;
			}
		}
		
		public function distance (p:HsPoint) :Number {
			var xd:Number = x - p.x;
			var yd:Number = y - p.y;
			return Math.sqrt(xd*xd + yd*yd);
		}
		
		public function scale (s:Number) :HsPoint {
			return new HsPoint(x*s, y*s);
		}
		
		public function scaleInPlace (s:Number) :void {
			x *= s;
			y *= s;
		}
		
		public function clone () :HsPoint {
			return new HsPoint(x, y);
		}
		
		public function becomeUnitVector (angle:Number) :void {
			x = Math.sin(angle);
			y = -Math.cos(angle);
		}
		
		public static function unitVector (angle:Number) :HsPoint {
			return new HsPoint(Math.sin(angle), -Math.cos(angle));
		}
		
	}
	
}