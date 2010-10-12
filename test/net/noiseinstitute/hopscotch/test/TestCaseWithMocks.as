package net.noiseinstitute.hopscotch.test {
	import asmock.framework.MockRepository;
	
	import flash.events.Event;
	
	import org.flexunit.async.Async;
	
	public class TestCaseWithMocks {		
		
		private var mockClasses :Array;
		
		public function TestCaseWithMocks (...mockClasses) {
			this.mockClasses = mockClasses;
		}
		
		[Before(order=-1000, async, timeout=5000)]
		public function prepareMocks () :void {
			var mocker:MockRepository = new MockRepository();
			Async.proceedOnEvent(this,
				mocker.prepare(mockClasses),
				Event.COMPLETE);
		}
		
	}
	
}