package net.noiseinstitute.hopscotch.engine {
	import asmock.framework.Expect;
	import asmock.framework.MockRepository;
	import asmock.framework.SetupResult;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.text.engine.RenderingMode;
	
	import net.noiseinstitute.hopscotch.render.IRenderer;
	import net.noiseinstitute.hopscotch.test.TestCaseWithMocks;
	import net.noiseinstitute.hopscotch.update.IUpdater;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class HsEngineTest extends TestCaseWithMocks {
		
		private var mocker :MockRepository;
		private var frameEventDispatcher :IEventDispatcher;
		private var timeSource :ITimeSource;
		private var updater :IUpdater;
		private var renderer :IRenderer;
		private var engine :HsEngine;
		
		
		public function HsEngineTest () {
			super(ITimeSource, IUpdater, IRenderer);
		}
		
		[Before]
		public function setup () :void {
			mocker = new MockRepository();
			frameEventDispatcher = new EventDispatcher();
			timeSource = mocker.createStub(ITimeSource) as ITimeSource;
			updater = mocker.createStub(IUpdater) as IUpdater;
			renderer = mocker.createStub(IRenderer) as IRenderer;
			engine = new HsEngine(frameEventDispatcher, timeSource);
		}
		
		[Test]
		public function testFrameEventDispatcherMustNotBeNull () :void {
			var caught:Boolean = false;
			try {
				new HsEngine(null, timeSource);
			} catch (e:TypeError) {
				caught = true;
			}
			Assert.assertTrue(caught);
		}
		
		[Test]
		public function testUpdateIsCalledExpectedNumberOfTimes () :void {
			SetupResult.forCall(timeSource.getTime()).returnValue(0);
			Expect.call(updater.update()).repeat.once();
			mocker.replayAll();
			
			var updateIntervalMs:Number = engine.updateIntervalMs;
			engine.addUpdater(updater);
			engine.start();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
			
			mocker.backToRecord(updater);
			Expect.notCalled(updater.update());
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(updater);
			SetupResult.forCall(timeSource.getTime()).returnValue(updateIntervalMs);
			Expect.call(updater.update()).repeat.never();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(updater);
			SetupResult.forCall(timeSource.getTime()).returnValue(updateIntervalMs*4);
			Expect.call(updater.update()).repeat.twice();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
			
			mocker.backToRecord(updater);
			Expect.notCalled(updater.update());
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
		}
		
		[Test]
		public function testRenderIsCalledWithExpectedTweenFactor () :void {
			SetupResult.forCall(timeSource.getTime()).returnValue(0);
			Expect.call(renderer.render(0)).repeat.once();
			mocker.replayAll();
			
			var updateIntervalMs:Number = engine.updateIntervalMs;
			engine.addRenderer(renderer);
			engine.start();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(renderer);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(renderer);
			SetupResult.forCall(timeSource.getTime()).returnValue(0.5 * updateIntervalMs);
			Expect.call(renderer.render(0.5)).repeat.twice();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(renderer);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(renderer);
			SetupResult.forCall(timeSource.getTime()).returnValue(updateIntervalMs);
			Expect.call(renderer.render(0)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(renderer);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(renderer);
			SetupResult.forCall(timeSource.getTime()).returnValue(1.75 * updateIntervalMs);
			Expect.call(renderer.render(0.75)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(renderer);
		}
		
		[Test]
		public function testUpdateAndRenderAreCalledInCorrectOrder () :void {
			for each (var frameIntervalMs:int in [1, 10, 17]) {
				var updateIntervalMs:Number = engine.updateIntervalMs;
				var numUpdatesToSimulate:int = 3;
				var totalDurationMs:int = 3*updateIntervalMs;
				var expectedNumCallsToRender:int = Math.floor(totalDurationMs/frameIntervalMs);
				
				var numTimesUpdateHasBeenCalled:int = 0;
				var numTimesUpdateHadBeenCalledOnLastRender:int = 0;
				var lastRenderTweenFactor:Number = 0;
				
				mocker.backToRecord(updater);
				mocker.backToRecord(renderer);
				
				Expect.call(updater.update()).
						repeat.times(numUpdatesToSimulate, numUpdatesToSimulate).
						doAction(function () :void {
							++numTimesUpdateHasBeenCalled;
						});
				
				Expect.call(renderer.render(0)).
						ignoreArguments().
						repeat.times(expectedNumCallsToRender, expectedNumCallsToRender).
						doAction(function (tweenFactor:Number) :void {
							if (tweenFactor < lastRenderTweenFactor) {
								Assert.assertTrue(numTimesUpdateHasBeenCalled >
										numTimesUpdateHadBeenCalledOnLastRender);
							}
							lastRenderTweenFactor = tweenFactor;
							numTimesUpdateHadBeenCalledOnLastRender =
									numTimesUpdateHasBeenCalled;
						});
				
				mocker.replayAll();
				
				engine.addUpdater(updater);
				engine.addRenderer(renderer);
				engine.start();
				
				var  time:Number = 0;
				while (time < totalDurationMs) {
					mocker.backToRecord(timeSource);
					SetupResult.forCall(timeSource.getTime()).returnValue(time);
					mocker.replay(timeSource);
					
					frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
					time += frameIntervalMs;
				}
				mocker.verify(updater);
				mocker.verify(renderer);
			}
		}
		
		[Test]
		public function testThatUpdateAndRenderAreCalledCorrectlyAfterChangingUpdateInterval () :void {
			SetupResult.forCall(timeSource.getTime()).returnValue(0);
			Expect.call(updater.update()).repeat.once();
			Expect.call(renderer.render(0)).repeat.once();
			mocker.replayAll();
			
			var defaultUpdateIntervalMs:Number = engine.updateIntervalMs;
			engine.addUpdater(updater);
			engine.addRenderer(renderer);
			engine.start();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
			mocker.verify(renderer);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(updater);
			mocker.backToRecord(renderer);
			SetupResult.forCall(timeSource.getTime()).returnValue(defaultUpdateIntervalMs * 0.5);
			Expect.notCalled(updater.update());
			Expect.call(renderer.render(0.5)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
			mocker.verify(renderer);
			
			mocker.backToRecord(updater);
			mocker.backToRecord(renderer);
			Expect.notCalled(updater.update());
			Expect.call(renderer.render(0.25)).repeat.once();
			mocker.replayAll();
			
			engine.updateIntervalMs = defaultUpdateIntervalMs * 2;
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
			mocker.verify(renderer);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(updater);
			mocker.backToRecord(renderer);
			SetupResult.forCall(timeSource.getTime()).returnValue(defaultUpdateIntervalMs);
			Expect.notCalled(updater.update());
			Expect.call(renderer.render(0.5)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
			mocker.verify(renderer);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(updater);
			mocker.backToRecord(renderer);
			SetupResult.forCall(timeSource.getTime()).returnValue(defaultUpdateIntervalMs * 2);
			Expect.call(updater.update()).repeat.once();
			Expect.call(renderer.render(0));
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
			mocker.verify(renderer);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(updater);
			mocker.backToRecord(renderer);
			SetupResult.forCall(timeSource.getTime()).returnValue(defaultUpdateIntervalMs * 2.5);
			Expect.notCalled(updater.update());
			Expect.call(renderer.render(0.5)).repeat.once();
			mocker.replayAll();
			
			engine.updateIntervalMs = defaultUpdateIntervalMs;
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
			mocker.verify(renderer);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(updater);
			mocker.backToRecord(renderer);
			SetupResult.forCall(timeSource.getTime()).returnValue(defaultUpdateIntervalMs * 3);
			Expect.call(updater.update()).repeat.once();
			Expect.call(renderer.render(0)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updater);
			mocker.verify(renderer);
		}
		
	}
	
}