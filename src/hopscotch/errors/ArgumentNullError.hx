package hopscotch.errors;

class ArgumentNullError extends ArgumentError {
    public var name(default, null):String;

    public function new (name:String) {
        super(if (name == null) "An argument is null."
        else name + " is null.");

        this.name = name;
    }
}
