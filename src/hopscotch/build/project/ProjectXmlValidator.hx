package hopscotch.build.project;

import haxe.xml.Check;

class ProjectXmlValidator {
    private var rule:Rule;

    public function new() {
        rule = Rule.RNode("project", [],
                Rule.RMulti(
                        Rule.RNode("module")));
    }

    public function validate(projectXml:Xml) {
        Check.checkDocument(projectXml, rule);
    }
}
