package hopscotch.build.project;

import hopscotch.build.BuildError;

class ProjectFileError extends BuildError {
    private function new(message:String, help:String = null) {
        super(message, help);
    }
}
