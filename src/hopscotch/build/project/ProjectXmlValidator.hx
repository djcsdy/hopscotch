package hopscotch.build.project;

import haxe.xml.Check;

class ProjectXmlValidator {
    private var rule:Rule;

    public function new() {
        var pathRule = RMulti(
            RNode("path", [], RData())
        );

        rule = RNode("project", [],
            RMulti(
                RNode("module", [Attrib.Att("src", null, "")],
                    RList([
                        RNode("target", [],
                            RChoice([
                                RNode("application", [],
                                    RNode("main", [], RData())
                                    // TODO more
                                ),
                                RNode("library") // TODO
                            ])
                        ),
                        RNode("classpath", [], pathRule),
                        ROptional(RNode("assetpath", [], pathRule)),
                        ROptional(RNode("dependencies", [],
                            RMulti(
                                RChoice([
                                    RNode("module"), // TODO
                                    RNode("haxelib") // TODO
                                ])
                            )
                        ))
                    ])
                )
            )
        );
    }

    public function validate(projectXml:Xml) {
        Check.checkDocument(projectXml, rule);
    }
}
