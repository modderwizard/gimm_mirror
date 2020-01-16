package lib.mirror.level
{
	import lib.mirror.level.tile.*;
	
	public class TileEntry
	{
		private static var tileEntries:Vector.<TileEntry> = new Vector.<TileEntry>();
		
		public var id:int;
		public var classMap:Class;
		
		public function TileEntry(id:int, classMap:Class)
		{
			this.id = id;
			this.classMap = classMap;
		}
		
		public static function getEntry(index:int):TileEntry
		{
			return tileEntries[index];
		}
		
		public function createInstance(metadata:int):Tile
		{
			return new this.classMap(metadata);
		}
		
		// Static initializer
		{
			TileEntry.tileEntries[0] = null;
			TileEntry.tileEntries[1] = new TileEntry(1, TileRooftop);
			TileEntry.tileEntries[2] = new TileEntry(2, TilePipeJump);
			TileEntry.tileEntries[3] = new TileEntry(3, TileTrigger);
			TileEntry.tileEntries[4] = new TileEntry(4, TileFireBarrel);
			TileEntry.tileEntries[5] = new TileEntry(5, TileLadder);
			TileEntry.tileEntries[6] = new TileEntry(6, TileFlowerPot);
			TileEntry.tileEntries[7] = new TileEntry(7, TileTreePot);
			TileEntry.tileEntries[8] = new TileEntry(8, TilePipeSlide);
			TileEntry.tileEntries[9] = new TileEntry(9, TileAirConUnit);
			TileEntry.tileEntries[10] = new TileEntry(10, TileTutorialSign);
		}
	}
}