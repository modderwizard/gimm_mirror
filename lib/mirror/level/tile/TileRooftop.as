package lib.mirror.level.tile
{
	import lib.mirror.Assets;
	
	public class TileRooftop extends Tile
	{
		public function TileRooftop(metadata:int)
		{
			super(metadata);
			
			if(metadata < 6)
			{
				this.addChild(Assets.getQuadWithTexture("Tile_Rooftop_Day_0" + metadata));
			}
			else
			{
				this.addChild(Assets.getQuadWithTexture("Tile_Rooftop_Night_0" + (metadata - 6)));
			}
		}
	}
}