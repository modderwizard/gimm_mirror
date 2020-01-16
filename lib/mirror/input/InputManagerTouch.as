package lib.mirror.input
{
	import starling.display.Stage;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class InputManagerTouch implements IInputManager
	{
		private var touchPhase:String = TouchPhase.ENDED, touchPhasePrev:String = TouchPhase.ENDED;
		private var touchQuadrant:int = 0;
		
		public function initialize(stage:Stage):void
		{
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function update():void
		{
			touchPhasePrev = touchPhase;
			
			if(this.touchPhase == TouchPhase.BEGAN)
			{
				this.touchPhase = TouchPhase.STATIONARY;
			}
		}
		
		private function onTouch(evt:TouchEvent):void
		{
			if(evt.touches[0].phase == TouchPhase.BEGAN || evt.touches[0].phase == TouchPhase.ENDED)
			{
				this.touchPhasePrev = this.touchPhase;
				this.touchPhase = evt.touches[0].phase;
				
				if(this.touchPhase == TouchPhase.BEGAN)
				{
					if(evt.touches[0].globalX < 200)
					{
						this.touchQuadrant = 2;
					}
					else
					{
						this.touchQuadrant = (evt.touches[0].globalY < (720 / 2)) ? 0 : 1;
					}
				}
			}
		}
		
		public function isInputDown(input:Input):Boolean
		{
			return this.touchPhase != TouchPhase.ENDED && input.getKeybindForType(InputType.TOUCH) == this.touchQuadrant;
		}
		
		public function isInputPressed(input:Input):Boolean
		{
			return this.touchPhase == TouchPhase.BEGAN && input.getKeybindForType(InputType.TOUCH) == this.touchQuadrant;
		}
		
		public function isInputReleased(input:Input):Boolean
		{
			return this.touchPhase == TouchPhase.ENDED && this.touchPhasePrev != TouchPhase.ENDED && input.getKeybindForType(InputType.TOUCH) == this.touchQuadrant;
		}
	}
}