package lib.mirror.level.tile
{
	import lib.mirror.Audio;
	import lib.mirror.entity.Entity;
	import lib.mirror.entity.EntityPlayerPower;
	import lib.mirror.entity.EntitySmoke;
	
	public class TileObstaclePowerable extends TileObstacle
	{
		public function TileObstaclePowerable(metadata:int, onlyTexture:String = null)
		{
			super(metadata, null, onlyTexture);
		}
		
		public override function onEntityCollide(entity:Entity, side:String):void
		{
			super.onEntityCollide(entity, side);
			
			if(entity is EntityPlayerPower)
			{
				entity.level.tiles.removeAt(entity.level.tiles.indexOf(this));
				entity.level.tilesToRemove.push(this);
				entity.setDead();
				
				var smoke:EntitySmoke = new EntitySmoke();
				smoke.posX = this.x + (this.boundingBox.width - 16);
				smoke.posY = this.y + this.boundingBox.getCenterPoint().y;
				entity.level.spawnEntity(smoke);
				
				Audio.play("Smoke");
			}
		}
	}
}