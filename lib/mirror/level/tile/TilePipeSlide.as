package lib.mirror.level.tile
{
	import lib.mirror.Assets;
	import lib.mirror.entity.states.*;
	
	public class TilePipeSlide extends TileObstacle
	{
		public function TilePipeSlide(metadata:int)
		{
			super(metadata, PlayerStateSlide, "Pipe_Slide");
			
			this.boundingBox = this.boundingBox.fromPositionAndSize(0, 0, 32, 30);
			
			this.yOffset = -14;
		}
	}
}