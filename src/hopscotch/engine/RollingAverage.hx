package hopscotch.engine;

class RollingAverage {
    var i:Int;
    var samples:Array<Float>;
    var samplesCount:Int;
    var maxSamplesCount:Int;
    var runningTotal:Float;

    public function new (samplesCount:Int) {
        i = 0;
        samples = [];
        this.samplesCount = 0;
        maxSamplesCount = samplesCount;
        runningTotal = 0;

        for (i in 0...samplesCount) {
            samples[i] = 0;
        }
    }

    public function push (value:Float) {
        if (samplesCount == maxSamplesCount) {
            runningTotal -= samples[i];
        } else {
            ++samplesCount;
        }

        samples[i] = value;
        runningTotal += value;

        i = (i + 1) % maxSamplesCount;
    }

    public function average ():Float {
        if (samplesCount == 0) {
            return 0;
        } else {
            return runningTotal / samplesCount;
        }
    }
}
