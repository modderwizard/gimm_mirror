package lib.mirror
{
	import lib.mirror.input.InputType;

	public class Platform 
	{
		public static const AIR_DESKTOP:Platform = new Platform("Adobe AIR for Desktop", InputType.KEYBOARD, 2);
		public static const AIR_MOBILE:Platform = new Platform("Adobe AIR for Mobile", InputType.TOUCH, 1);
		public static const FLASH_PLAYER:Platform = new Platform("Adobe Flash Player", InputType.KEYBOARD, 2);
		
		private var name:String;
		private var inputType:InputType;
		private var shaderLevel:int;
		
		public function Platform(name:String, inputType:InputType, shaderLevel:int)
		{
			this.name = name;
			this.inputType = inputType;
			this.shaderLevel = shaderLevel;
		}
		
		public function getName():String
		{
			return this.name;
		}
		
		public function getInputType():InputType
		{
			return this.inputType;
		}
		
		public function getShaderLevel():int
		{
			return this.shaderLevel;
		}
	}
}
