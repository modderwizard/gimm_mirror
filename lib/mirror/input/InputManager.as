package lib.mirror.input
{
	import starling.display.Stage;
	
	public class InputManager
	{
		private static var inputManager:IInputManager;
		
		public static function createForType(type:InputType):void
		{
			InputManager.inputManager = type.createManager();
		}
		
		public static function initialize(stage:Stage):void
		{
			InputManager.inputManager.initialize(stage);
		}
		
		public static function update():void
		{
			InputManager.inputManager.update();
		}
		
		public static function isInputDown(input:Input):Boolean
		{
			return InputManager.inputManager.isInputDown(input);
		}
		
		public static function isInputPressed(input:Input):Boolean
		{
			return InputManager.inputManager.isInputPressed(input);
		}
		
		public static function isInputReleased(input:Input):Boolean
		{
			return InputManager.inputManager.isInputReleased(input);
		}
	}
}