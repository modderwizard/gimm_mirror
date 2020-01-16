package lib.mirror.level.tile
{
	import lib.mirror.Assets;
	import lib.mirror.entity.states.*;
	
	public class TileAirConUnit extends TileObstacle
	{
		public function TileAirConUnit(metadata:int)
		{
			super(metadata, PlayerStateAir, "AirConUnit");
			
			this.boundingBox = this.boundingBox.fromPositionAndSize(0, 0, 20, 16);
		}
	}
}