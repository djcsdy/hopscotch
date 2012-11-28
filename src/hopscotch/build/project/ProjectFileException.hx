package hopscotch.build.project;

import hopscotch.build.BuildException;

class ProjectFileException extends BuildException {
    private function new(message:String, help:String = null) {
        super(message, help);
    }
}
