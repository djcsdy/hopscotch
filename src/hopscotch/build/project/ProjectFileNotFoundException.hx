package hopscotch.build.project;

class ProjectFileNotFoundException extends ProjectFileException {
    public function new() {
        super("project.xml not found");
    }
}
