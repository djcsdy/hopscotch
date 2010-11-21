package net.noiseinstitute.hopscotch.input.analogue {
	import net.noiseinstitute.hopscotch.input.IInput;

	/** A one-dimensional analogue controller that gives a signal in the
	 * range -1..1 **/
	public class Wheel implements IInput {
		
		protected var _position :Number = 0;
		
		public function update () :void {
		}
		
		public function get position () :Number {
			return _position;
		}
		
	}
}