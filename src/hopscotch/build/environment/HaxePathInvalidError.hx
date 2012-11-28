package hopscotch.build.environment;

class HaxePathInvalidError extends HaxePathError {
    public function new() {
        super("HAXEPATH environment variable is invalid.");
    }
}
