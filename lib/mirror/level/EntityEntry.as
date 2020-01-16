package lib.mirror.level
{
	import lib.mirror.entity.*;

	public class EntityEntry
	{
		private static var entityEntries:Vector.<EntityEntry> = new Vector.<EntityEntry>();
		
		public var id:int;
		public var classMap:Class;
		public var xOffset:int, yOffset:int;
		
		public function EntityEntry(id:int, classMap:Class)
		{
			this.id = id;
			this.classMap = classMap;
			
			this.xOffset = 0;
			this.yOffset = 0;
		}
		
		public static function getEntry(index:int):EntityEntry
		{
			return entityEntries[index];
		}
		
		public function createInstance():Entity
		{
			return new this.classMap();
		}
		
		public function setOffset(xOffset:int, yOffset:int):EntityEntry
		{
			this.xOffset = xOffset;
			this.yOffset = yOffset;
			
			return this;
		}
		
		// Static initializer
		{
			EntityEntry.entityEntries[0] = null;
			EntityEntry.entityEntries[1] = new EntityEntry(1, EntityPlayerHero);
			EntityEntry.entityEntries[2] = new EntityEntry(2, EntityPlayerVillain);
			EntityEntry.entityEntries[3] = new EntityEntry(3, EntityFire);
			EntityEntry.entityEntries[4] = new EntityEntry(4, EntityNpcCivilian);
			EntityEntry.entityEntries[5] = new EntityEntry(5, EntityNpcRobber);
		}
	}
}