package net.noiseinstitute.hopscotch.engine {
	import asmock.framework.Expect;
	import asmock.framework.LastCall;
	import asmock.framework.MockRepository;
	import asmock.framework.SetupResult;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import net.noiseinstitute.hopscotch.entities.Entity;
	import net.noiseinstitute.hopscotch.test.TestCaseWithMocks;
	
	import org.flexunit.Assert;
	
	public class EngineTest extends TestCaseWithMocks {
		
		private var mocker :MockRepository;
		private var frameEventDispatcher :IEventDispatcher;
		private var timeSource :ITimeSource;
		private var entity :Entity;
		private var engine :Engine;
		
		
		public function EngineTest () {
			super(ITimeSource, Entity);
		}
		
		[Before]
		public function setup () :void {
			mocker = new MockRepository();
			frameEventDispatcher = new EventDispatcher();
			timeSource = mocker.createStub(ITimeSource) as ITimeSource;
			entity = mocker.createStub(Entity) as Entity;
			engine = new Engine(frameEventDispatcher, timeSource);
		}
		
		[Test]
		public function testFrameEventDispatcherMustNotBeNull () :void {
			var caught:Boolean = false;
			try {
				new Engine(null, timeSource);
			} catch (e:TypeError) {
				caught = true;
			}
			Assert.assertTrue(caught);
		}
		
		[Test]
		public function testUpdateIsCalledExpectedNumberOfTimes () :void {
			SetupResult.forCall(timeSource.getTime()).returnValue(0);
			Expect.call(entity.update(null)).
					ignoreArguments().
					repeat.once();
			mocker.replayAll();
			
			var updateIntervalMs:Number = engine.updateIntervalMs;
			engine.addEntity(entity);
			engine.start();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(entity);
			Expect.notCalled(entity.update(null)).ignoreArguments();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(entity);
			SetupResult.forCall(timeSource.getTime()).returnValue(updateIntervalMs);
			Expect.call(entity.update(null)).
					ignoreArguments().
					repeat.never();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(entity);
			SetupResult.forCall(timeSource.getTime()).returnValue(updateIntervalMs*4);
			Expect.call(entity.update(null)).
					ignoreArguments().
					repeat.twice();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(entity);
			Expect.notCalled(entity.update(null)).ignoreArguments();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
		}
		
		[Test]
		public function testRenderIsCalledWithExpectedTweenFactor () :void {
			SetupResult.forCall(timeSource.getTime()).returnValue(0);
			Expect.call(entity.render(0)).repeat.once();
			mocker.replayAll();
			
			var updateIntervalMs:Number = engine.updateIntervalMs;
			engine.addEntity(entity);
			engine.start();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(entity);
			SetupResult.forCall(timeSource.getTime()).returnValue(0.5 * updateIntervalMs);
			Expect.call(entity.render(0.5)).repeat.twice();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(entity);
			SetupResult.forCall(timeSource.getTime()).returnValue(updateIntervalMs);
			Expect.call(entity.render(0)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(entity);
			SetupResult.forCall(timeSource.getTime()).returnValue(1.75 * updateIntervalMs);
			Expect.call(entity.render(0.75)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
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
				
				mocker.backToRecord(entity);
				
				Expect.call(entity.update(null)).
						ignoreArguments().
						repeat.times(numUpdatesToSimulate, numUpdatesToSimulate).
						doAction(function () :void {
							++numTimesUpdateHasBeenCalled;
						});
				
				Expect.call(entity.render(0)).
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
				
				engine.addEntity(entity);
				engine.start();
				
				var  time:Number = 0;
				while (time < totalDurationMs) {
					mocker.backToRecord(timeSource);
					SetupResult.forCall(timeSource.getTime()).returnValue(time);
					mocker.replay(timeSource);
					
					frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
					time += frameIntervalMs;
				}
				mocker.verify(entity);
			}
		}
		
		[Test]
		public function testThatUpdateAndRenderAreCalledCorrectlyAfterChangingUpdateInterval () :void {
			SetupResult.forCall(timeSource.getTime()).returnValue(0);
			Expect.call(entity.update(null)).
					ignoreArguments().
					repeat.once();
			Expect.call(entity.render(0)).repeat.once();
			mocker.replayAll();
			
			var defaultUpdateIntervalMs:Number = engine.updateIntervalMs;
			engine.addEntity(entity);
			engine.start();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(entity);
			SetupResult.forCall(timeSource.getTime()).returnValue(defaultUpdateIntervalMs * 0.5);
			Expect.notCalled(entity.update(null)).ignoreArguments();
			Expect.call(entity.render(0.5)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(entity);
			Expect.notCalled(entity.update(null)).ignoreArguments();
			Expect.call(entity.render(0.25)).repeat.once();
			mocker.replayAll();
			
			engine.updateIntervalMs = defaultUpdateIntervalMs * 2;
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(entity);
			SetupResult.forCall(timeSource.getTime()).returnValue(defaultUpdateIntervalMs);
			Expect.notCalled(entity.update(null)).ignoreArguments();
			Expect.call(entity.render(0.5)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(entity);
			SetupResult.forCall(timeSource.getTime()).returnValue(defaultUpdateIntervalMs * 2);
			Expect.call(entity.update(null)).
					ignoreArguments().
					repeat.once();
			Expect.call(entity.render(0));
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(entity);
			SetupResult.forCall(timeSource.getTime()).returnValue(defaultUpdateIntervalMs * 2.5);
			Expect.notCalled(entity.update(null)).ignoreArguments();
			Expect.call(entity.render(0.5)).repeat.once();
			mocker.replayAll();
			
			engine.updateIntervalMs = defaultUpdateIntervalMs;
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
			
			mocker.backToRecord(timeSource);
			mocker.backToRecord(entity);
			SetupResult.forCall(timeSource.getTime()).returnValue(defaultUpdateIntervalMs * 3);
			Expect.call(entity.update(null)).
					ignoreArguments().
					repeat.once();
			Expect.call(entity.render(0)).repeat.once();
			mocker.replayAll();
			
			frameEventDispatcher.dispatchEvent(new Event(Event.ENTER_FRAME));
			mocker.verify(entity);
		}
		
		[Test]
		public function testSetUpdatesPerSecond () :void {
			engine.updatesPerSecond = 1;
			Assert.assertEquals(1000, engine.updateIntervalMs);
			
			engine.updatesPerSecond = 2;
			Assert.assertEquals(500, engine.updateIntervalMs);
			
			engine.updatesPerSecond = 4;
			Assert.assertEquals(250, engine.updateIntervalMs);
			
			engine.updatesPerSecond = 50;
			Assert.assertEquals(20, engine.updateIntervalMs);
		}
		
	}
	
}