package hopscotch.build.project;

class ProjectFileInvalidXmlError extends ProjectFileError {
    public function new(e:Dynamic) {
        super(Std.string(e));
    }
}
