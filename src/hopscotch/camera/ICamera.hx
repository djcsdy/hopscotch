package hopscotch.camera;

import flash.geom.Matrix;

interface ICamera {
    function update(frame:Int, matrix:Matrix):Void;
}
