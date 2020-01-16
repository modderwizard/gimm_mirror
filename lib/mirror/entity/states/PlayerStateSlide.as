package lib.mirror.entity.states
{
	import flash.ui.Keyboard;
	
	import lib.mirror.Audio;
	import lib.mirror.MathHelper;
	import lib.mirror.entity.*;
	
	public class PlayerStateSlide implements State
	{
		private var tick:int = 0;
		
		public function update(entity:Entity):void
		{
			this.tick++;
			
			if(this.tick >= 0.90 * 60 && entity.onGround)
			{
				entity.setState(new PlayerStateGround());
			}
			
			entity.xVel = entity.getDirection() * 2;
		}
		
		public function enter(entity:Entity):void
		{
			entity.setAnimation("SLIDE_START");
			
			Audio.play("Slide");
		}
		
		public function exit(entity:Entity):void
		{
			entity.setAnimation("SLIDE_RECOVER");
		}
		
		public function getIdentifier():String
		{
			return "Slide";
		}
	}
}
