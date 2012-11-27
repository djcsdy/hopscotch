package hopscotch.build.environment;

class HaxePathNotSetException extends HaxePathException {
    public function new() {
        super("HAXEPATH environment variable is not set.");
    }
}
