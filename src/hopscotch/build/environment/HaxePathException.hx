package hopscotch.build.environment;

import hopscotch.build.BuildException;

class HaxePathException extends BuildException {
    private function new(message:String) {
        super(message, "Hopscotch uses the HAXEPATH environment variable to "
                + "determine the location of the Haxe compiler and tools. You "
                + "must set the HAXEPATH environment variable to the directory "
                + "where Haxe is installed.\n"
                + "\n"
                + "For example:\n"
                + "\n"
                + if (Sys.systemName() == "Windows") "SET HAXEPATH=C:\\Motion-Twin\\haxe\n"
                else "export HAXEPATH=/home/user/haxe\n"
                + "\n");
    }
}
