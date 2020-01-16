package lib.mirror.level.tile
{
	import starling.display.Sprite;
	
	import lib.mirror.Assets;
	import lib.mirror.entity.Entity;
	import lib.mirror.level.Level;
	import lib.mirror.physics.Quadrilateral;
	
	public class Tile extends Sprite
	{
		protected var metadata:int;
		
		public var level:Level;
		
		public var boundingBox:Quadrilateral = new Quadrilateral();
		public var xOffset:Number = 0, yOffset:Number = 0;
		
		public function Tile(metadata:int, onlyTexture:String = null)
		{
			this.metadata = metadata;
			
			if(onlyTexture != null)
			{
				this.addChild(Assets.getQuadWithTexture(onlyTexture));
			}
			
			this.boundingBox = this.boundingBox.fromPositionAndSize(0, 0, 16, 16);
		}
		
		public function isSolid():Boolean
		{
			return true;
		}
		
		public function onAddedToLevel():void
		{
			
		}
		
		public function onRemovedFromLevel():void
		{
			
		}
		
		public function onEntityCollide(entity:Entity, side:String):void
		{
			
		}
		
		public function canCollideWithSide(side:String):Boolean
		{
			return this.isSolid();
		}
	}
}