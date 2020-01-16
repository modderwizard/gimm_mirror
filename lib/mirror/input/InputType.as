package lib.mirror.input
{
	import lib.mirror.Dictionary;
	
	public class InputType
	{
		public static var KEYBOARD:InputType = new InputType("Keyboard", InputManagerKeyboard);
		public static var GAMEPAD:InputType = new InputType("Gamepad", InputManagerGamepad);
		public static var TOUCH:InputType = new InputType("Touch", InputManagerTouch);
		
		private var name:String;
		private var manager:Class;
		
		public function InputType(name:String, manager:Class)
		{
			this.name = name;
			this.manager = manager;
		}
		
		public function getName():String
		{
			return this.name;
		}
		
		public function createManager():IInputManager
		{
			return new this.manager();
		}
	}
}
