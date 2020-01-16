package lib.mirror.entity 
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	import lib.mirror.Camera;
	import lib.mirror.entity.states.EntityStateDefault;
	import lib.mirror.physics.Quadrilateral;
	
	public class EntityPlayerPower extends Entity 
	{
		public static const FIRE:String = "Fire";
		public static const WATER:String = "Water";
		
		private var owner:Entity = null;
		private var element:String = null;
		
		public function EntityPlayerPower(owner:Entity, element:String) 
		{
			this.owner = owner;
			this.element = element;
			
			if(element == EntityPlayerPower.FIRE)
			{
				this.abilities.push(Ability.CREATE_FIRE);
			}
			if(element == EntityPlayerPower.WATER)
			{
				this.abilities.push(Ability.EXTINGUISH_FIRE);
			}
			
			this.boundingBoxWidth = 4;
			this.boundingBoxHeight = 4;
			
			this.animations.load(("ANIM IDLE IDLE\nFRAME Power_" + element + " 0 0 1\nEND").split("\n"));
			
			this.setState(new EntityStateDefault());
		}
		
		public override function update():void
		{
			super.update();
			
			if(this.posX < Camera.getCameraForRoot(this.level.ownerInstance).getPosX() || this.posX > Camera.getCameraForRoot(this.level.ownerInstance).getPosX() + 320)
			{
				this.canRemove = true;
			}
		}
		
		public override function canAttack(entity:Entity):Boolean
		{
			return !(entity is EntityPlayerPower) && entity != this.owner;
		}
		
		public override function onAttacked(attacker:Entity):void
		{
			
		}
		
		public override function onTileHit(side:String, quad:Quadrilateral):Boolean
		{
			if(side == "TOP")
			{
				this.yVel *= -1;
			}
			
			return false;
		}
		
		public override function getGravityMultiplier():Number
		{
			return 2.0;
		}
		
		public override function getIdentifier():String
		{
			return "EntityPower";
		}
	}
}
