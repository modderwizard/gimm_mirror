package lib.mirror
{
	import starling.display.DisplayObject;
	
	import lib.mirror.entity.Entity;

	public class Camera 
	{
		// Flash's dictionary sucks so I made my own
		private static var cameras:Dictionary = new Dictionary();
		
		public static function getCameraForRoot(root:DisplayObject):Camera
		{
			if(!cameras.hasKey(root))
			{
				cameras.put(root, new Camera(root));
			}
			
			return cameras.get(root) as Camera;
		}
		
		public static function getCameraFromTracking(entity:Entity):Camera
		{
			for each(var camera:Camera in Camera.cameras)
			{
				if(camera.getTracking() == entity)
				{
					return camera;
				}
			}
			
			return null;
		}
		
		private var root:DisplayObject = null;
		private var tracking:Entity = null;
		
		private var posX:Number = 0;
		private var posY:Number = 0;
		private var posXPrev:Number = 0;
		private var posYPrev:Number = 0;
		
		public var xOffset:Number = 0;
		
		public function Camera(root:DisplayObject) 
		{
			this.root = root;
		}
		
		public function setTracking(entity:Entity):void
		{
			this.tracking = entity;
		}
		
		public function getTracking():Entity
		{
			return this.tracking;
		}
		
		public function reset():void
		{
			this.tracking = null;
			
			this.posX = 0;
			this.posY = 0;
			this.posXPrev = 0;
			this.posYPrev = 0;
		}
		
		public function update():void
		{
			if(this.getTracking() != null)
			{
				this.posX = this.getTracking().getBoundingBox().topLeft.x - (320 / 2) + (this.getTracking().getBoundingBox().width / 2) + this.xOffset;
			}
		}
		
		public function getPosX():Number
		{
			return this.posX;
		}
		
		public function getPosY():Number
		{
			return this.posY;
		}
	}
}
