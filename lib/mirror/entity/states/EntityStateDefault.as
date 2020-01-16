// Contributors: Jonathan Vernon

package lib.mirror.entity.states
{
	import lib.mirror.entity.Entity;
	
	public class EntityStateDefault implements State
	{
		public function update(entity:Entity):void
		{
			
		}
		
		public function enter(entity:Entity):void
		{
			entity.setAnimation("IDLE");
		}
		
		public function exit(entity:Entity):void
		{
			
		}
		
		public function getIdentifier():String
		{
			return "Default";
		}
	}
}
