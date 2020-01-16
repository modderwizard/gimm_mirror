package lib.mirror.entity.states
{
	import flash.ui.Keyboard;
	
	import lib.mirror.Camera;
	import lib.mirror.MathHelper;
	import lib.mirror.entity.*;
	import lib.mirror.input.Input;
	import lib.mirror.input.InputManager;
	
	public class PlayerStateBossEnd implements State
	{
		private var phase:int = 0;
		
		public function update(entity:Entity):void
		{
			var camera:Camera = Camera.getCameraForRoot(entity.level.ownerInstance);
			
			switch(this.phase)
			{
				case 0:
				{
					if(entity.getDirection() == 1)
					{
						entity.xVel = Math.max(0, entity.xVel - 0.01);
					}
					else
					{
						entity.xVel = Math.min(0, entity.xVel + 0.01);
					}
			
					if(entity.xVel == 0)
					{
						entity.setAnimation("IDLE");
						this.phase = 1;
					}
					
					break;
				}
				case 1:
				{
					camera.xOffset = MathHelper.moveTowardsZero(camera.xOffset, 0.5);
					
					if(camera.xOffset == 0)
					{
						this.phase = 2;
					}
					
					break;
				}
				case 2:
				{
					entity.setAnimation("RUN_START");
					entity.xVel = entity.getDirection();
					
					this.phase = 3;
				}
				case 3:
				{
					var cameraTarget:EntityCameraTarget = new EntityCameraTarget();
					cameraTarget.posX = entity.getBoundingBox().topLeft.x;
					cameraTarget.posY = entity.posY;
					entity.level.spawnEntity(cameraTarget);
					camera.setTracking(cameraTarget);
					
					this.phase = 4;
				}
			}
		}
		
		public function enter(entity:Entity):void
		{
			
		}
		
		public function exit(entity:Entity):void
		{
			
		}
		
		public function getIdentifier():String
		{
			return "BossEnd";
		}
	}
}
