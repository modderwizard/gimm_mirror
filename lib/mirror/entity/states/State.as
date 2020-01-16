package lib.mirror.entity.states
{
	import lib.mirror.entity.Entity;
	
	public interface State 
	{
		function update(entity:Entity):void;
		function enter(entity:Entity):void;
		function exit(entity:Entity):void;
		
		function getIdentifier():String;
	}
}
