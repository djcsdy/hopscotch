package hopscotch.build.project;

class ProjectFileInvalidXmlException extends ProjectFileException {
    public function new(e:Dynamic) {
        super(Std.string(e));
    }
}
