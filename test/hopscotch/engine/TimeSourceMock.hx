package hopscotch.engine;

class TimeSourceMock implements ITimeSource {
    public var time:Int;

    public function new() {
        time = 0;
    }

    public function getTime() {
        return time;
    }
}
