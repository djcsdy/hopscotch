package hopscotch.build.environment;

class HaxePathNotSetError extends HaxePathError {
    public function new() {
        super("HAXEPATH environment variable is not set.");
    }
}
