package lib.mirror.entity.states
{
	import flash.ui.Keyboard;
	
	import lib.mirror.Audio;
	import lib.mirror.Camera;
	import lib.mirror.entity.*;
	import lib.mirror.input.Input;
	import lib.mirror.input.InputManager;
	
	public class BossCarStateEnterFall implements State
	{
		private var tick:int = -1;
		
		private var musicVolume:Number = 1.0;
		
		public function update(entity:Entity):void
		{
			this.tick++;
			
			if(this.musicVolume > 0)
			{
				this.musicVolume -= 0.01;
				Audio.setVolume("Helicopter", this.musicVolume);
			}
			
			if(this.tick == 60)
			{
				var camera:Camera = Camera.getCameraForRoot(entity.level.ownerInstance);
				camera.getTracking().setState(new PlayerStateGround());
				camera.getTracking().setAnimation("RUN_START");
					
				entity.setState(new BossCarStateAttack());
			}
		}
		
		public function enter(entity:Entity):void
		{
			entity.physicsCheckTiles = entity.physicsCheckEntities = entity.physicsDoGravity = true;
			
			entity.yVel = 0;
			entity.xVel = 0;
			
			((entity as EntityBossCar).shooters[2] as EntityBossMagnet).attachedToOwner = false;
		}
		
		public function exit(entity:Entity):void
		{
			Audio.stop("Helicopter");
		}
		
		public function getIdentifier():String
		{
			return "EnterFall";
		}
	}
}
