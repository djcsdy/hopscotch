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

    public function testUpdateAndRenderAreCalledAsExpected () {
        var width = 640;
        var height = 480;

        var fps = 60;
        var framesPerMillisecond = 60 / 1000;

        var renderTarget = new Sprite();
        var timeSource = new TimeSourceMock();
        var engine = new Engine(renderTarget, width, height, fps, timeSource);

        var playfield = new PlayfieldMock();
        engine.playfield = playfield;

        timeSource.time = 0;
        engine.start();

        var lastFrame = -1;
        var lastRenderCount = 0;

        for (i in 0...40) {
            timeSource.time = i * i;
            renderTarget.dispatchEvent(new Event(Event.ENTER_FRAME));

            var frame = Math.round(timeSource.time * framesPerMillisecond);

            assertEquals(frame + 1, playfield.updateCount);
            assertEquals(frame, playfield.updateFrame);

            assertEquals(frame + 1, playfield.updateGraphicCount);
            assertEquals(frame, playfield.updateGraphicFrame);

            assertEquals(width, playfield.screenWidth);
            assertEquals(height, playfield.screenHeight);

            if (frame > lastFrame) {
                assertEquals(++lastRenderCount, playfield.renderCount);
                lastFrame = frame;
            } else {
                assertEquals(lastRenderCount, playfield.renderCount);
            }
            assertEquals(frame, playfield.renderFrame);

            assertFalse(playfield.renderTarget == null);

            assertFalse(playfield.renderPosition == null);
            assertEquals(0.0, playfield.renderPosition.x);
            assertEquals(0.0, playfield.renderPosition.y);

            assertFalse(playfield.renderCamera == null);
            assertEquals(1.0, playfield.renderCamera.a);
            assertEquals(0.0, playfield.renderCamera.b);
            assertEquals(0.0, playfield.renderCamera.c);
            assertEquals(1.0, playfield.renderCamera.d);
            assertEquals(0.0, playfield.renderCamera.tx);
            assertEquals(0.0, playfield.renderCamera.ty);
        }
    }

    public function testEngineSkipsUpdatesIfThereIsAnExcessiveDelayBetweenFrames() {
        var width = 640;
        var height = 480;

        var fps = 60;
        var framesPerMillisecond = 60 / 1000;

        var renderTarget = new Sprite();
        var timeSource = new TimeSourceMock();
        var engine = new Engine(renderTarget, width, height, fps, timeSource);

        var playfield = new PlayfieldMock();
        engine.playfield = playfield;

        timeSource.time = 0;
        engine.start();

        timeSource.time = 0;
        renderTarget.dispatchEvent(new Event(Event.ENTER_FRAME));

        assertEquals(1, playfield.updateCount);
        assertEquals(0, playfield.updateFrame);

        assertEquals(1, playfield.renderCount);
        assertEquals(0, playfield.renderFrame);

        timeSource.time = Math.ceil(7 * 1000 / fps);
        renderTarget.dispatchEvent(new Event(Event.ENTER_FRAME));

        assertEquals(6, playfield.updateCount);
        assertEquals(5, playfield.updateFrame);

        assertEquals(2, playfield.renderCount);
        assertEquals(5, playfield.renderFrame);

        timeSource.time = Math.ceil(8 * 1000 / fps);
        renderTarget.dispatchEvent(new Event(Event.ENTER_FRAME));

        assertEquals(7, playfield.updateCount);
        assertEquals(6, playfield.updateFrame);

        assertEquals(3, playfield.renderCount);
        assertEquals(6, playfield.renderFrame);

        timeSource.time = Math.ceil(9 * 1000 / fps);
        renderTarget.dispatchEvent(new Event(Event.ENTER_FRAME));

        assertEquals(8, playfield.updateCount);
        assertEquals(7, playfield.updateFrame);

        assertEquals(4, playfield.renderCount);
        assertEquals(7, playfield.renderFrame);
    }
}
