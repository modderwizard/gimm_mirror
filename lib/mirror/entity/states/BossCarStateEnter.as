package lib.mirror.entity.states
{
	import flash.ui.Keyboard;
	
	import lib.mirror.Audio;
	import lib.mirror.entity.*;
	import lib.mirror.input.Input;
	import lib.mirror.input.InputManager;
	
	public class BossCarStateEnter implements State
	{
		private var tick:int = -1;
		
		private var musicVolume:Number = 0.0;
		
		public function update(entity:Entity):void
		{
			this.tick++;
			
			if(this.musicVolume < 1.0)
			{
				this.musicVolume += 0.01;
				Audio.setVolume("Helicopter", this.musicVolume);
				
				if((entity as EntityBossCar).carType == "Cop")
				{
					Audio.setVolume("Siren", this.musicVolume * 0.25);
					Audio.setVolume("Music1", 1.0 - this.musicVolume);
				}
			}
			
			entity.yVel = 0.2;
			entity.xVel = (Math.sin(this.tick / 30.0) / 6.0) * entity.getDirection();
			
			if(this.tick == 360)
			{
				entity.setState(new BossCarStateEnterFall());
			}
		}
		
		public function enter(entity:Entity):void
		{
			entity.physicsCheckEntities = entity.physicsDoGravity = entity.physicsCheckTiles = false;
			
			for(var i:int = (entity as EntityBossCar).shooters.length - 1; i > -1; i--)
			{
				entity.level.spawnEntity((entity as EntityBossCar).shooters[i]);
			}
			
			entity.setAnimation("IDLE");
			
			Audio.playLooping("Helicopter");
			
			if((entity as EntityBossCar).carType == "Cop")
			{
				Audio.playLooping("Siren");
			}
		}
		
		public function exit(entity:Entity):void
		{
			Audio.stop("Music1");
		}
		
		public function getIdentifier():String
		{
			return "Enter";
		}
	}
}
