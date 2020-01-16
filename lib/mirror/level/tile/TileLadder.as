package lib.mirror.level.tile
{
	import lib.mirror.Assets;
	import lib.mirror.entity.states.*;
	
	public class TileLadder extends TileObstacle
	{
		public function TileLadder(metadata:int)
		{
			super(metadata, PlayerStateSlide, "Ladder");
			
			this.boundingBox = this.boundingBox.fromPositionAndSize(0, 0, 20, 34);
			
			this.yOffset = -18;
		}
	}
}