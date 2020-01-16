package lib.mirror.entity
{
    public class EntityPlayerHero extends EntityPlayer
    {
        public function EntityPlayerHero()
        {
            super("hero", EntityPlayerPower.WATER);
        }
		
		public override function getIdentifier():String
		{
			return "EntityPlayerHero";
		}
    }
}