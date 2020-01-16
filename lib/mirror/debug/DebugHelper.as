package lib.mirror.debug
{
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFormat;
	
	import lib.mirror.physics.Quadrilateral;
	
	public class DebugHelper extends Sprite
	{
		private static var instance:DebugHelper = null;
		
		private static var textField:TextField = new TextField(1280, 720, "", new TextFormat("Verdana", 12, 0xFFFFFF, "left", "top"));
		private static var scale:Number = 1;
		
		private static var drawCache:Vector.<Quad> = new Vector.<Quad>();
		private static var drawAmount:int = -1;
		
		public static function getInstance():DebugHelper
		{
			if(DebugHelper.instance == null)
			{
				DebugHelper.instance = new DebugHelper();
			}
			
			return DebugHelper.instance;
		}
		
		private static function getQuadFromCache():Quad
		{
			DebugHelper.drawAmount++;
			
			if(DebugHelper.drawAmount >= DebugHelper.drawCache.length)
			{
				DebugHelper.drawCache.push(new Quad(2, 2));
			}
			
			return DebugHelper.drawCache[DebugHelper.drawAmount];
		}
		
		public static function setScale(scale:int):void
		{
			DebugHelper.scale = scale;
		}
		
		public static function clear():void
		{
			DebugHelper.drawAmount = -1;
			DebugHelper.instance.removeChildren();
			DebugHelper.instance.addChild(DebugHelper.textField);
			DebugHelper.textField.text = "";
		}
		
		public static function addText(text:String):void	
		{
			DebugHelper.textField.text += text;
		}
		
		public static function drawQuadrilateral(quad:Quadrilateral, color:uint = 0, opacity:Number = 0.5):void
		{
			DebugHelper.drawRectangle(quad.topLeft.x, quad.topLeft.y, quad.width, quad.height, color, opacity);
		}
		
		public static function drawRectangle(x:Number, y:Number, width:Number, height:Number, color:uint = 0, opacity:Number = 0.5):void
		{			
			var quad:Quad = DebugHelper.getQuadFromCache();
			
			quad.width = width * DebugHelper.scale;
			quad.height = height * DebugHelper.scale;
			quad.color = color;
			quad.alpha = opacity;
			quad.x = x * DebugHelper.scale;
			quad.y = y * DebugHelper.scale;
			
			DebugHelper.instance.addChild(quad);
		}
	}
}