package hopscotch;

class Engine {
	public var playfield:Playfield;
	
	var previousPlayfield:Playfield;
	
	// TODO
	
	function update(frame:Int):Void {
		if (playfield != null && playfield != previousPlayfield) {
			if (previousPlayfield != null) {
				previousPlayfield.end();
			}
			
			playfield.begin(frame-1);
			
			previousPlayfield = playfield;
		}
		
		playfield.update(frame);
	}
	
	function updateGraphic(frame:Int):Void {
		if (playfield != null) {
			playfield.updateGraphic(frame);
		}
	}
	
	function render():Void {
		// TODO
	}
}