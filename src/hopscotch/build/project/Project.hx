package hopscotch.build.project;

import sys.FileSystem;
import sys.io.File;
import haxe.io.Path;
import haxe.xml.Parser;
import haxe.xml.Check;

class Project {
    public static function load(dir:String) {
        var projectDir = dir;
        var projectFile:String = null;
        while (projectDir != "" && projectFile == null) {
            projectFile = projectDir + "/project.xml";
            if (!FileSystem.exists(projectFile) || FileSystem.isDirectory(projectFile)) {
                projectFile = null;
                projectDir = Path.directory(projectDir);
            }
        }

        if (projectFile == null) {
            throw new ProjectFileNotFoundError();
        }

        var projectXmlString = File.getContent(projectFile);
        var projectXml:Xml;

        try {
            projectXml = Parser.parse(projectXmlString);
        } catch (e:Dynamic) {
            throw new ProjectFileInvalidXmlError(e);
        }

        var projectXmlValidator = new ProjectXmlValidator();
        try {
            projectXmlValidator.validate(projectXml);
        } catch (e:Dynamic) {
            throw new ProjectFileInvalidXmlError(e);
        }

        var project = new Project();
        // TODO modules
        return project;
    }

    private function new() {
    }
}
