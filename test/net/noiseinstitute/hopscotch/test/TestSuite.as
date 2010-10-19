package net.noiseinstitute.hopscotch.test {
	import net.noiseinstitute.hopscotch.EntityTest;
	import net.noiseinstitute.hopscotch.HsPointTest;
	import net.noiseinstitute.hopscotch.engine.HsEngineTest;
	import net.noiseinstitute.hopscotch.render.displayObject.DisplayObjectRendererTest;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuite {
		public var hsEngineTest :HsEngineTest;
		public var hsPointTest :HsPointTest;
		public var entityTest :EntityTest;
		public var displayObjectRendererTest :DisplayObjectRendererTest;
	}
	
}