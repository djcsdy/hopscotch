package hopscotch.math;

import flash.geom.Point;

class VectorMath {
    public static inline function add (v:Point, w:Point) {
        v.x += w.x;
        v.y += w.y;
    }

    public static inline function subtract (v:Point, w:Point) {
        v.x -= w.x;
        v.y -= w.y;
    }

    public static inline function dot (v:Point, w:Point) {
        return v.x * w.x + v.y * w.y;
    }

    public static inline function cross (v:Point, w:Point) {
        return v.x * w.y - v.y * w.x;
    }

    public static inline function scale (v:Point, s:Float) {
        v.x *= s;
        v.y *= s;
    }

    public static inline function negate (v:Point) {
        v.x = -v.x;
        v.y = -v.y;
    }

    public static inline function angle (v:Point) {
        if (v.x == 0 && v.y == 0) {
            return 0.0;
        } else {
            return Math.atan2(v.x, -v.y);
        }
    }

    public static inline function magnitude (v:Point) {
        return v.length;
    }

    public static inline function normalize (v:Point, length:Float = 1) {
        v.normalize(length);
    }

    public static inline function distance (v:Point, w:Point) {
        return Point.distance(v, w);
    }

    public static inline function rotate (v:Point, angle:Float) {
        var sin = Math.sin(angle);
        var cos = Math.cos(angle);
        var oldX = v.x;
        v.x = cos * v.x - sin * v.y;
        v.y = cos * v.y + sin * oldX;
    }

    public static inline function toUnitVector (v:Point, angle:Float) {
        v.x = Math.sin(angle);
        v.y = -Math.cos(angle);
    }

    public static inline function toPolar (v:Point, angle:Float, magnitude:Float) {
        v.x = Math.sin(angle) * magnitude;
        v.y = -Math.cos(angle) * magnitude;
    }
}
