package lib.mirror.level.tile
{
	public class TileTutorialSign extends Tile
	{
		private const metaTexMap:Vector.<String> = new <String>["Sign_Jump", "Sign_Slide", "Sign_Power", "Sign_Jump2", "Sign_Slide2"];
		
		public function TileTutorialSign(metadata:int)
		{
			super(metadata, metaTexMap[metadata]);
		}
		
		public override function isSolid():Boolean
		{
			return false;
		}
	}
}