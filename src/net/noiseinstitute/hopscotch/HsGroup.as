package net.noiseinstitute.hopscotch {
	import flash.events.IEventDispatcher;
	
	import org.flixel.FlxObject;
	
	public class HsGroup extends FlxObject {
		
		private var members:Vector.<FlxObject>;
		private var defunctMemberIndices:Vector.<uint>;
		private var extantMemberIndices:Object;
		private var numExtantMembers:uint;
		
		public function HsGroup () {
			super();
			members = new Vector.<FlxObject>();
			defunctMemberIndices = new Vector.<uint>();
			extantMemberIndices = new Object();
			numExtantMembers = 0;
		}
		
		public function add (object:FlxObject) :void {
			var i = members.length;
			members[i] = object;
			
			if (object.exists) {
				extantMemberIndices[i] = i;
				numExtantMembers++;
			} else {
				defunctMemberIndices.push(i);
			}
			
			object.addInitializeEventListener(function () {
				if (!i in extantMemberIndices) {
					extantMemberIndices[i] = i;
					++numExtantMembers;
				}
			});
			
			object.addDefunctEventListener(function () {
				if (i in extantMemberIndices) {
					delete extantMemberIndices[i];
					defunctMemberIndices.push(i);
				}
				if (wasDead) {
					--numDeadMembers;
					wasDead = false;
				}
				if (wasAlive) {
					--numAliveMembers;
					wasAlive = false;
				}
			});
		}
		
		public function getInitializedMember () :FlxObject {
			if (defunctMemberIndices.length == 0) {
				return undefined;
			} else {
				var member:FlxObject = members[defunctMemberIndices.pop()];
				member.reset(0, 0);
				extantMemberIndices[i] = i;
				return member;
			}
		}
		
		override public function update () :void {
			for each (var i:uint in extantMemberIndices) {
				members[i].update();
			}
		}
		
		override public function render () :void {
			for each (var i:uint in extantMemberIndices) {
				members[i].render();
			}
		}
		
	}
}