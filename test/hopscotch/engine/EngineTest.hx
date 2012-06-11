package hopscotch.engine;

import flash.display.Sprite;
import flash.events.Event;
import hopscotch.errors.ArgumentError;
import flash.Lib;
import hopscotch.errors.ArgumentNullError;
import haxe.unit.TestCase;

class EngineTest extends TestCase {
    public function new () {
        super();
    }

    public function testNullRenderTarget () {
        var caught = false;
        try {
            new Engine(null, 640, 480, 60);
        } catch (e:ArgumentNullError) {
            caught = true;
        }
        assertTrue(caught);
    }

    public function testInvalidSize () {
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

    public function testInvalidFramesPerSecond () {
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

    public function testRunningIsSetAsExpected () {
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

    public function testNullPlayfieldIsTolerated () {
        var renderTarget = new Sprite();
        var timeSource = new TimeSourceMock();
        var engine = new Engine(renderTarget, 640, 480, 60, timeSource);
        engine.start();

        for (i in 0...100) {
            timeSource.time = i * 10;
            renderTarget.dispatchEvent(new Event(Event.ENTER_FRAME));
        }

        engine.stop();

        // If no exceptions are thrown, the test passes.
        assertTrue(true);
    }

    public function testUpdateIsCalledAsExpected () {
        var fps = 60;
        var frameInterval = 1000 / 60;

        var renderTarget = new Sprite();
        var timeSource = new TimeSourceMock();
        var engine = new Engine(renderTarget, 640, 480, fps, timeSource);

        var playfield = new PlayfieldMock();
        engine.playfield = playfield;

        timeSource.time = 0;
        engine.start();

        for (i in 0...10) {
            timeSource.time = i * i;
            renderTarget.dispatchEvent(new Event(Event.ENTER_FRAME));

            var frame = Math.floor(timeSource.time / frameInterval);
            assertEquals(frame + 1, playfield.updateCount);
            assertEquals(frame, playfield.updateFrame);
        }
    }
}
