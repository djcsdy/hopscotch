package hopscotch.errors;

class IllegalOperationError extends Error {
    public function new (message:String) {
        super(message);
    }
}