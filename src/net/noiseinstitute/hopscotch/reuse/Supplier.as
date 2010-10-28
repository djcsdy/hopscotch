package net.noiseinstitute.hopscotch.reuse {
	
	public class Supplier {
		
		private var length:uint;
		private var numMembers:uint;
		private var members:Vector.<IReusable>;
		private var numDeadMembers:uint;
		private var populator:Function;
		
		/** Creates a new <code>Supplier</code>.
		 * 
		 * @param size The maximum number of members that this
		 * supplier can supply. If the size is zero (the default),
		 * then this supplier can supply any number of members. */
		public function HsSupplier (size:uint=0) {
			this.length = size;
			if (size == 0) {
				members = new Vector.<IReusable>();
			} else {
				members = new Vector.<IReusable>(size, true);
			}
		}
		
		/** Populate the <code>Supplier</code> by calling back a function
		 * <code>f</code> that creates <code>IReusable</code>s.
		 * 
		 * <p>If the <code>Supplier</code> has a fixed size, then
		 * <code>f</code> will be called back immediately and repeatedly, 
		 * until the <code>Supplier</code> is full. Thereafter, <code>f</code>
		 * will not be called again.</p>
		 * 
		 * <p>Otherwise, <code>f</code> will be called on a call to
		 * <code>getInitialized</code>, if the <code>Supplier</code> has
		 * run out of dead members.</p>
		 * 
		 * @param f a function used to populate the <code>Supplier</code>,
		 *   defined in the form <code>function():IReusable</code>. */
		public function populate (f:Function) :HsSupplier {
			if (length == 0) {
				populator = f;
			}
			for (var i:uint=numMembers; i<length; ++i) {
				add(f());
			}
			return this;
		}
		
		/** Add an object to the <code>Supplier</code>. */
		public function add (object:IReusable) :Supplier {
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
				while (i > numDeadMembers) {
					members[i] = members[--i];
				}
				members[i] = object;
				++numMembers;
				++numDeadMembers;
			}
			
			object.addDeadEventListener(function () :void {
				if (members[numDeadMembers] == object) {
					++numDeadMembers;
					return;
				} else {
					var previousMember:IReusable = members[numDeadMembers];
					var i:int = numDeadMembers+1;
					do {
						var tmp:IReusable = members[i];
						members[i] = previousMember;
						previousMember = tmp;
						++i;
					} while (previousMember != object);
					members[numDeadMembers++] = object;
				}
			});
			
			return this;
		}
		
		public function getInitialized (reuseLive:Boolean=false) :IReusable {
			var object:IReusable; 
			if (numDeadMembers == 0) {
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
				object = members[--numDeadMembers];
			}
			if (object != null) {
				object.reset(0, 0);
			}
			return object;
		}
		
	}
	
}
