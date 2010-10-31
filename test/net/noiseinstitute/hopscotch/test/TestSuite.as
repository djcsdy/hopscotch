package net.noiseinstitute.hopscotch.test {
	import net.noiseinstitute.hopscotch.update.ActionQueueTest;
	import net.noiseinstitute.hopscotch.EntityTest;
	import net.noiseinstitute.hopscotch.geom.HsPointTest;
	import net.noiseinstitute.hopscotch.engine.EngineTest;
	import net.noiseinstitute.hopscotch.render.displayObject.DisplayObjectRendererTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite {
		public var engineTest :EngineTest;
		public var hsPointTest :HsPointTest;
		public var entityTest :EntityTest;
		public var displayObjectRendererTest :DisplayObjectRendererTest;
		public var actionQueueTest :ActionQueueTest;
	}
	
}