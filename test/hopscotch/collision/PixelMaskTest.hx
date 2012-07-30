package hopscotch.collision;

import hopscotch.errors.ArgumentNullError;
import haxe.unit.TestCase;
class PixelMaskTest extends TestCase {
    public function new() {
        super();
    }

    public function testConstructorRejectsNull() {
        var caught = false;
        try {
            new PixelMask(null);
        } catch (e:ArgumentNullError) {
            caught = true;
        }
        assertTrue(caught);
    }
}
