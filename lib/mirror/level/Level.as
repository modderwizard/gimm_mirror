package lib.mirror.level
{
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import starling.core.Starling;
	import starling.display.Sprite;

	import lib.mirror.Camera;
	import lib.mirror.MathHelper;
	import lib.mirror.MirrorDoc;
	import lib.mirror.debug.DebugHelper;
	import lib.mirror.entity.Entity;
	import lib.mirror.entity.EntityBossCar;
	import lib.mirror.entity.states.BossCarStateLeave;
	import lib.mirror.entity.states.PlayerStateBossStart;
	import lib.mirror.entity.states.PlayerStateBossEnd;
	import lib.mirror.level.tile.Tile;
	import lib.mirror.physics.Physics;
	
	public class Level 
	{
		public var ownerInstance:Sprite = null;
		
		public var chunks:Vector.<Chunk>;
		private var widthInChunks:int, heightInChunks:int;
		
		private var centerChunk:Chunk = null;
		public var loadedChunks:Vector.<Chunk> = new Vector.<Chunk>();
		
		public var entities:Vector.<Entity> = new Vector.<Entity>();
		public var entitiesToAdd:Vector.<Entity> = new Vector.<Entity>();
		public var entitiesToRemove:Vector.<Entity> = new Vector.<Entity>();
		
		public var tiles:Vector.<Tile> = new Vector.<Tile>();
		public var tilesToAdd:Vector.<Tile> = new Vector.<Tile>();
		public var tilesToRemove:Vector.<Tile> = new Vector.<Tile>();
		
		private var triggerPhase:int = -1;

		public function Level(owner:Sprite)
		{
			this.ownerInstance = owner;
		}
		
		public function update():void
		{
			this.checkForNewCenterChunk();
			
			for each(var entity:Entity in this.entities)
			{
				entity.update();
				
				Physics.entityUpdatePhysics(entity, this.tiles, this.entities, this);
				
				if(entity.canRemove)
				{
					this.entities.removeAt(this.entities.indexOf(entity));
					this.entitiesToRemove.push(entity);
				}
			}
		}
		
		public function load(levelDataBinary:Class):void
		{
			// Create instance of level binary data
			var data:ByteArray = new levelDataBinary() as ByteArray;
			
			// Read header (BCLF)
			var header:Vector.<int> = new <int>[data.readInt(), data.readInt(), data.readInt(), data.readInt()];
			
			if(header[0] != 0x42 || header[1] != 0x43 || header[2] != 0x4C || header[3] != 0x46)
			{
				throw new Error("Malformed level file... aborting!");
			}
			
			// Read chunk size
			var chunkWidth:int = data.readInt();
			var chunkHeight:int = data.readInt();
			
			// Read level size in chunks
			this.widthInChunks = data.readInt();
			this.heightInChunks = data.readInt();
			
			// Read chunk data
			this.chunks = new Vector.<Chunk>(this.widthInChunks * this.heightInChunks);
			
			// Initialize chunks
			for(var i:int = 0; i < this.widthInChunks * this.heightInChunks; i++)
			{
				var chunk:Chunk = new Chunk(this, i % this.widthInChunks, int(i / this.widthInChunks));
				
				// Read chunk tile data
				for(var j:int = 0; j < Chunk.CHUNK_WIDTH * Chunk.CHUNK_HEIGHT; j++)
				{
					chunk.setTile(j, data.readInt());
				}
				
				// Read chunk tile metadata
				for(j = 0; j < Chunk.CHUNK_WIDTH * Chunk.CHUNK_HEIGHT; j++)
				{
					chunk.setTileMetadata(j, data.readInt());
				}
				
				// Read chunk entity data
				for(j = 0; j < Chunk.CHUNK_WIDTH * Chunk.CHUNK_HEIGHT; j++)
				{
					chunk.setEntity(j, data.readInt());
				}
				
				// Read chunk entity metadata
				for(j = 0; j < Chunk.CHUNK_WIDTH * Chunk.CHUNK_HEIGHT; j++)
				{
					chunk.setEntityMetadata(j, data.readInt());
				}
				
				this.chunks[i] = chunk;
			}
		}
		
		public function setupLevel(firstTime:Boolean = true):void
		{
			this.centerChunk = null;
			this.loadedChunks.length = 0;
			
			this.entities.length = 0;
			this.entitiesToAdd.length = 0;
			
			this.tiles.length = 0;
			this.tilesToAdd.length = 0;
			
			this.triggerPhase = -1;
			
			for each(var chunk:Chunk in this.chunks)
			{
				chunk.unprepare();
			}
		}
		
		private function checkForNewCenterChunk():void
		{
			var chunkPlayerIn:Chunk = null;
			
			// If player exists, use the chunk they are in, else, find the chunk with a player spawnpoint
			if(Camera.getCameraForRoot(this.ownerInstance).getTracking() != null)
			{
				var entityTracking:Entity = Camera.getCameraForRoot(this.ownerInstance).getTracking();
				
				if(entityTracking.xVel == 0 && entityTracking.yVel == 0)
				{
					return;
				}
				
				var chunkX:int = int(MathHelper.clamp(entityTracking.posX / Chunk.CHUNK_WIDTH / TILE_SIZE, 0, this.widthInChunks - 1));
				var chunkY:int = int(MathHelper.clamp(entityTracking.posY / Chunk.CHUNK_HEIGHT / TILE_SIZE, 0, this.heightInChunks - 1));
				
				chunkPlayerIn = this.getChunkForChunkCoordinates(chunkX, chunkY);
			}
			else
			{
				for each(var chunk:Chunk in this.chunks)
				{
					if(chunk.getHasPlayer())
					{
						chunkPlayerIn = chunk;
					}
				}
			}
			
			// Check if the "new" center chuck is different from the current one
			if(this.centerChunk != chunkPlayerIn)
			{
				this.centerChunk = chunkPlayerIn;
				
				var otherChunksToLoad:Vector.<Chunk> = new Vector.<Chunk>();
				otherChunksToLoad.push(this.centerChunk);
				
				// Add surrounding chunks to list
				var chunkRange:int = 2;
				
				for(chunkY = this.centerChunk.getChunkY() - chunkRange; chunkY < this.centerChunk.getChunkY() + chunkRange + 1; chunkY++)
				{
					for(chunkX = this.centerChunk.getChunkX() - chunkRange; chunkX < this.centerChunk.getChunkX() + chunkRange + 1; chunkX++)
					{
						if(chunkX >= 0 && chunkX < this.widthInChunks && chunkY >= 0 && chunkY < this.heightInChunks)
						{
							otherChunksToLoad.push(this.getChunkForChunkCoordinates(chunkX, chunkY));
						}
					}
				}
				
				// TODO: I wrote this very tired at 1:00 AM. Probably a better way to do it
				
				// Check loaded chunks to see if they need to be unloaded
				for each(chunk in this.loadedChunks)
				{
					if(otherChunksToLoad.indexOf(chunk) < 0)
					{
						// Mark entities for unloading
						for each(var entity:Entity in chunk.preparedEntities)
						{
							if(entity.getIdentifier().indexOf("Player") < 0)
							{
								this.entities.removeAt(this.entities.indexOf(entity));
								this.entitiesToRemove.push(entity);
							}
						}
						
						// Mark tiles for unloading
						for each(var tile:Tile in chunk.preparedTiles)
						{
							this.tiles.removeAt(this.tiles.indexOf(tile));
							this.tilesToRemove.push(tile);
						}
						
						chunk.unprepare();
						this.loadedChunks.removeAt(this.loadedChunks.indexOf(chunk));
					}
				}
				
				this.loadedChunks = otherChunksToLoad;
				
				// Add newly loaded chunks to the list
				for each(chunk in this.loadedChunks)
				{
					if(!chunk.isPrepared())
					{
						chunk.prepare();
					
						// Mark entities for loading
						for each(entity in chunk.preparedEntities)
						{
							this.spawnEntity(entity);
						}
						
						// Mark tiles for loading
						for each(tile in chunk.preparedTiles)
						{
							this.tiles.push(tile);
							this.tilesToAdd.push(tile);
						}
					}
				}
			}
		}
		
		private function getChunkForGlobalCoordinates(globalX:int, globalY:int):Chunk
		{
			return this.chunks[int(globalY / Chunk.CHUNK_HEIGHT) * this.widthInChunks + int(globalX / Chunk.CHUNK_WIDTH)];
		}
		
		public function getChunkForChunkCoordinates(chunkX:int, chunkY:int):Chunk
		{
			return this.chunks[chunkY * this.widthInChunks + chunkX];
		}
		
		public function getSizeInChunks():Point
		{
			return new Point(this.widthInChunks, this.heightInChunks);
		}
		
		public function spawnEntity(entity:Entity):void
		{
			entity.level = this;
			
			this.entities.push(entity);
			this.entitiesToAdd.push(entity);
		}
		
		public function getEntitiesWithID(id:String):Vector.<Entity>
		{
			var matches:Vector.<Entity> = new Vector.<Entity>();
			
			for each(var entity:Entity in this.entities)
			{
				if(entity.getIdentifier() == id)
				{
					matches.push(entity);
				}
			}
			
			return matches;
		}
		
		public function getNumberOfEntities(matchID:String):int
		{
			var matches:int = 0;
			
			for each(var entity:Entity in this.entities)
			{
				if(entity.getIdentifier() == matchID)
				{
					matches++;
				}
			}
			
			return matches;
		}
		
		public function onTriggered(triggerID:int):void
		{
			if(this.triggerPhase < triggerID)
			{
				this.triggerPhase = triggerID;
				
				switch(triggerID)
				{
					case 0: // Start boss fight
						Camera.getCameraForRoot(this.ownerInstance).getTracking().setState(new PlayerStateBossStart());
						break;
					case 1: // End boss fight
						Camera.getCameraForRoot(this.ownerInstance).getTracking().setState(new PlayerStateBossEnd());
						this.getEntitiesWithID("EntityBossCar")[0].setState(new BossCarStateLeave());
						break;
					case 2: // Start end cutscene
						MirrorDoc.getStarlingInstance().stop();
						MirrorDoc.getStarlingInstance().stage.removeChildren();
						
						// Ending animation's origin is it's center, so modify the coordinates to place it on the stage properly
						var endingAnim:AnimationEnding = new AnimationEnding();
						endingAnim.x += 1280 / 2;
						endingAnim.y += 720 / 2;
						Starling.current.nativeOverlay.addChild(endingAnim);
						break;
				}
			}
		}
		
		public static var TILE_SIZE:int = 16;
	}
}
