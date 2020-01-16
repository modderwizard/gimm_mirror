package lib.mirror.physics
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import lib.mirror.MathHelper;

	public class Quadrilateral
	{
		public var topLeft:Point = new Point(), topRight:Point = new Point(), bottomLeft:Point = new Point(), bottomRight:Point = new Point();
		public var topLine:LineSegment = new LineSegment(), rightLine:LineSegment = new LineSegment(), bottomLine:LineSegment = new LineSegment(), leftLine:LineSegment = new LineSegment();
		public var topLineEnabled:Boolean = true, rightLineEnabled:Boolean = true, bottomLineEnabled:Boolean = true, leftLineEnabled:Boolean = true;
		
		public var width:Number, height:Number;
		
		public var isAxisAligned:Boolean;
		
		private var containerRect:Rectangle = new Rectangle();
		
		private var minimumPoint:Point = new Point(), maximumPoint:Point = new Point(), centerPoint:Point = new Point();
		
		public function fromPoints(p0:Point, p1:Point, p2:Point, p3:Point):Quadrilateral
		{
			this.topLeft.setTo(p0.x, p0.y);
			this.topRight.setTo(p1.x, p1.y);
			this.bottomLeft.setTo(p2.x, p2.y);
			this.bottomRight.setTo(p3.x, p3.y);
			
			this.topLine.setPoints(this.topLeft, this.topRight);
			this.rightLine.setPoints(this.topRight, this.bottomRight);
			this.bottomLine.setPoints(this.bottomRight, this.bottomLeft);
			this.leftLine.setPoints(this.bottomLeft, this.topLeft);
			
			this.width = this.topRight.x - this.topLeft.x;
			this.height = this.bottomLeft.y - this.topLeft.y;
			
			this.isAxisAligned = (this.topLeft.x == this.bottomLeft.x) && (this.topRight.x == this.bottomRight.x) && (this.topLeft.y == this.topRight.y) && (this.bottomLeft.y == this.bottomRight.y);
			
			this.minimumPoint.setTo(Math.min(this.topLeft.x, this.bottomLeft.x), Math.min(this.topLeft.y, this.topRight.y));
			this.maximumPoint.setTo(Math.max(this.topRight.x, this.bottomRight.x), Math.max(this.bottomLeft.y, this.bottomRight.y));
			this.centerPoint.setTo(this.minimumPoint.x + (this.maximumPoint.x - this.minimumPoint.x) / 2, this.minimumPoint.y + (this.maximumPoint.y - this.minimumPoint.y) / 2);
			
			this.containerRect.x = this.minimumPoint.x;
			this.containerRect.y = this.minimumPoint.y;
			this.containerRect.width = this.width;
			this.containerRect.height = this.height;
			
			return this;
		}
		
		public function fromPositionAndSize(x:Number, y:Number, width:Number, height:Number):Quadrilateral
		{
			this.topLeft.setTo(x, y);
			this.topRight.setTo(x + width, y);
			this.bottomLeft.setTo(x, y + height);
			this.bottomRight.setTo(x + width, y + height);
			
			this.topLine.setPoints(this.topLeft, this.topRight);
			this.rightLine.setPoints(this.topRight, this.bottomRight);
			this.bottomLine.setPoints(this.bottomRight, this.bottomLeft);
			this.leftLine.setPoints(this.bottomLeft, this.topLeft);
			
			this.width = width;
			this.height = height;
			
			this.isAxisAligned = true;
			
			this.minimumPoint.setTo(Math.min(this.topLeft.x, this.bottomLeft.x), Math.min(this.topLeft.y, this.topRight.y));
			this.maximumPoint.setTo(Math.max(this.topRight.x, this.bottomRight.x), Math.max(this.bottomLeft.y, this.bottomRight.y));
			this.centerPoint.setTo(this.minimumPoint.x + (this.maximumPoint.x - this.minimumPoint.x) / 2, this.minimumPoint.y + (this.maximumPoint.y - this.minimumPoint.y) / 2);
			
			this.containerRect.x = this.minimumPoint.x;
			this.containerRect.y = this.minimumPoint.y;
			this.containerRect.width = this.width;
			this.containerRect.height = this.height;
			
			return this;
		}
		
		public function copyTo(copyTo:Quadrilateral):Quadrilateral
		{
			copyTo.bottomLineEnabled = this.bottomLineEnabled;
			copyTo.leftLineEnabled = this.leftLineEnabled;
			copyTo.topLineEnabled = this.topLineEnabled;
			copyTo.rightLineEnabled = this.rightLineEnabled;
			
			return copyTo.fromPoints(this.topLeft, this.topRight, this.bottomLeft, this.bottomRight);
		}
		
		public function offsetBy(x:Number, y:Number):Quadrilateral
		{
			this.topLeft.setTo(this.topLeft.x + x, this.topLeft.y + y);
			this.topRight.setTo(this.topRight.x + x, this.topRight.y + y);
			this.bottomLeft.setTo(this.bottomLeft.x + x, this.bottomLeft.y + y);
			this.bottomRight.setTo(this.bottomRight.x + x, this.bottomRight.y + y);
			
			return this.fromPoints(this.topLeft, this.topRight, this.bottomLeft, this.bottomRight);
		}
		
		public function getMinimumPoint():Point
		{
			return this.minimumPoint;
		}
		
		public function getMaximumPoint():Point
		{
			return this.maximumPoint;
		}
		
		public function getCenterPoint():Point
		{
			return this.centerPoint;
		}
		
		public function getContainerRect():Rectangle
		{
			return this.containerRect;
		}
		
		public function getLines():Array
		{
			var array:Array = new Array();
			
			if(this.topLineEnabled)
			{
				array.push(this.topLine);
			}
			
			if(this.bottomLineEnabled)
			{
				array.push(this.bottomLine);
			}
			
			if(this.leftLineEnabled)
			{
				array.push(this.leftLine);
			}
			
			if(this.rightLineEnabled)
			{
				array.push(this.rightLine);
			}
			
			return array;
		}
		
		public function clipPointTo(point:Point):void
		{
			point.x = MathHelper.clamp(point.x, this.minimumPoint.x, this.maximumPoint.x);
			point.y = MathHelper.clamp(point.y, this.minimumPoint.y, this.maximumPoint.y);
		}
	}
}
