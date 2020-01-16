package lib.mirror.graphics
{
	import flash.geom.Point;
	
	import starling.display.Image;

	public class AnimationFrame
	{
		private var image:Image;
		private var offset:Point;
		private var duration:int;
		
		public function AnimationFrame(image:Image, xOffset:int, yOffset:int, duration:int)
		{
			this.image = image;
			this.image.x = xOffset;
			this.image.y = yOffset;
			this.image.textureSmoothing = "none";
			
			this.offset = new Point(xOffset, yOffset);
			this.duration = duration;
		}
		
		public function getImage():Image
		{
			return this.image;
		}
		
		public function getOffset():Point
		{
			return this.offset;
		}
		
		public function getDuration():int
		{
			return this.duration;
		}
	}
}
