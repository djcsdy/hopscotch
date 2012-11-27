package hopscotch.build;

class BuildException {
    public var message(default, null):String;
    public var help(default, null):String;

    public function new(message:String, help:String = null) {
        this.message = message;
        this.help = help;
    }

    public function toString() {
        return message;
    }
}
