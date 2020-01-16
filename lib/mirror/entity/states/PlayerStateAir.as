// Contributors: Jonathan Vernon

package lib.mirror.entity.states
{
	import flash.ui.Keyboard;
	
	import lib.mirror.Audio;
	import lib.mirror.MathHelper;
	import lib.mirror.entity.*;
	
	public class PlayerStateAir implements State
	{
		public function update(entity:Entity):void
		{
			if(entity.onGround)
			{
				entity.setState(new PlayerStateGround());
			}
		}
		
		public function enter(entity:Entity):void
		{
			entity.setAnimation("JUMP_START");
			
			//Audio.playSound("Jump");
		}
		
		public function exit(entity:Entity):void
		{
			entity.setAnimation("RUN");
			
			Audio.play("Land");
		}
		
		public function getIdentifier():String
		{
			return "Air";
		}
	}
}
