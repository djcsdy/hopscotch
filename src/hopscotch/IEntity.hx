package hopscotch;

import hopscotch.collision.Mask;
import hopscotch.graphics.IGraphic;

interface IEntity extends IUpdater extends IGraphic {
    function collideEntity(entity:IEntity):Bool;
    function collideMask(mask:Mask, maskX:Float, maskY:Float):Bool;
}
