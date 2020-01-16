package lib.mirror.entity 
{
	import lib.mirror.GameSettings;
	
	public class EntityCameraTarget extends Entity 
	{
		public function EntityCameraTarget()
		{
			this.physicsCheckTiles = this.physicsCheckEntities = this.physicsDoGravity = false;
			
			this.boundingBoxWidth = 18;
			this.boundingBoxHeight = 32;
		}
		
		public override function update():void
		{
			
		}
		
		public override function getIdentifier():String
		{
			return "EntityCameraTarget";
		}
	}
}
