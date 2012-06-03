package hopscotch.math;

import hopscotch.errors.ArgumentError;

class Range {
    private function new () {}

    public static inline function clampInt (n:Int, min:Int, max:Int) {
        if (min > max) {
            throw new ArgumentError("min must be <= max");
        }
        return if (n < min) min
        else if (n > max) max
        else n;
    }

    public static inline function clampFloat (n:Float, min:Float, max:Float) {
        if (min > max) {
            throw new ArgumentError("min must be <= max");
        }
        return if (n < min) min
        else if (n > max) max
        else n;
    }

    public static inline function wrapInt (n:Int, min:Int, max:Int) {
        if (min > max) {
            throw new ArgumentError("min must be <= max");
        }

        if (n < min) {
            var result = max - ((min - n) % (max - min));
            if (result == max) {
                return min;
            } else {
                return result;
            }
        } else if (n >= max) {
            return min + ((n - min) % (max - min));
        } else {
            return n;
        }
    }

    public static inline function wrapFloat (n:Float, min:Float, max:Float) {
        if (min > max) {
            throw new ArgumentError("min must be <= max");
        }

        if (n < min) {
            var result = max - ((min - n) % (max - min));
            if (result == max) {
                return min;
            } else {
                return result;
            }
        } else if (n >= max) {
            return min + ((n - min) % (max - min));
        } else {
            return n;
        }
    }
}
