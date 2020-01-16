package lib.mirror
{
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Assets 
	{
		// Level data
		[Embed(source="/Level_Top.bclf", mimeType="application/octet-stream")]
		public static const topLevel:Class;
		
		[Embed(source="/Level_Bottom.bclf", mimeType="application/octet-stream")]
		public static const bottomLevel:Class;
		
		// Images
		[Embed(source="/image_assets.xml", mimeType="application/octet-stream")]
		private static const spritesXml:Class;
		
		[Embed(source="/image_assets.png")]
		private static const spritesTexture:Class;
		
		private static var textureAtlas:TextureAtlas = null;
		
		public static function initialize():void
		{
			if(Assets.textureAtlas == null)
			{
				Assets.textureAtlas = new TextureAtlas(Texture.fromEmbeddedAsset(spritesTexture), XML(new spritesXml()));
			}
		}
		
		public static function getTexture(textureName:String):Texture
		{
			return Assets.textureAtlas.getTexture(textureName);
		}
		
		public static function getQuadWithTexture(textureName:String):Quad
		{
			var texture:Texture = Assets.getTexture(textureName);
			
			var quad:Quad = new Quad(texture.width, texture.height);
			quad.texture = texture;
			quad.textureSmoothing = "none";
			
			return quad;
		}
	}
}
