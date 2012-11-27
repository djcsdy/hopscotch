import haxe.io.Path;
import sys.FileSystem;

class Build {
    public static function main() {
        var haxePath = Sys.getEnv("HAXEPATH");

        if (haxePath == null || haxePath == "") {
            haxePathError("HAXEPATH environment variable is not set.");
            Sys.exit(1);
        }

        var haxeBinName = "haxe" + if (Sys.systemName() == "Windows") ".exe" else "";
        var haxeBinPath = haxePath + "/" + haxeBinName;
        if (!FileSystem.exists(haxeBinPath) || FileSystem.isDirectory(haxeBinPath)) {
            haxePathError("HAXEPATH environment variable is invalid.");
            Sys.exit(1);
        }

        var hopscotchDir = Path.directory(FileSystem.fullPath(neko.vm.Module.local().name));
        var hopscotchSrcDir = hopscotchDir + "/src";

        Sys.command(haxeBinPath, ["-cp", hopscotchSrcDir, "--macro", "ImportAll.run()", "--no-output",
                "-swf-version", "9", "-swf", "hopscotch.swf", "-xml", "haxedoc.swf.xml"]);
    }

    static function haxePathError(message:String) {
        Sys.stderr().writeString(message + "\n");
        Sys.stderr().writeString("\n");
        Sys.stderr().writeString("You must set the HAXEPATH environment variable to the directory where Haxe is\n");
        Sys.stderr().writeString("installed.\n");
        Sys.stderr().writeString("\n");
        Sys.stderr().writeString("For example:\n");
        Sys.stderr().writeString("\n");
        if (Sys.systemName() == "Windows") {
            Sys.stderr().writeString("SET HAXEPATH=C:\\Motion-Twin\\haxe\n");
        } else {
            Sys.stderr().writeString("export HAXEPATH=/home/user/haxe\n");
        }
        Sys.stderr().writeString("\n");
    }
}