package lib.mirror.entity
{
    public class EntityPlayerVillain extends EntityPlayer
    {
        public function EntityPlayerVillain()
        {
            super("villain", EntityPlayerPower.FIRE);
        }
		
		public override function getIdentifier():String
		{
			return "EntityPlayerVillain";
		}
    }
}