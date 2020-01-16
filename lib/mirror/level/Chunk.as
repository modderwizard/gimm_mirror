package lib.mirror.level
{
	import flash.utils.getQualifiedClassName;
	
	import lib.mirror.entity.Entity;
	import lib.mirror.level.tile.Tile;
	
	public class Chunk 
	{
		private var level:Level;
		
		private var chunkX:int, chunkY:int;
		private var prepared:Boolean = false;
		
		private var tileData:Vector.<int>;
		private var tileMetadata:Vector.<int>;
		
		private var entityData:Vector.<int>;
		private var entityMetadata:Vector.<int>;
		
		private var hasPlayer:Boolean = false;
		
		public var preparedEntities:Vector.<Entity> = new Vector.<Entity>();
		public var preparedTiles:Vector.<Tile> = new Vector.<Tile>();
		
		public function Chunk(level:Level, chunkX:int, chunkY:int)
		{
			this.level = level;
			
			this.chunkX = chunkX;
			this.chunkY = chunkY;
			
			this.tileData = new Vector.<int>(CHUNK_WIDTH * CHUNK_HEIGHT);
			this.tileMetadata = new Vector.<int>(CHUNK_WIDTH * CHUNK_HEIGHT);

			this.entityData = new Vector.<int>(CHUNK_WIDTH * CHUNK_HEIGHT);
			this.entityMetadata = new Vector.<int>(CHUNK_WIDTH * CHUNK_HEIGHT);
		}
		
		public function isPrepared():Boolean
		{
			return this.prepared;
		}
		
		public function prepare():void
		{
			if(!this.prepared)
			{
				for(var i:int = 0; i < this.tileData.length; i++)
				{
					// Prepare tile
					if(TileEntry.getEntry(this.tileData[i]) != null)
					{
						var tile:Tile = TileEntry.getEntry(this.tileData[i]).createInstance(this.tileMetadata[i]);
						
						tile.x = (int(this.chunkX * CHUNK_WIDTH) + int(i % CHUNK_WIDTH)) * Level.TILE_SIZE + tile.xOffset;
						tile.y = (int(this.chunkY * CHUNK_HEIGHT) + int(i / CHUNK_WIDTH)) * Level.TILE_SIZE + tile.yOffset;
						tile.level = this.level;
						
						this.updateCollisionForTile(tile, int(i % CHUNK_WIDTH), int(i / CHUNK_WIDTH));
						
						this.preparedTiles.push(tile);
					}
					
					// Prepare entity
					if(EntityEntry.getEntry(this.entityData[i]) != null)
					{
						var entity:Entity = EntityEntry.getEntry(this.entityData[i]).createInstance();
						entity.setDirection(this.entityMetadata[i] == 0 ? 1 : -1);
						entity.posX = (int(this.chunkX * CHUNK_WIDTH) + int(i % CHUNK_WIDTH)) * Level.TILE_SIZE + EntityEntry.getEntry(this.entityData[i]).xOffset;
						entity.posY = (int(this.chunkY * CHUNK_HEIGHT) + int(i / CHUNK_WIDTH)) * Level.TILE_SIZE + EntityEntry.getEntry(this.entityData[i]).yOffset;
						entity.level = this.level;
						
						this.preparedEntities.push(entity);
					}
				}
				
				this.prepared = true;
			}
		}
		
		// Disables collision on sides of the tile that aren't exposed
		private function updateCollisionForTile(tile:Tile, tileX:int, tileY:int):void
		{
			tile.boundingBox.topLineEnabled = this.shouldCollideSide(tileX, tileY, 0, -1);
			tile.boundingBox.bottomLineEnabled = this.shouldCollideSide(tileX, tileY, 0, 1);
			tile.boundingBox.leftLineEnabled = this.shouldCollideSide(tileX, tileY, -1, 0);
			tile.boundingBox.rightLineEnabled = this.shouldCollideSide(tileX, tileY, 1, 0);
		}
		
		private function shouldCollideSide(tileX:int, tileY:int, changeX:int, changeY:int):Boolean
		{
			// Calculates the position to check relative to this chunk, then converts it to coordinates relative to the actual chunk it's in
			var checkTileX:int = tileX + changeX;
			var adjustedCheckX:int = (checkTileX < 0) ? (checkTileX + CHUNK_WIDTH) : (checkTileX >= CHUNK_WIDTH) ? (checkTileX - CHUNK_WIDTH) : checkTileX;
			
			var checkTileY:int = tileY + changeY;
			var adjustedCheckY:int = checkTileY < 0 ? checkTileY + CHUNK_HEIGHT : checkTileY >= CHUNK_HEIGHT ? checkTileY - CHUNK_HEIGHT : checkTileY;
			
			// Adjust the chunk to check, to account for tiles that are on the edge of this chunk
			var checkChunkX:int = adjustedCheckX > checkTileX ? this.chunkX - 1 : adjustedCheckX < checkTileX ? this.chunkX + 1 : this.chunkX;
			var checkChunkY:int = adjustedCheckY > checkTileY ? this.chunkY - 1 : adjustedCheckY < checkTileY ? this.chunkY + 1 : this.chunkY;
			
			// Check if new check coordinates are out of bounds
			if(checkChunkX < 0 || checkChunkY < 0 || checkChunkX >= this.level.getSizeInChunks().x || checkChunkY >= this.level.getSizeInChunks().y)
			{
				return true;
			}
			
			var checkChunk:Chunk = this.level.getChunkForChunkCoordinates(checkChunkX, checkChunkY);
			
			return checkChunk.getTile(adjustedCheckX, adjustedCheckY) == 0;
		}
		
		public function unprepare():void
		{
			this.preparedTiles.length = 0;
			this.preparedEntities.length = 0;
			
			this.prepared = false;
		}
		
		public function getChunkX():int
		{
			return this.chunkX;
		}
		
		public function getChunkY():int
		{
			return this.chunkY;
		}
		
		public function getHasPlayer():Boolean
		{
			return this.hasPlayer;
		}
		
		public function setTile(i:int, tile:int):void
		{
			this.tileData[i] = tile;
		}
		
		public function getTile(x:int, y:int):int
		{
			return this.tileData[int(int(y * CHUNK_WIDTH) + x)];
		}
		
		public function setTileMetadata(i:int, meta:int):void
		{
			this.tileMetadata[i] = meta;
		}
		
		public function getTileMetadata(x:int, y:int):int
		{
			return this.tileMetadata[y * CHUNK_WIDTH + x];
		}
		
		public function setEntity(i:int, entity:int):void
		{
			// Check if entity is a player
			if(EntityEntry.getEntry(entity) != null)
			{
				if(getQualifiedClassName(EntityEntry.getEntry(entity).classMap).indexOf("Player") > -1)
				{
					this.hasPlayer = true;
				}
			}
			
			this.entityData[i] = entity;
		}
		
		public function getEntity(x:int, y:int):int
		{
			return this.entityData[y * CHUNK_WIDTH + x];
		}
		
		public function setEntityMetadata(i:int, meta:int):void
		{
			this.entityMetadata[i] = meta;
		}
		
		public function getEntityMetadata(x:int, y:int):int
		{
			return this.entityMetadata[y * CHUNK_WIDTH + x];
		}
		
		public static var CHUNK_WIDTH:int = 12;
		public static var CHUNK_HEIGHT:int = 6;
	}
}
