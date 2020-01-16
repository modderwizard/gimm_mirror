package lib.mirror.input
{
	import flash.ui.Keyboard;
	
	import lib.mirror.Dictionary;
	
	public class Input 
	{
		public static var JUMP:Input = new Input().setKeybindForType(InputType.KEYBOARD, Keyboard.SPACE).setKeybindForType(InputType.TOUCH, 0);
		public static var SLIDE:Input = new Input().setKeybindForType(InputType.KEYBOARD, Keyboard.SHIFT).setKeybindForType(InputType.TOUCH, 1);
		public static var SHOOT:Input = new Input().setKeybindForType(InputType.KEYBOARD, Keyboard.ENTER).setKeybindForType(InputType.TOUCH, 2);
		
		public static var SHOW_DEBUG_INFO:Input = new Input().setKeybindForType(InputType.KEYBOARD, Keyboard.NUMBER_1);
		public static var SHOW_HITBOXES:Input = new Input().setKeybindForType(InputType.KEYBOARD, Keyboard.NUMBER_2);
		public static var TOGGLE_CRT_FILTER:Input = new Input().setKeybindForType(InputType.KEYBOARD, Keyboard.NUMBER_3);
		public static var RESTART_LEVEL:Input = new Input().setKeybindForType(InputType.KEYBOARD, Keyboard.NUMBER_4);
		
		public static var MODIFIER_TAB:Input = new Input().setKeybindForType(InputType.KEYBOARD, Keyboard.TAB);
		
		private var keybinds:Dictionary = new Dictionary();
		
		public function setKeybindForType(type:InputType, keybind:uint):Input
		{
			this.keybinds.put(type, keybind);
			
			return this;
		}
		
		public function getKeybindForType(type:InputType):uint
		{
			if(this.keybinds.hasKey(type))
			{
				return this.keybinds.get(type) as uint;
			}
			
			return uint.MAX_VALUE;
		}
	}
}
