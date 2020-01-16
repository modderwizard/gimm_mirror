package lib.mirror.entity.states
{
	import flash.ui.Keyboard;
	
	import lib.mirror.Camera;
	import lib.mirror.entity.*;
	import lib.mirror.input.Input;
	import lib.mirror.input.InputManager;
	
	public class PlayerStateBossStart implements State
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
					var entityBossCar:EntityBossCar = new EntityBossCar(entity.getDirection() == 1 ? "Criminals" : "Cop");
					entityBossCar.setDirection(entity.getDirection());
					
					if(entityBossCar.getDirection() == 1)
					{
						entityBossCar.posX = camera.getTracking().posX + 160;
					}
					else
					{
						entityBossCar.posX = camera.getTracking().posX - 160;
					}
					
					entityBossCar.posY = camera.getTracking().posY - 80;
					entity.level.spawnEntity(entityBossCar);
					entityBossCar.setState(new BossCarStateEnter());
					
					this.phase = 2;
					
					break;
				}
				case 2:
				{
					camera.xOffset += (0.5 * entity.getDirection());
					
					if(camera.xOffset >= 120 || camera.xOffset <= -120)
					{
						this.phase = 3;
					}
					
					break;
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
			return "BossStart";
		}
	}
}
