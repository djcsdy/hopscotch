package hopscotch.build;

import haxe.macro.Compiler;
import haxe.macro.Expr.ExprOf;

class Runner {
    public static function run(haxePath:String, projectPath:String) {
        Compiler.addClassPath(projectPath);
        var projectDefinition = new ProjectDefinition();
        Project.define(projectDefinition);
    }
}
