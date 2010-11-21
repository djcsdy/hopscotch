package net.noiseinstitute.hopscotch.graphics {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.PixelSnapping;
	import flash.geom.Rectangle;

	public class BitmapFactory {

		public var transparent :Boolean = true;
		public var fillColor :uint = 0x00000000;
		public var smoothing :Boolean = true;
		public var pixelSnapping :String = PixelSnapping.AUTO;

		public function toBitmap (bitmapDrawable:IBitmapDrawable, rectangle:Rectangle) :Bitmap {
			var bitmapData:BitmapData = new BitmapData(rectangle.width, rectangle.height, transparent, fillColor);
			bitmapData.draw(bitmapDrawable, null, null, null, rectangle);
			return new Bitmap(bitmapData, pixelSnapping, smoothing);
		}

	}

}