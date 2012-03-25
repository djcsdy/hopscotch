package hopscotch.errors;

class Error {
    public var message:String;

    public function new (message:String) {
        this.message = message;
    }

    public function toString ():String {
        return if (message == null) "Unknown " + Type.getClassName(Type.getClass(this))
                else Type.getClassName(Type.getClass(this)) + ": " + message;
    }
}