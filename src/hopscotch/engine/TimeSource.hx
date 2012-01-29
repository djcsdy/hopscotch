package hopscotch.engine;

class TimeSource implements ITimeSource {
	public function new() { }
	
	public function getTime():Int {
		return flash.Lib.getTimer();
	}
}