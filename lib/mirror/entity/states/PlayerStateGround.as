package lib.mirror.entity.states
{
	import flash.ui.Keyboard;
	
	import starling.events.TouchEvent;
	
	import lib.mirror.MathHelper;
	import lib.mirror.entity.*;
	import lib.mirror.input.Input;
	import lib.mirror.input.InputManager;
	
	public class PlayerStateGround implements State
	{
		public function update(entity:Entity):void
		{
			/*if(!entity.onGround)
			{
				entity.setState(new PlayerStateAir());
			}*/
			
			entity.xVel = entity.getDirection() * 2;
			  
			var isSpacePressed:Boolean = InputManager.isInputPressed(Input.JUMP);
			var isShiftPressed:Boolean = !isSpacePressed && InputManager.isInputPressed(Input.SLIDE);
			
			if(entity.onGround && (entity is EntityPlayerHero && isSpacePressed) || (entity is EntityPlayerVillain && isShiftPressed))
			{
				entity.posY -= 0.1;
				entity.setForce(NaN, -2, this);
				entity.onGround = false;
				
				entity.setState(new PlayerStateAir());
			}
			
			if(entity.onGround && (entity is EntityPlayerHero && isShiftPressed) || (entity is EntityPlayerVillain && isSpacePressed))
			{
				entity.setState(new PlayerStateSlide());
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
			return "Ground";
		}
	}
}
