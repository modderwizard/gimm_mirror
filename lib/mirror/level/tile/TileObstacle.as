package lib.mirror.level.tile
{
	import lib.mirror.entity.Entity;
	
	public class TileObstacle extends Tile
	{
		private var missState:Class;
		
		public function TileObstacle(metadata:int, missState:Class, onlyTexture:String = null)
		{
			super(metadata, onlyTexture);
			
			this.missState = missState;
		}
		
		public override function isSolid():Boolean
		{
			return false;
		}
		
		public override function onEntityCollide(entity:Entity, side:String):void
		{
			if(this.missState == null || !(entity.getState() is this.missState))
			{
				entity.onAttacked(null);
			}
		}
	}
}