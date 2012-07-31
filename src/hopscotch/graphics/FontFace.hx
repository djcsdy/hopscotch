package hopscotch.graphics;

import hopscotch.errors.ArgumentNullError;

class FontFace {
    public static var sans(default, null) = new FontFace("_sans", false);
    public static var serif(default, null) = new FontFace("_serif", false);

    public var name(default, null):String;
    public var embedded(default, null):Bool;

    public function new(name:String, embedded = true) {
        if (name == null) {
            throw new ArgumentNullError("name");
        }

        this.name = name;
        this.embedded = embedded;
    }
}
