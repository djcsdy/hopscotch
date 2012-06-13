package hopscotch;

import hopscotch.math.VectorMathTest;
import hopscotch.engine.EngineTest;
import haxe.unit.TestRunner;

class TestMain {
    static function main() {
        #if flash
        var oldPrint = TestRunner.print;
        TestRunner.print = function (value) {
            oldPrint(value);
            flash.Lib.trace(value);
        }
        #end

        var testRunner = new TestRunner();
        testRunner.add(new EngineTest());
        testRunner.add(new VectorMathTest());
        testRunner.run();
    }
}
