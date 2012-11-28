package hopscotch.build.project;

class ProjectFileNotFoundError extends ProjectFileError {
    public function new() {
        super("project.xml not found");
    }
}
