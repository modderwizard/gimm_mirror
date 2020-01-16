package lib.mirror.entity
{
    public class EntityNpcCivilian extends EntityNpc
    {
        public function EntityNpcCivilian()
        {
			super("Civilian");
        }
		
		public override function getIdentifier():String
		{
			return "EntityNpcCivilian";
		}
    }
}