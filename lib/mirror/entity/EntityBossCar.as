package lib.mirror.entity
{
	import lib.mirror.entity.states.BossCarStateEnter;
	import lib.mirror.level.Level;

	public class EntityBossCar extends Entity
	{
		public var shooters:Vector.<Entity> = new Vector.<Entity>();
		public var carType:String;
		
		public function EntityBossCar(carType:String)
		{
			this.boundingBoxWidth = 92;
			this.boundingBoxHeight = 29;
			
			this.carType = carType;
			
			// Create animation
			var animation:String = "ANIM IDLE IDLE\n";
			
			for(var i:int = 0; i < 8; i++)
			{
				animation += "FRAME Car_" + carType + "_" + i + " 0 0 1\n";
			}
			
			animation += "END";
			this.animations.load(animation.split("\n"));
			
			// Add shooters to car
			if(carType == "Criminals")
			{
				this.shooters.push(new EntityBossCarShooter(carType, this, 43, 4));
				this.shooters.push(new EntityBossCarShooter(carType, this, 27, -5));
			}
			else
			{
				this.shooters.push(new EntityBossCarShooter(carType, this, 38 + 11, 4));
				this.shooters.push(new EntityBossCarShooter(carType, this, 54 + 11, -5));
			}
			
			this.shooters.push(new EntityBossMagnet(this));
		}
		
		public override function onAttacked(attacker:Entity):void
		{
			
		}
		
		public override function getIdentifier():String
		{
			return "EntityBossCar";
		}
	}
}