package lib.mirror
{
	public class GameSettings
	{
		// Configurable settings
		public static var enableSound:Boolean = true;
		public static var enableMusic:Boolean = true;
		public static var enableDebugHotkeys:Boolean = false;
		
		// Internal settings
		public static var showDebugInfo:Boolean = false;
		public static var showHitboxes:Boolean = false;
		
		// Device specific settings
		public static var platform:Platform = null;
		public static var shaderLevel:int = -1;
	}
}
