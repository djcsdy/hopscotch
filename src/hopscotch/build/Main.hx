package hopscotch.build;

import sys.FileSystem;
import haxe.io.Path;

class Main {
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

        var projectDir = Sys.getCwd();
        var projectFile:String = null;
        while (projectDir != "" && projectFile == null) {
            projectFile = projectDir + "/" + "Project.hx";
            if (!FileSystem.exists(projectFile) || FileSystem.isDirectory(projectFile)) {
                projectFile = null;
                projectDir = Path.directory(projectDir);
            }
        }

        if (projectFile == null) {
            Sys.stderr().writeString("Project.hx not found.\n");
            Sys.stderr().writeString("\n");
            Sys.exit(2);
        }

        var hopscotchDir = Path.directory(FileSystem.fullPath(neko.vm.Module.local().name));
        var buildRunnerFileName = "hopscotch/build/Runner.hx";
        var buildRunnerFilePath = hopscotchDir + "/" + buildRunnerFileName;
        if (!FileSystem.exists(buildRunnerFilePath)
                || FileSystem.isDirectory(buildRunnerFilePath)) {
            hopscotchDir += "/src";
            if (FileSystem.isDirectory(hopscotchDir)) {
                buildRunnerFilePath = hopscotchDir + "/" + buildRunnerFileName;
                if (!FileSystem.exists(buildRunnerFilePath)
                        || FileSystem.isDirectory(buildRunnerFilePath)) {
                    buildRunnerFilePath = null;
                }
            } else {
                buildRunnerFilePath = null;
            }
        }

        if (buildRunnerFilePath == null) {
            Sys.stderr().writeString("Can't find hopscotch build system.\n");
            Sys.stderr().writeString("\n");
            Sys.exit(3);
        }

        var escapedHaxePath = ~/(["'\\])/g.replace(haxePath, "\\$1");
        var escapedProjectDir = ~/(["'\\])/g.replace(projectDir, "\\$1");

        Sys.command(haxeBinPath, ["-cp", hopscotchDir, "--macro",
                "hopscotch.build.Runner.run('" + escapedHaxePath
                + "', '" + escapedProjectDir + "')"]);
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
