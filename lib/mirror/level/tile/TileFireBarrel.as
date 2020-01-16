package lib.mirror.level.tile
{
	import lib.mirror.Assets;
	import lib.mirror.entity.Entity;
	import lib.mirror.entity.EntityFire;
	import lib.mirror.entity.EntityPlayerPower;
	
	public class TileFireBarrel extends TileObstaclePowerable
	{
		private var fireEntity:EntityFire = null;
		
		public function TileFireBarrel(metadata:int)
		{
			super(metadata, "Barrel");
			
			this.boundingBox = this.boundingBox.fromPositionAndSize(0, 0, 16, 16);
		}
		
		public override function onAddedToLevel():void
		{
			this.fireEntity = new EntityFire();
			this.fireEntity.posX = this.x;
			this.fireEntity.posY = this.y - this.boundingBox.height;
			this.fireEntity.level = this.level;
			this.level.spawnEntity(fireEntity);
		}
		
		public override function onEntityCollide(entity:Entity, side:String):void
		{
			super.onEntityCollide(entity, side);
			
			if(entity is EntityPlayerPower)
			{
				this.fireEntity.setDead();
			}
		}
	}
}