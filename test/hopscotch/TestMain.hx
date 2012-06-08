package hopscotch;

import hopscotch.engine.EngineTest;
import haxe.unit.TestRunner;

class TestMain {
    static function main() {
        var testRunner = new TestRunner();
        testRunner.add(new EngineTest());
        testRunner.run();
    }
}
