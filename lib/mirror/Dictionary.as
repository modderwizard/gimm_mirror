package lib.mirror
{
	public class Dictionary 
	{
		private var keys:Vector.<Object> = new Vector.<Object>();
		private var values:Vector.<Object> = new Vector.<Object>();
		
		public function get(key:Object):Object
		{
			return this.values[this.keys.indexOf(key)];
		}
		
		public function put(key:Object, value:Object):void
		{
			this.keys.push(key);
			this.values.push(value);
		}
		
		public function remove(key:Object):void
		{
			this.values.removeAt(this.keys.indexOf(key));
			this.keys.removeAt(this.keys.indexOf(key));
		}
		
		public function removeFromValue(value:Object):void
		{
			this.keys.removeAt(this.values.indexOf(value));
			this.values.removeAt(this.values.indexOf(value));
		}
		
		public function hasKey(key:Object):Boolean
		{
			return this.keys.indexOf(key) > -1;
		}
		
		public function hasValue(value:Object):Boolean
		{
			return this.values.indexOf(value) > -1;
		}
		
		public function getKeys():Vector.<Object>
		{
			return this.keys;
		}
		
		public function getValues():Vector.<Object>
		{
			return this.values;
		}
	}
}
