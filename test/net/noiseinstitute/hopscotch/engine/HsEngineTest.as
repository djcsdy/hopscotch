package net.noiseinstitute.hopscotch.engine {
	import asmock.framework.Expect;
	import asmock.framework.MockRepository;
	import asmock.framework.SetupResult;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.text.engine.RenderingMode;
	
	import net.noiseinstitute.hopscotch.render.IRenderManager;
	import net.noiseinstitute.hopscotch.test.TestCaseWithMocks;
	import net.noiseinstitute.hopscotch.update.IUpdateManager;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class HsEngineTest extends TestCaseWithMocks {
		
		private var mocker :MockRepository;
		private var frameEventDispatcher :IEventDispatcher;
		private var timeSource :ITimeSource;
		private var updateManager :IUpdateManager;
		private var renderManager :IRenderManager;
		private var engine :HsEngine;
		
		
		public function HsEngineTest () {
			super(ITimeSource, IUpdateManager, IRenderManager);
		}
		
		[Before]
		public function setup () :void {
			mocker = new MockRepository();
			frameEventDispatcher = new EventDispatcher();
			timeSource = mocker.createStub(ITimeSource) as ITimeSource;
			updateManager = mocker.createStub(IUpdateManager) as IUpdateManager;
			renderManager = mocker.createStub(IRenderManager) as IRenderManager;
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
			Expect.call(updateManager.update()).repeat.once();
			mocker.replayAll();
			
			var updateIntervalMs:Number = engine.updateIntervalMs;
			engine.addUpdateManager(updateManager);
			engine.start();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updateManager);
			
			mocker.backToRecord(updateManager);
			Expect.notCalled(updateManager.update());
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updateManager);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(updateManager);
			SetupResult.forCall(timeSource.getTime()).returnValue(updateIntervalMs);
			Expect.call(updateManager.update()).repeat.never();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updateManager);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(updateManager);
			SetupResult.forCall(timeSource.getTime()).returnValue(updateIntervalMs*4);
			Expect.call(updateManager.update()).repeat.twice();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updateManager);
			
			mocker.backToRecord(updateManager);
			Expect.notCalled(updateManager.update());
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(updateManager);
		}
		
		[Test]
		public function testRenderIsCalledWithExpectedTweenFactor () :void {
			SetupResult.forCall(timeSource.getTime()).returnValue(0);
			Expect.call(renderManager.render(0)).repeat.once();
			mocker.replayAll();
			
			var updateIntervalMs:Number = engine.updateIntervalMs;
			engine.addRenderManager(renderManager);
			engine.start();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(renderManager);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(renderManager);
			SetupResult.forCall(timeSource.getTime()).returnValue(0.5 * updateIntervalMs);
			Expect.call(renderManager.render(0.5)).repeat.twice();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(renderManager);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(renderManager);
			SetupResult.forCall(timeSource.getTime()).returnValue(updateIntervalMs);
			Expect.call(renderManager.render(0)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(renderManager);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(renderManager);
			SetupResult.forCall(timeSource.getTime()).returnValue(1.75 * updateIntervalMs);
			Expect.call(renderManager.render(0.75)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(renderManager);
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
				
				mocker.backToRecord(updateManager);
				mocker.backToRecord(renderManager);
				
				Expect.call(updateManager.update()).
						repeat.times(numUpdatesToSimulate, numUpdatesToSimulate).
						doAction(function () :void {
							++numTimesUpdateHasBeenCalled;
						});
				
				Expect.call(renderManager.render(0)).
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
				
				engine.addUpdateManager(updateManager);
				engine.addRenderManager(renderManager);
				engine.start();
				
				var  time:Number = 0;
				while (time < totalDurationMs) {
					mocker.backToRecord(timeSource);
					SetupResult.forCall(timeSource.getTime()).returnValue(time);
					mocker.replay(timeSource);
					
					frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
					time += frameIntervalMs;
				}
				mocker.verify(updateManager);
				mocker.verify(renderManager);
			}
		}
		
	}
	
}