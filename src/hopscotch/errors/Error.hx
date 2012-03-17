package hopscotch.errors;

class Error {
    public var message:String;

    public function new (message:String) {
        this.message = message;
    }

    public function toString ():String {
        return message;
    }
}