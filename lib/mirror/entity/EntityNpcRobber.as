package lib.mirror.entity
{
    public class EntityNpcRobber extends EntityNpc
    {
        public function EntityNpcRobber()
        {
			super("Robber");
        }
		
		public override function getIdentifier():String
		{
			return "EntityNpcRobber";
		}
    }
}