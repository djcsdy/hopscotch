import hopscotch.engine.Engine;

class Main {
	static function main():Void {
		var engine = new Engine(flash.Lib.current, 640, 480, 60);
		engine.start();
	}
}