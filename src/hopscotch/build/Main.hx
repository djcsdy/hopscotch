package hopscotch.build;

import hopscotch.build.project.Project;
import hopscotch.build.environment.BuildEnvironment;

class Main {
    static function main() {
        try {
            var environment = BuildEnvironment.initialize();
            var project = Project.load(Sys.getCwd());
        } catch (e:BuildException) {
            var stderr = Sys.stderr();
            stderr.writeString("Error: " + e.message + "\n");
            stderr.writeString("\n");
            if (e.help != null) {
                stderr.writeString(e.help + "\n");
                stderr.writeString("\n");
            }

            Sys.exit(1);
        }

        Sys.exit(0);
    }
}
