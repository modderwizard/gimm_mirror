package lib.mirror.input
{
	import starling.display.Stage;
	import starling.events.KeyboardEvent;
	
	public class InputManagerKeyboard implements IInputManager
	{
		private var keyStatesCurrent:Array = new Array();
		private var keyStatesPrevious:Array = new Array();		
		
		public function initialize(stage:Stage):void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		public function update():void
		{
			this.keyStatesPrevious = this.keyStatesCurrent;
			
			// Change 'press' to 'down'
			for(var i:uint = 0; i < this.keyStatesCurrent.length; i++)
			{
				if(this.keyStatesCurrent[i] == 1)
				{
					this.keyStatesCurrent[i] = 2;
				}
			}
		}
		
		private function onKeyDown(evt:KeyboardEvent):void
		{
			if(keyStatesCurrent[evt.keyCode] == null)
			{
				keyStatesCurrent[evt.keyCode] = 1;
			}
		}
		
		private function onKeyUp(evt:KeyboardEvent):void
		{
			keyStatesCurrent[evt.keyCode] = null;
		}
		
		public function isInputDown(input:Input):Boolean
		{
			return this.keyStatesCurrent[input.getKeybindForType(InputType.KEYBOARD)] != null;
		}
		
		public function isInputPressed(input:Input):Boolean
		{
			return this.keyStatesCurrent[input.getKeybindForType(InputType.KEYBOARD)] == 1;
		}
		
		public function isInputReleased(input:Input):Boolean
		{
			return this.keyStatesCurrent[input.getKeybindForType(InputType.KEYBOARD)] == null && this.keyStatesPrevious[input.getKeybindForType(InputType.KEYBOARD)] != null;
		}
	}
}