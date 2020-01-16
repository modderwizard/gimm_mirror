// Contributors: Jonathan Vernon

package lib.mirror.entity.states
{
	import lib.mirror.entity.Entity;
	
	public class PlayerStateDead implements State
	{
		public function update(entity:Entity):void
		{
			
		}
		
		public function enter(entity:Entity):void
		{
			//entity.setAnimation("DEAD");
			entity.physicsCheckEntities = entity.physicsCheckTiles = false;
			entity.yVel = -2;
			entity.xVel = 0;
		}
		
		public function exit(entity:Entity):void
		{
			
		}
		
		public function getIdentifier():String
		{
			return "Dead";
		}
	}
}
