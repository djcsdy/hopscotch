package net.noiseinstitute.hopscotch.input {

	public class InputGroup implements IInput {

		private var inputs :Vector.<IInput> = new Vector.<IInput>();

		public function update():void {
			for each (var input:IInput in inputs) {
				input.update();
			}
		}

		public function add (input:IInput) :void {
			inputs[inputs.length] = input;
		}

		public function remove (input:IInput) :void {
			inputs.splice(inputs.indexOf(input), 1);
		}

	}

}