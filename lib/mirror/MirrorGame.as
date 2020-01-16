package lib.mirror
{
	import flash.utils.getTimer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.textures.Texture;
	
	import lib.mirror.debug.DebugHelper;
	import lib.mirror.graphics.shaders.CrtBrightenFilter;
	import lib.mirror.graphics.shaders.CrtDistortionFilter;
	import lib.mirror.input.Input;
	import lib.mirror.input.InputManager;
	import lib.mirror.input.InputType;
	
	public class MirrorGame extends Sprite
	{
		public static var gameTick:int = 0;
		
		private var screenTop:ScreenSection = new ScreenSection(), screenBottom:ScreenSection = new ScreenSection();
		
		private var crtOverlay:Image;
		
		// Framerate counter stuff
		private var timeStart:Number = 0;
		private var framesElapsed:Number = 0;
		private var fpsCurrent:Number = 0;
		
		private var paused:Boolean = false;
		
		public function MirrorGame()
		{
			// Register event listener
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function onAddedToStage(evt:Event):void
		{
			// Register event listener
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.ENTER_FRAME, update);
			
			this.stage.addEventListener(ResizeEvent.RESIZE, onResize);
			
			// Initialize the size
			this.width = this.stage.stageWidth;
			this.height = this.stage.stageHeight;
			
			// Initialize input manager
			InputManager.createForType(GameSettings.platform.getInputType());
			InputManager.initialize(this.stage);
			
			// Initialize starling assets
			Assets.initialize();
			
			// Initialize screen sections
			this.screenTop.setScreenPosition("Top");
			this.screenBottom.setScreenPosition("Bottom");
			
			// Initialize CRT overlay
			this.crtOverlay = new Image(Assets.getTexture("Overlay_Combined"));
			this.crtOverlay.x = this.crtOverlay.y = -1;
			
			// Initialize level
			this.restartLevel();
			
			// Initialize time for framerate counter
			this.timeStart = getTimer();
			
			// Set screen filter
			this.setScreenFilter();
			
			// Add children
			this.addChild(this.screenTop);
			this.addChild(this.screenBottom);
			this.addChild(this.crtOverlay);
			this.addChild(DebugHelper.getInstance());
		}
		
		private function onResize(evt:ResizeEvent):void
		{
			var potentialWidth:Number = (evt.height / 9) * 16;
			var potentialHeight:Number = (evt.width / 16) * 9;
			
			var widthDifference:Number = evt.width - potentialWidth;
			var heightDifference:Number = evt.height - potentialHeight;
			
			if(widthDifference > heightDifference)
			{
				MirrorDoc.getStarlingInstance().viewPort.width = potentialWidth;
				MirrorDoc.getStarlingInstance().viewPort.height = evt.height;
			}
			else
			{
				MirrorDoc.getStarlingInstance().viewPort.width = evt.width;
				MirrorDoc.getStarlingInstance().viewPort.height = potentialHeight;
			}
			
			MirrorDoc.getStarlingInstance().viewPort.x = Math.abs(evt.width - MirrorDoc.getStarlingInstance().viewPort.width) / 2;
			MirrorDoc.getStarlingInstance().viewPort.y = Math.abs(evt.height - MirrorDoc.getStarlingInstance().viewPort.height) / 2;
		}
		
		public function update(evt:Event):void
		{			
			this.screenTop.update();
			this.screenBottom.update();
			
			MirrorGame.gameTick++;
			this.doDebugInfo();
			
			InputManager.update();
			
			// Update framerate
			var timeCurrent:Number = (getTimer() - this.timeStart) / 1000;
			this.framesElapsed++;
			
			if(timeCurrent > 1)
			{
				this.fpsCurrent = this.framesElapsed / timeCurrent;
				this.timeStart = getTimer();
				this.framesElapsed = 0;
			}
		}
		
		private function restartLevel():void
		{
			this.paused = false;
			
			Audio.stop("Music1");
			Audio.playLooping("Music1");
			
			this.screenTop.restartLevel();
			this.screenBottom.restartLevel();
		}
		
		private function doDebugInfo():void
		{
			DebugHelper.clear();
			
			// Check for debug keys
			if(GameSettings.enableDebugHotkeys)
			{
				if(InputManager.isInputPressed(Input.SHOW_DEBUG_INFO))
				{
					GameSettings.showDebugInfo = !GameSettings.showDebugInfo;
				}
				
				if(InputManager.isInputPressed(Input.SHOW_HITBOXES))
				{
					GameSettings.showHitboxes = !GameSettings.showHitboxes;
				}
				
				if(InputManager.isInputPressed(Input.TOGGLE_CRT_FILTER))
				{
					GameSettings.shaderLevel++;
					if(GameSettings.shaderLevel > 2)
					{
						GameSettings.shaderLevel = 0;
					}
					
					this.crtOverlay.visible = GameSettings.shaderLevel > 0;
					
					this.setScreenFilter();
				}
				
				if(InputManager.isInputPressed(Input.RESTART_LEVEL))
				{
					this.restartLevel();
				}
			}
			
			// Render debug info
			if(GameSettings.showDebugInfo)
			{
				DebugHelper.addText("FPS: " + Math.round(this.fpsCurrent) + "\n");
				DebugHelper.addText("Time: " + int(MirrorGame.gameTick / 60) + "\n\n");
			}
			
			this.screenTop.doDebugInfo();
			this.screenBottom.doDebugInfo();
		}
		
		private function setScreenFilter():void
		{
			switch(GameSettings.shaderLevel)
			{
				case 0:
					this.filter = null;
					break;
				case 1:
					this.filter = new CrtBrightenFilter();
					break;
				case 2:
					this.filter = new CrtDistortionFilter(1280, 720, 0.01);
					break;
			}
		}
	}
}