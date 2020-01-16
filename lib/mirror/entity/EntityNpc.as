package lib.mirror.entity
{
    public class EntityNpc extends Entity
    {
		private var doTick:Boolean = false;
		private var tick:int = -1;
		
		private var storedAttackerDirection:int;
		
        public function EntityNpc(animName:String)
        {
			this.boundingBoxWidth = 56;
			this.boundingBoxHeight = 32;
			
			this.abilities.push(Ability.TOUCH_HURT);
			
			this.animations.load(("ANIM IDLE IDLE\nFRAME Npc_" + animName + "_00 0 0 1\nEND").split("\n"));
			
			this.setAnimation("IDLE");
        }
		
		public override function update():void
		{
			super.update();
			
			if(this.doTick)
			{
				this.tick++;
				
				if(this.tick == 15)
				{
					this.isDead = true;
					this.physicsCheckTiles = false;
					this.setForce(2 * this.storedAttackerDirection, -1, this);
					
					this.doTick = false;
				}
			}
		}
		
		public override function onAttacked(attacker:Entity):void
		{
			if(this.tick == -1)
			{
				this.doTick = true;
				this.physicsCheckEntities = false;
				this.storedAttackerDirection = attacker.getDirection();
			}
		}
		
		public override function getIdentifier():String
		{
			return "EntityNpc";
		}
    }
}