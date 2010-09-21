package net.noiseinstitute.hopscotch {
	import org.flixel.FlxObject;
	
	public class HsSupplier {
		
		private var length:uint;
		private var numMembers:uint;
		private var members:Vector.<FlxObject>;
		private var numDefunctMembers:uint;
		private var populator:Function;
		
		/** Creates a new HsSupplier.
		 * 
		 * @param size The maximum number of members that this
		 * supplier can supply. If the size is zero (the default),
		 * then this supplier can supply any number of members. */
		public function HsSupplier (size:uint=0) {
			this.length = size;
			if (size == 0) {
				members = new Vector.<FlxObject>();
			} else {
				members = new Vector.<FlxObject>(size, true);
			}
		}
		
		/** Populate the <code>HsSupplier</code> by calling back a function
		 * <code>f</code> that creates <code>FlxObject</code>s.
		 * 
		 * <p>If the <code>HsSupplier</code> has a fixed size, then
		 * <code>f</code> will be called back immediately and repeatedly, until
		 * the <code>HsSupplier</code> is full. Thereafter, <code>f</code> will
		 * not be called again.</p>
		 * 
		 * <p>Otherwise, <code>f</code> will be called on a call to
		 * <code>getInitialized</code>, if the <code>HsSupplier</code> has
		 * run out of defunct members.</p>
		 * 
		 * @param f a function used to populate the <code>HsSupplier</code>,
		 *   defined in the form <code>function():FlxObject</code>. */
		public function populate (f:Function) :HsSupplier {
			if (length == 0) {
				populator = f;
			}
			for (var i:uint=numMembers; i<length; ++i) {
				add(f());
			}
			return this;
		}
		
		/** Add an object to the <code>HsSupplier</code>. */
		public function add (object:FlxObject) :HsSupplier {
			if (length > 0 && numMembers >= length) {
				throw new RangeError("HsSupplier is full");
			}
			
			if (object == null) {
				throw new ArgumentError(
						"Cannot add a null value to an HsSupplier");
			}
			
			if (object.exists) {
				members[numMembers++] = object;
			} else {
				var i:int = numMembers;
				while (i > numDefunctMembers) {
					members[i] = members[--i];
				}
				members[i] = object;
				++numMembers;
				++numDefunctMembers;
			}
			
			object.addDefunctEventListener(function () :void {
				if (members[numDefunctMembers] == object) {
					++numDefunctMembers;
					return;
				} else {
					var previousMember:FlxObject = members[numDefunctMembers];
					var i:int = numDefunctMembers+1;
					do {
						var tmp:FlxObject = members[i];
						members[i] = previousMember;
						previousMember = tmp;
						++i;
					} while (previousMember != object);
					members[numDefunctMembers++] = object;
				}
			});
			
			return this;
		}
		
		public function getInitialized (reuseLive:Boolean=false) :FlxObject {
			var object:FlxObject; 
			if (numDefunctMembers == 0) {
				if (reuseLive) {
					if (members.length > 0) {
						object = members[0];
						var i:int = 0;
						var c:int = members.length-1;
						while (i<c) {
							members[i] = members[++i];
						}
						members[i] = object;
					} else {
						return null;
					}
				} else if (length == 0) {
					object = populator();
					members[numMembers++] = object;
				} else {
					return null;
				}
			} else {
				object = members[--numDefunctMembers];
			}
			if (object != null) {
				object.reset(0, 0);
			}
			return object;
		}
		
	}
	
}