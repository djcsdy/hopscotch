package hopscotch.build;

import hopscotch.errors.Error;

class BuildError extends Error {
    public var help(default, null):String;

    public function new(message:String, help:String = null) {
        super(message);
        this.help = help;
    }
}
