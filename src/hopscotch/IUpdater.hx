package hopscotch;

interface IUpdater {
    var active:Bool;
    function begin(frame:Int):Void;
    function end():Void;
    function update(frame:Int):Void;
}