package lib.mirror.level.tile
{
	import lib.mirror.Assets;
	import lib.mirror.entity.states.*;
	
	public class TilePipeJump extends TileObstacle
	{
		public function TilePipeJump(metadata:int)
		{
			super(metadata, PlayerStateAir, "Pipe_Jump");
			
			this.boundingBox = this.boundingBox.fromPositionAndSize(0, 0, 32, 12);
			
			this.yOffset = 4;
		}
	}
}