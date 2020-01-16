package lib.mirror.level.tile
{
	import lib.mirror.Assets;
	
	public class TileTreePot extends TileObstaclePowerable
	{
		public function TileTreePot(metadata:int)
		{
			super(metadata, "Tree_Pot");
			
			this.boundingBox = this.boundingBox.fromPositionAndSize(0, 0, 18, 36);
			
			this.yOffset = -20;
		}
	}
}