package lib.mirror.input
{
	import starling.display.Stage;
	
	public interface IInputManager
	{
		function initialize(stage:Stage):void;
		
		function update():void;
		
		function isInputDown(input:Input):Boolean;
		function isInputPressed(input:Input):Boolean;
		function isInputReleased(input:Input):Boolean;
	}
}