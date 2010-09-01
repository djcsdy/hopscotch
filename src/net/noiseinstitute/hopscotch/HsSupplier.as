package net.noiseinstitute.hopscotch {
	import org.flixel.FlxObject;
	
	public class HsSupplier {
		
		private var length:uint;
		private var numMembers:uint;
		private var defunctMembers:Vector.<FlxObject>;
		private var numDefunctMembers:uint;
		private var _populate:Function;
		
		/** Creates a new HsSupplier.
		 * 
		 * @param size The maximum number of members that this
		 * supplier can supply. If the size is zero (the default),
		 * then this supplier can supply any number of members. */
		public function HsSupplier (size:uint=0) {
			this.length = size;
			if (size == 0) {
				defunctMembers = new Vector.<FlxObject>();
			} else {
				defunctMembers = new Vector.<FlxObject>(size, true);
			}
		}
		
		public function populate (f:Function) :HsSupplier {
			if (length == 0) {
				_populate = f;
			}
			for (var i:uint=numMembers; i<length; ++i) {
				add(f());
			}
			return this;
		}
		
		public function add (object:FlxObject) :HsSupplier {
			if (length > 0 && numMembers >= length) {
				throw new RangeError("HsSupplier is full");
			}
			
			if (object == null) {
				throw new ArgumentError(
						"Cannot add a null value to an HsSupplier");
			}
			
			++numMembers;
			if (!object.exists) {
				defunctMembers[numDefunctMembers++] = object;
			}
			
			object.addDefunctEventListener(function () :void {
				defunctMembers[numDefunctMembers++] = object;
			});
			
			return this;
		}
		
		public function getInitialized () :FlxObject {
			var object:FlxObject;
			if (numDefunctMembers == 0) {
				if (length == 0) {
					object = _populate();
				} else {
					return null;
				}
			} else {
				object = defunctMembers[--numDefunctMembers];
			}
			if (object != null) {
				object.reset(0, 0);
			}
			return object;
		}
		
	}
	
}