package lib.mirror 
{
	import flash.media.SoundTransform;
	
	import starling.display.Canvas;
	import starling.display.Sprite;
	
	import lib.mirror.Assets;
	import lib.mirror.debug.DebugHelper;
	import lib.mirror.entity.Entity;
	import lib.mirror.graphics.ParallaxBackground;
	import lib.mirror.level.Level;
	import lib.mirror.level.tile.Tile;
	
	public dynamic class ScreenSection extends Sprite 
	{
		private var levelContainer:Sprite = new Sprite();
		private var parallaxBackground:ParallaxBackground;
		
		private var level:Level = null;
		
		private var section:String = "Unassigned";
		
		private var initialX:int, initialY:int;
		
		public function setScreenPosition(position:String):void
		{					
			this.level = new Level(this);
			this.section = position;
			
			this.width = 1280;
			this.height = 720 / 2;
			this.initialX = 0;
			
			switch(position)
			{
				case "Top":
				{
					this.initialY = 0;
					
					this.level.load(Assets.topLevel);
					
					break;
				}
				case "Bottom":
				{
					this.initialY = 720 / 2;
					
					this.level.load(Assets.bottomLevel);
					
					break;
				}
			}
			
			this.scale = 4;
			this.x = this.initialX;
			this.y = this.initialY;
						
			this.mask = new Canvas();
			(this.mask as Canvas).drawRectangle(0, 0, 320, 90);
			
			this.parallaxBackground = new ParallaxBackground(this).addLayer(this.section == "Top" ? "City_Back1" : "City_Back0", 0, 0, 0, 0).addLayer("City_Fore0", 0.01, 0, 0, -25).addLayer("City_Fore1", 0.025, 0, 0, -25);
			
			this.addChild(this.parallaxBackground);
			this.addChild(this.levelContainer);
		}
		
		public function getLevelContainer():Sprite
		{
			return this.levelContainer;
		}
		
		public function getName():String
		{
			return this.section;
		}
		
		public function update():void
		{
			Camera.getCameraForRoot(this).update();
			
			this.levelContainer.x = -Camera.getCameraForRoot(this).getPosX();
			this.levelContainer.y = -Camera.getCameraForRoot(this).getPosY();
			
			if(this.level != null)
			{
				this.level.update();
				
				// Add tiles
				for each(var tile:Tile in this.level.tilesToAdd)
				{
					tile.onAddedToLevel();
					this.levelContainer.addChild(tile);
				}
				
				// Remove tiles
				for each(tile in this.level.tilesToRemove)
				{	
					tile.onRemovedFromLevel();
					this.levelContainer.removeChild(tile);
				}
				
				// Add entities
				for each(var entity:Entity in this.level.entitiesToAdd)
				{
					if(entity.getIdentifier().indexOf("Player") > -1)
					{
						Camera.getCameraForRoot(this).setTracking(entity);
					}
					
					this.levelContainer.addChild(entity);
				}
				
				// Remove entities
				for each(entity in this.level.entitiesToRemove)
				{	
					this.levelContainer.removeChild(entity);
				}
				
				// Clear the entitiesToAdd and entitiesToRemove array
				this.level.tilesToAdd.length = 0;
				this.level.tilesToRemove.length = 0;
				
				this.level.entitiesToAdd.length = 0;
				this.level.entitiesToRemove.length = 0;
			}
			
			this.parallaxBackground.update();
		}
		
		public function restartLevel():void
		{
			Camera.getCameraForRoot(this).setTracking(null);
			
			// Start fresh
			this.levelContainer.removeChildren();
			
			// Setup the level
			this.level.setupLevel();
		}
		
		public function doDebugInfo():void
		{
			if(GameSettings.showDebugInfo)
			{
				if(Camera.getCameraForRoot(this).getTracking() != null)
				{
					DebugHelper.addText("[" + this.section + "]\nTiles: " + this.level.tiles.length + ", Entities: " + this.level.entities.length + "\nPrepared chunks: " + this.level.loadedChunks.length + ", Total chunks: " + this.level.chunks.length + ", PlayerState: " + Camera.getCameraForRoot(this).getTracking().getState().getIdentifier() + ", Anim: " + Camera.getCameraForRoot(this).getTracking().getAnimation() + "\n");
					DebugHelper.addText("X: " + Camera.getCameraForRoot(this).getTracking().posX.toFixed(2) + ", Y: " + Camera.getCameraForRoot(this).getTracking().posY.toFixed(2) + ", Xvel: " + Camera.getCameraForRoot(this).getTracking().xVel.toFixed(2) + ", Yvel: " + Camera.getCameraForRoot(this).getTracking().yVel.toFixed(2) + "\n\n");
				}
			}
			
			if(GameSettings.showHitboxes)
			{
				DebugHelper.setScale(this.scale);
			
				// Draw tile hitboxes
				for each(var tile:Tile in this.level.tiles)
				{
					DebugHelper.drawRectangle(tile.boundingBox.topLeft.x + tile.x + (this.levelContainer.x), tile.boundingBox.topLeft.y + tile.y + (this.levelContainer.y + (this.initialY / 4)), tile.boundingBox.width, tile.boundingBox.height, 0xFF0000, 0.25);
				}
				
				// Draw entity hitboxes
				for each(var entity:Entity in this.level.entities)
				{
					DebugHelper.drawRectangle(entity.getBoundingBox().topLeft.x + (this.levelContainer.x), entity.getBoundingBox().topLeft.y + (this.levelContainer.y + (this.initialY / 4)), entity.getBoundingBox().width, entity.getBoundingBox().height, 0x00FF00, 0.25);
				}
				
				DebugHelper.setScale(1);
			}
		}
		
		public function getSoundPan():SoundTransform
		{
			switch(this.section)
			{
				case "Top":
					return Audio.PAN_LEFT;
				case "Bottom":
					return Audio.PAN_RIGHT;
			}
			
			return null;
		}
	}
}
