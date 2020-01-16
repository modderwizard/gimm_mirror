package lib.mirror.entity 
{
	import starling.display.MovieClip;
	
	import lib.mirror.Assets;
	import lib.mirror.entity.states.EntityStateDefault;
	
	public class EntityFire extends Entity 
	{
		public function EntityFire()
		{
			this.physicsCheckTiles = this.physicsDoGravity = false;
			
			this.abilities.push(Ability.TOUCH_HURT);
			
			this.boundingBoxWidth = 18;
			this.boundingBoxHeight = 18;
			
			var ree:String = "ANIM IDLE IDLE\n"
			for(var i:int = 0; i < 40; i++)
			{
				ree += "FRAME Fire_" + (i + 28) + " 0 0 2\n";
			}
			ree += "END";
			
			this.animations.load(ree.split("\n"));
			
			this.setState(new EntityStateDefault());
		}
		
		public override function onAttacked(attacker:Entity):void
		{
			
		}

		public override function getIdentifier():String
		{
			return "EntityFire";
		}
	}
}
