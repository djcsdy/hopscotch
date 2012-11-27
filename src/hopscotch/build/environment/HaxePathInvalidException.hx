package hopscotch.build.environment;

class HaxePathInvalidException extends HaxePathException {
    public function new() {
        super("HAXEPATH environment variable is invalid.");
    }
}
