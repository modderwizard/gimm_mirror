package lib.mirror.entity
{
	import lib.mirror.entity.states.BossCarStateEnter;

	public class EntityBossMagnet extends Entity
	{
		private var owner:EntityBossCar;
		
		public var attachedToOwner:Boolean = true;
		
		public function EntityBossMagnet(owner:EntityBossCar)
		{
			this.physicsCheckEntities = this.physicsCheckTiles = this.physicsDoGravity = false;
			
			this.owner = owner;
			
			this.boundingBoxWidth = 16;
			this.boundingBoxHeight = 64;
			
			this.animations.load(("ANIM IDLE IDLE\nFRAME Magnet 0 0 1\nEND").split("\n"));
			this.setAnimation("IDLE");
		}
		
		public override function update():void
		{
			if(this.y < -100)
			{
				this.setDead();
			}
			
			if(this.attachedToOwner)
			{
				this.posX = this.owner.getBoundingBox().getCenterPoint().x - (this.boundingBoxWidth / 2) - (3 * this.owner.getDirection());
				this.posY = this.owner.getBoundingBox().topLeft.y - this.boundingBoxHeight + 3;
			}
			else
			{
				this.xVel = 0.1 * this.owner.getDirection();
				this.yVel = -1.0;
			}
			
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