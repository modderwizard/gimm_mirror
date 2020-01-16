package lib.mirror.level.tile
{
	import lib.mirror.Assets;
	import lib.mirror.GameSettings;
	import lib.mirror.entity.Ability;
	import lib.mirror.entity.Entity;
	
	public class TileTrigger extends Tile
	{
		public function TileTrigger(metadata:int)
		{
			super(metadata, null);
		}
		
		public override function isSolid():Boolean
		{
			return false;
		}
		
		public override function onEntityCollide(entity:Entity, side:String):void
		{
			if(entity.hasAbility(Ability.ACTIVATE_TRIGGERS))
			{
				entity.level.onTriggered(this.metadata);
			}
		}
	}
}