package hopscotch.build.environment;

import sys.FileSystem;

class BuildEnvironment {
    private var haxePath:String;
    private var haxeBinPath:String;

    public static function initialize() {
        var haxePath = Sys.getEnv("HAXEPATH");

        if (haxePath == null || haxePath == "") {
            throw new HaxePathNotSetError();
        }

        var haxeBinName = "haxe" + if (Sys.systemName() == "Windows") ".exe" else "";
        var haxeBinPath = haxePath + "/" + haxeBinName;
        if (!FileSystem.exists(haxeBinPath) || FileSystem.isDirectory(haxeBinPath)) {
            throw new HaxePathInvalidError();
        }

        var environment = new BuildEnvironment();
        environment.haxePath = haxePath;
        environment.haxeBinPath = haxeBinPath;
        return environment;
    }

    private function new() {
    }
}
