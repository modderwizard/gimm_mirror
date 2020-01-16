package lib.mirror.graphics
{
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	import lib.mirror.Assets;
	import lib.mirror.Camera;

	public class ParallaxLayer extends Sprite
	{
		private var cameraOwner:DisplayObject;
		
		// Three instances of the background
		public var bgLeft:Quad, bgCenter:Quad, bgRight:Quad;
		
		// Parallax scrolling speeds
		public var scrollSpeedHorizontal:Number, scrollSpeedVertical:Number;
		
		// Manually offsets the position
		private var initialOffsetX:Number, initialOffsetY:Number;
		
		public function ParallaxLayer(cameraOwner:DisplayObject, imageName:String, scrollSpeedHorizontal:Number, scrollSpeedVertical:Number, initialOffsetX:Number, initialOffsetY:Number)
		{
			this.cameraOwner = cameraOwner;
			
			// Init background instances
			this.bgCenter = Assets.getQuadWithTexture(imageName);
			this.bgLeft = Assets.getQuadWithTexture(imageName);
			this.bgRight = Assets.getQuadWithTexture(imageName);
			
			this.addChild(this.bgCenter);
			this.addChild(this.bgLeft);
			
			this.addChild(this.bgRight);
			
			this.scrollSpeedHorizontal = scrollSpeedHorizontal;
			this.scrollSpeedVertical = scrollSpeedVertical;
			
			this.initialOffsetX = initialOffsetX;
			this.initialOffsetY = initialOffsetY;
		}
		
		public function update():void
		{
			// Calculate the background position from the camera position
			var cameraScrollHorizontal:Number = Camera.getCameraForRoot(this.cameraOwner).getPosX() % int(320 / this.scrollSpeedHorizontal);
			if(this.scrollSpeedHorizontal == 0)
			{
				cameraScrollHorizontal = 0;
			}
			
			var cameraScrollVertical:Number = Camera.getCameraForRoot(this.cameraOwner).getPosY();
			
			// Apply the movement to the background
			this.bgCenter.x = -(cameraScrollHorizontal * this.scrollSpeedHorizontal) + this.initialOffsetX;
			this.bgCenter.y = -(cameraScrollVertical * this.scrollSpeedVertical) + this.initialOffsetY;
			
			// Adjust the position of the two other instances based
			this.bgLeft.x = this.bgCenter.x - this.bgCenter.width;
			this.bgLeft.y = this.bgCenter.y;
			
			this.bgRight.x = this.bgCenter.x + this.bgCenter.width;
			this.bgRight.y = this.bgCenter.y;
		}
	}
}