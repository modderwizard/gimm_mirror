package lib.mirror.entity
{
	import lib.mirror.Camera;
	import lib.mirror.entity.states.*;
	
	public class EntityBossBullet extends Entity
	{
		public function EntityBossBullet()
		{
			this.physicsCheckTiles = this.physicsDoGravity = false;
			
			this.abilities.push(Ability.TOUCH_HURT);
			
			this.boundingBoxWidth = 2;
			this.boundingBoxHeight = 1;
			
			this.animations.load(("ANIM IDLE IDLE\nFRAME Bullet 0 0 1\nEND").split("\n"));
			
			this.setAnimation("IDLE");
		}
		
		public override function update():void
		{
			super.update();
			
			if(this.posX < Camera.getCameraForRoot(this.level.ownerInstance).getPosX() || this.posX > Camera.getCameraForRoot(this.level.ownerInstance).getPosX() + 320)
			{
				this.canRemove = true;
			}
		}
		
		public override function canAttack(entity:Entity):Boolean
		{
			if(entity is EntityPlayer)
			{
				return (entity.getState() is PlayerStateAir && this.yVel > 0) ? false : !(entity.getState() is PlayerStateSlide && this.yVel < 0);
			}
			
			return false;
		}
		
		public override function getIdentifier():String
		{
			return "EntityBossBullet";
		}
	}
}