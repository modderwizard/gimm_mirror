package lib.mirror.input
{
	import flash.ui.GameInput;
	import flash.ui.GameInputDevice;
	
	import starling.display.Stage;
	
	public class InputManagerGamepad implements IInputManager
	{
		private var inputDevice:GameInputDevice = null;
		
		private var controlStatesCurrent:Vector.<Number> = new Vector.<Number>();
		private var controlStatesPrevious:Vector.<Number> = new Vector.<Number>();
		
		public function initialize(stage:Stage):void
		{
			for(var i:int = 0; i < GameInput.numDevices; i++)
			{
				if(this.inputDevice == null)
				{
					this.inputDevice = GameInput.getDeviceAt(i);
				}
			}
			
			trace(GameInput.numDevices);
		}
		
		public function update():void
		{
			if(this.inputDevice != null)
			{
				this.controlStatesPrevious = this.controlStatesCurrent;
			
				for(var i:int = 0; i < this.inputDevice.numControls; i++)
				{
					this.controlStatesCurrent[i] = this.inputDevice.getControlAt(i).value;
				}
			}
		}
		
		public function isInputDown(input:Input):Boolean
		{
			return this.controlStatesCurrent[input.getKeybindForType(InputType.GAMEPAD)] > 0;
		}
		
		public function isInputPressed(input:Input):Boolean
		{
			return false;
		}
		
		public function isInputReleased(input:Input):Boolean
		{
			return false;		
		}
	}
}