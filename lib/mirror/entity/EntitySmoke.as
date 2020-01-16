package lib.mirror.entity
{
    public class EntitySmoke extends Entity
    {
        public function EntitySmoke()
        {
			this.physicsCheckEntities = this.physicsCheckTiles = this.physicsDoGravity = false;
			
			this.animations.load(("ANIM IDLE IDLE\nFRAME Smoke 0 0 1\nEND").split("\n"));
			
			this.setAnimation("IDLE");
			
			this.yVel = -2;
        }
		
		public override function update():void
		{
			super.update();
			
			this.x = this.posX + Math.sin(this.posY / 16.0) * 0.5;
		}
		
		public override function getIdentifier():String
		{
			return "EntitySmoke";
		}
    }
}