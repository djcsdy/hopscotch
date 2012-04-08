package hopscotch.debug;

class PerformanceInfo {
    public var targetFramesPerSecond:Float;
    public var updateFramesPerSecond:Float;
    public var renderFramesPerSecond:Float;

    public var systemTimeMs:Float;
    public var updateTimeMs:Float;
    public var graphicUpdateTimeMs:Float;
    public var renderTimeMs:Float;

    public function new() {
        targetFramesPerSecond = 0;
        updateFramesPerSecond = 0;
        renderFramesPerSecond = 0;

        updateTimeMs = 0;
        graphicUpdateTimeMs = 0;
        renderTimeMs = 0;
        systemTimeMs = 0;
    }
}
