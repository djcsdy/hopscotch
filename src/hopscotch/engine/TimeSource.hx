package hopscotch.engine;

class TimeSource implements ITimeSource {
    public function new () { }

    public function getTime () {
        return flash.Lib.getTimer();
    }
}