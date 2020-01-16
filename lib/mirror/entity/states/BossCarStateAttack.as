package lib.mirror.entity.states
{
	import flash.ui.Keyboard;
	
	import lib.mirror.MathHelper;
	import lib.mirror.entity.*;
	import lib.mirror.input.Input;
	import lib.mirror.input.InputManager;
	
	public class BossCarStateAttack implements State
	{
		private var randomSeedStart:int = 25565;
		private var tick:int = -1;
		
		public function update(entity:Entity):void
		{
			this.tick++;
			
			if(this.tick == 110)
			{
				this.tick = 0;
				
				// Generate seeded random
				var random:Number = MathHelper.randomSeeded(this.randomSeedStart);
				this.randomSeedStart = MathHelper.randomSeeded(this.randomSeedStart + int(random * int.MAX_VALUE)) * int.MAX_VALUE;
				
				// Convert to 0 or 1
				var randomConverted:int = int(Math.round(random));
				randomConverted = entity.getDirection() == -1 ? 1 - randomConverted : randomConverted;
				
				((entity as EntityBossCar).shooters[randomConverted] as EntityBossCarShooter).shoot(randomConverted);
			}
		}
		
		public function enter(entity:Entity):void
		{
			entity.xVel = 2 * entity.getDirection();
		}
		
		public function exit(entity:Entity):void
		{
			
		}
		
		public function getIdentifier():String
		{
			return "Attack";
		}
	}
}
