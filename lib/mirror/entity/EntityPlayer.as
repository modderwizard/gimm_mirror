package lib.mirror.entity
{
	import lib.mirror.Audio;
    import lib.mirror.entity.states.*;
	import lib.mirror.input.Input;
	import lib.mirror.input.InputManager;
 
    public class EntityPlayer extends Entity
    {
		protected var power:String;
		
		protected var invincibilityTick:int = 0;
		protected var isInvincible:Boolean = false;
	
        public function EntityPlayer(animName:String, power:String)
        {
            this.healthMax = 1;
            this.health = 1;
           
			this.abilities.push(Ability.PLAYER);
            this.abilities.push(Ability.BOUNCEBACK);
			this.abilities.push(Ability.ACTIVATE_TRIGGERS);
           
            this.setState(new PlayerStateGround());
			
			this.boundingBoxWidth = 18;
			this.boundingBoxHeight = 32;
			
			this.power = power;
			
			this.animations.load(("ANIM IDLE IDLE\nFRAME Super" + animName + "_Idle 0 0 1\nEND\nANIM RUN_START RUN\nFRAME Super" + animName + "_RunStart_00 -5 0 5\nFRAME Super" + animName + "_RunStart_01 -12 0 5\nEND\nANIM RUN RUN\nFRAME Super" + animName + "_Run_00 -16 0 5\nFRAME Super" + animName + "_Run_01 -16 0 5\nFRAME Super" + animName + "_Run_02 -16 0 5\nFRAME Super" + animName + "_Run_03 -16 0 5\nFRAME Super" + animName + "_Run_04 -15 0 5\nFRAME Super" + animName + "_Run_05 -16 0 5\nEND\nANIM JUMP_START JUMP\nFRAME Super" + animName + "_JumpStart_00 -16 0 5\nFRAME Super" + animName + "_JumpStart_01 -16 0 5\nFRAME Super" + animName + "_JumpStart_02 -16 0 5\nFRAME Super" + animName + "_JumpStart_03 -13 0 5\nFRAME Super" + animName + "_JumpStart_04 -10 0 5\nFRAME Super" + animName + "_JumpStart_05 0 0 5\nEND\nANIM JUMP JUMP\nFRAME Super" + animName + "_Jump_00 1 0 5\nFRAME Super" + animName + "_Jump_01 2 0 5\nFRAME Super" + animName + "_Jump_02 2 0 5\nFRAME Super" + animName + "_Jump_03 2 0 5\nFRAME Super" + animName + "_Jump_04 2 0 5\nEND\nANIM JUMP_LAND RUN\nFRAME Super" + animName + "_JumpStart_05 0 0 5\nFRAME Super" + animName + "_JumpStart_04 -10 0 5\nFRAME Super" + animName + "_JumpStart_03 -13 0 5\nFRAME Super" + animName + "_JumpStart_02 -16 0 5\nFRAME Super" + animName + "_JumpStart_01 -16 0 5\nFRAME Super" + animName + "_JumpStart_00 -16 0 5\nEND\nANIM SLIDE_START SLIDE\nFRAME Super" + animName + "_SlideStart_00 -16 2 2\nFRAME Super" + animName + "_SlideStart_01 -17 3 2\nFRAME Super" + animName + "_SlideStart_02 -15 4 2\nFRAME Super" + animName + "_SlideStart_03 -13 6 2\nFRAME Super" + animName + "_SlideStart_04 -12 6 2\nFRAME Super" + animName + "_SlideStart_05 -12 6 2\nFRAME Super" + animName + "_SlideStart_06 -9 6 2\nFRAME Super" + animName + "_SlideStart_07 -6 6 2\nEND\nANIM SLIDE SLIDE\nFRAME Super" + animName + "_Slide -4 6 1\nEND\nANIM SLIDE_RECOVER RUN_START\nFRAME Super" + animName + "_SlideRecover_00 -4 6 2\nFRAME Super" + animName + "_SlideRecover_01 -4 4 2\nFRAME Super" + animName + "_SlideRecover_02 -4 3 2\nFRAME Super" + animName + "_SlideRecover_03 -4 3 2\nFRAME Super" + animName + "_SlideRecover_04 -4 3 2\nFRAME Super" + animName + "_SlideRecover_05 -4 1 2\nFRAME Super" + animName + "_SlideRecover_06 -4 0 2\nFRAME Super" + animName + "_SlideRecover_07 -4 0 2\nEND\nANIM PUNCH RUN\nFRAME Super" + animName + "_Punch_00 -16 0 5\nFRAME Super" + animName + "_Punch_01 -16 0 1\nFRAME Super" + animName + "_Punch_02 -16 0 1\nFRAME Super" + animName + "_Punch_03 -16 0 1\nFRAME Super" + animName + "_Punch_04 -16 0 1\nFRAME Super" + animName + "_Punch_05 -16 0 1\nFRAME Super" + animName + "_Punch_06 -16 0 1\nFRAME Super" + animName + "_Punch_07 -16 0 5\nEND").split("\n"));
			
			this.setAnimation("RUN_START");
        }
		
		public override function update():void
		{
			super.update();
			
			if(InputManager.isInputPressed(Input.SHOOT) && this.state is PlayerStateGround && this.level.getNumberOfEntities("EntityPower") < 3)
			{
				var power:EntityPlayerPower = new EntityPlayerPower(this, this.power);
				power.posX = this.posX + (this.boundingBoxWidth * this.getDirection());
				power.posY = this.posY + (this.boundingBoxHeight / 2);
				power.xVel = this.xVel * 2;
				this.level.spawnEntity(power);
				
				Audio.play("Power");
			}
			
			if(this.isInvincible)
			{
				this.invincibilityTick++;
				
				if(this.invincibilityTick % 5 == 0)
				{
					this.alpha = (this.alpha == 1.0) ? 0.25 : 1.0;
				}
				
				if(this.invincibilityTick >= 60 * 2)
				{
					this.isInvincible = false;
					this.invincibilityTick = 0;
					this.alpha = 1.0;
				}
			}
		}
		
		public override function onAttacked(attacker:Entity):void
		{
			if(attacker is EntityNpc)
			{
				this.setAnimation("PUNCH");
				attacker.onAttacked(this);
				return;
			}
			
			if(!this.isInvincible)
			{
				if(attacker is EntityBossBullet)
				{
					attacker.setDead();
				}
				
				Audio.play("Hurt");
				
				this.isInvincible = true;
			}
		}
		
		public override function getIdentifier():String
		{
			return "EntityPlayer";
		}
    }
}