package hopscotch.engine;

import hopscotch.errors.ArgumentError;
import flash.Lib;
import hopscotch.errors.ArgumentNullError;
import haxe.unit.TestCase;

class EngineTest extends TestCase {
    public function new() {
        super();
    }

    public function testNullRenderTarget() {
        var caught = false;
        try {
            new Engine(null, 640, 480, 60);
        } catch (e:ArgumentNullError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testInvalidSize() {
        for (s in [0, -1, -20]) {
            var caught = false;
            try {
                new Engine(Lib.current, s, 480, 60);
            } catch (e:ArgumentError) {
                caught = true;
            }
            assertTrue(caught);

            caught = false;
            try {
                new Engine(Lib.current, 640, s, 60);
            } catch (e:ArgumentError) {
                caught = true;
            }
            assertTrue(caught);
        }
    }

    public function testInvalidFramesPerSecond() {
        for (fps in [0, -1, -20]) {
            var caught = false;
            try {
                new Engine(Lib.current, 640, 480, fps);
            } catch (e:ArgumentError) {
                caught = true;
            }
            assertTrue(caught);
        }
    }

    public function testRunningIsSetAsExpected() {
        var engine = new Engine(Lib.current, 640, 480, 60);
        assertFalse(engine.running);

        engine.start();
        assertTrue(engine.running);

        engine.start();
        assertTrue(engine.running);

        engine.stop();
        assertFalse(engine.running);

        engine.stop();
        assertFalse(engine.running);
    }
}
