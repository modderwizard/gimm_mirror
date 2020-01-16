package lib.mirror.entity
{
	import lib.mirror.Audio;
	import lib.mirror.entity.states.BossCarStateEnter;

	public class EntityBossCarShooter extends Entity
	{
		private var owner:EntityBossCar;
		
		private var xOffset:Number, yOffset:Number;
		
		public function EntityBossCarShooter(carType:String, owner:EntityBossCar, xOffset:Number, yOffset:Number)
		{
			this.physicsCheckEntities = this.physicsCheckTiles = this.physicsDoGravity = false;
			
			this.owner = owner;
			this.xOffset = xOffset;
			this.yOffset = yOffset;
			
			this.animations.load(("ANIM IDLE IDLE\nFRAME Car_" + carType + "_Shoot1 0 0 1\nEND\nANIM SHOOT IDLE\nFRAME Car_" + carType + "_Shoot0 0 0 5\nEND").split("\n"));
			
			this.setAnimation("IDLE");
			
			this.setDirection(carType == "Criminals" ? 1 : -1);
		}
		
		public function shoot(index:int):void
		{
			this.setAnimation("SHOOT");
			
			var bullet:EntityBossBullet = new EntityBossBullet();
			bullet.xVel = -0.1 * this.direction;
			bullet.yVel = index == 0 ? 0.07 : -0.025;
			bullet.posX = this.posX;
			bullet.posY = this.posY + 7;
			bullet.setDirection(this.direction);
			
			this.level.spawnEntity(bullet);
			
			Audio.play("Shoot");
		}
		
		public override function update():void
		{
			this.posX = this.owner.posX + this.xOffset - this.owner.getBoundingBoxXOffset();
			this.posY = this.owner.posY + this.yOffset;
			
			super.update();
		}
		
		public override function onAttacked(attacker:Entity):void
		{
			
		}
		
		public override function getIdentifier():String
		{
			return "EntityBossCarShooter";
		}
	}
}