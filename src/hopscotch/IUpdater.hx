package hopscotch;

interface IUpdater {
    function begin(frame:Int):Void;
    function end():Void;
    function update(frame:Int):Void;
}