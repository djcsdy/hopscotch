package hopscotch.test;

import haxe.PosInfos;

class TestCase extends haxe.unit.TestCase {
    /** Tests if two floats are approximately equal. Useful to test for expected results while
     * allowing for IEEE-754 rounding errors. */
    public function assertApproxEquals(expected:Float, actual:Float, ?deviation:Null<Float>, ?c:PosInfos) {
        if (deviation == null) {
            deviation = 0.000001;
        }

        currentTest.done = true;
        if (actual < expected - deviation || actual > expected + deviation) {
            currentTest.success = false;
            currentTest.error = "expected '" + expected + "' +/- " + deviation + ", but was '" + actual + "'";
            currentTest.posInfos = c;
            throw currentTest;
        }
    }
}
