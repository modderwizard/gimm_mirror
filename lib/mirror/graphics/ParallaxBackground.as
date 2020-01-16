package lib.mirror.graphics
{
	import starling.display.DisplayObject;
	import starling.display.Sprite;

	public class ParallaxBackground extends Sprite
	{
		private var layers:Vector.<ParallaxLayer> = new Vector.<ParallaxLayer>();
		
		private var cameraOwner:DisplayObject;
		
		public function ParallaxBackground(cameraOwner:DisplayObject)
		{
			this.cameraOwner = cameraOwner;
		}
		
		public function addLayer(imageName:String, scrollSpeedHorizontal:Number, scrollSpeedVertical:Number, initialOffsetX:Number, initialOffsetY:Number):ParallaxBackground
		{
			var layer:ParallaxLayer = new ParallaxLayer(this.cameraOwner, imageName, scrollSpeedHorizontal, scrollSpeedVertical, initialOffsetX, initialOffsetY);
			this.layers.push(layer);
			this.addChild(layer);
			
			return this;
		}
		
		public function update():void
		{
			for each(var layer:ParallaxLayer in this.layers)
			{
				layer.update();
			}
		}
	}
}