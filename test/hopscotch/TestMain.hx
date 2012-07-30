package hopscotch;

import hopscotch.collision.PixelMaskTest;
import hopscotch.collision.CircleMaskTest;
import hopscotch.collision.BoxMaskTest;
import hopscotch.collision.MaskTest;
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
        testRunner.add(new BoxMaskTest());
        testRunner.add(new CircleMaskTest());
        testRunner.add(new MaskTest());
        testRunner.add(new PixelMaskTest());
        testRunner.add(new VectorMathTest());
        testRunner.run();
    }
}
