package lib.mirror
{
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	
	[SWF(frameRate="60", backgroundColor="#000000")]
	public class MirrorDoc extends MovieClip
	{
		private static var instance:MirrorDoc;
		private static var starlingInstance:Starling;

		public function MirrorDoc()
		{
			MirrorDoc.instance = this;
			
			// Determine platform
			if(MirrorDoc.instance.stage.hasOwnProperty("nativeWindow"))
			{
				// Must access nativeWindow this way since it doesn't exist in Flash, and will fail to compile
				if(MirrorDoc.instance.stage["nativeWindow"] != null)
				{
					if(MirrorDoc.instance.stage["nativeWindow"].stage != null)
					{
						GameSettings.platform = Platform.AIR_DESKTOP;
					}
				}
				else
				{
					GameSettings.platform = Platform.AIR_MOBILE;
				}
			}
			else
			{
				GameSettings.platform = Platform.FLASH_PLAYER;
			}
			
			trace("Running on " + GameSettings.platform.getName());
			
			this.stage.addChild(new ControlsScreen());
		}
		
		public static function initStarling():void
		{
			var viewport:Rectangle = null;
			
			// Multiple ways to setup the viewport depending on device + runtime
			switch(GameSettings.platform)
			{
				case Platform.AIR_DESKTOP:
					viewport = new Rectangle(0, 0, MirrorDoc.instance.stage["nativeWindow"].stage.stageWidth, MirrorDoc.instance.stage["nativeWindow"].stage.stageHeight);
					break;
				case Platform.AIR_MOBILE:
					viewport = new Rectangle(0, 0, MirrorDoc.instance.stage.fullScreenWidth, MirrorDoc.instance.stage.fullScreenHeight);
					break;
			}
			
			// Disable CRT distortion on mobile devices
			GameSettings.shaderLevel = GameSettings.platform.getShaderLevel();
			
			// Actually start stuff now
			MirrorDoc.starlingInstance = new Starling(MirrorGame, MirrorDoc.instance.stage, viewport);
			MirrorDoc.starlingInstance.stage.stageWidth = 1280;
			MirrorDoc.starlingInstance.stage.stageHeight = 720;
			
			MirrorDoc.starlingInstance.start();
		}
		
		public static function getStarlingInstance():Starling
		{
			return MirrorDoc.starlingInstance;
		}
	}
}