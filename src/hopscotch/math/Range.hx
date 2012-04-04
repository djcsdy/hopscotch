package hopscotch.math;

import hopscotch.errors.ArgumentError;

class Range<T:(Float)> {
    public static inline var int = _int;
    public static inline var float = _float;

    private static var _int = new Range<Int>();
    private static var _float = new Range<Float>();

    private function new() {}

    public inline function clamp(n:T, min:T, max:T):T {
        if (min > max) {
            throw new ArgumentError("min must be <= max");
        }
        return if (n < min) min
        else if (n > max) max
        else n;
    }

    public inline function wrap(n:T, min:T, max:T):T {
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
