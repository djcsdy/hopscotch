package net.noiseinstitute.hopscotch.engine {
	import asmock.framework.Expect;
	import asmock.framework.MockRepository;
	import asmock.framework.SetupResult;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import net.noiseinstitute.hopscotch.update.IUpdater;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	public class HsEngineTest {
		
		private var mocker :MockRepository;
		private var frameEventDispatcher :IEventDispatcher;
		private var timeSource :ITimeSource;
		private var updater :IUpdater;
		private var engine :HsEngine;
		
		
		[Before(async, timeout=5000)]
		public function prepareMocks () :void {
			mocker = new MockRepository();
			Async.handleEvent(this,
					mocker.prepare([ITimeSource, IUpdater]),
					Event.COMPLETE,
					function () :void {
						frameEventDispatcher = new EventDispatcher();
						timeSource = mocker.createStub(ITimeSource) as ITimeSource;
						updater = mocker.createStub(IUpdater) as IUpdater;
						engine = new HsEngine(frameEventDispatcher, timeSource);
					});
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
			Expect.call(updater.update());
			mocker.replayAll();
			
			var updateIntervalMs:Number = 10;
			engine.updateIntervalMs = updateIntervalMs;
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
		
	}
	
}