package lib.mirror.level.tile
{
	import lib.mirror.Assets;
	
	public class TileFlowerPot extends TileObstaclePowerable
	{
		public function TileFlowerPot(metadata:int)
		{
			super(metadata, "Flower_Pot");
			
			this.boundingBox = this.boundingBox.fromPositionAndSize(0, 0, 18, 36);
			
			this.yOffset = -20;
		}
	}
}