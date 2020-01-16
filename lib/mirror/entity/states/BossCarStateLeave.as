package lib.mirror.entity.states
{
	import flash.ui.Keyboard;
	
	import lib.mirror.Audio;
	import lib.mirror.entity.*;
	import lib.mirror.input.Input;
	import lib.mirror.input.InputManager;
	
	public class BossCarStateLeave implements State
	{
		private var speedAdd:Number = 0;
		private var musicVolume:Number = 1.0;
		
		public function update(entity:Entity):void
		{
			speedAdd += 0.05;
			
			entity.xVel = (2 + speedAdd) * entity.getDirection();
			
			if((entity as EntityBossCar).carType == "Cop" && this.musicVolume > 0)
			{
				this.musicVolume -= 0.01;
				Audio.setVolume("Siren", this.musicVolume * 0.25);
			}
		}
		
		public function enter(entity:Entity):void
		{
			entity.physicsCheckTiles = entity.physicsCheckEntities = entity.physicsDoGravity = false;
		}
		
		public function exit(entity:Entity):void
		{
			if((entity as EntityBossCar).carType == "Cop")
			{
				Audio.stop("Siren");
			}
		}
		
		public function getIdentifier():String
		{
			return "Leave";
		}
	}
}
