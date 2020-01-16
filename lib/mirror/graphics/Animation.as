package lib.mirror.graphics
{
	public class Animation
	{
		private var name:String;
		private var nextAnimation:String;
		
		private var frames:Vector.<AnimationFrame> = new Vector.<AnimationFrame>();
		private var frameIndex:int = 0;
		private var tick:int = -1;
		
		private var parentIsDirty:Boolean = true;
		
		public function Animation(name:String, nextAnimation:String)
		{
			this.name = name;
			this.nextAnimation = nextAnimation;
		}
		
		public function addFrame(frame:AnimationFrame):void
		{
			this.frames.push(frame);
		}
		
		public function update():void
		{
			if(!this.isFinished())
			{
				this.tick++;
				
				// Should we advance to the next frame?
				if(this.tick == this.frames[this.frameIndex].getDuration())
				{
					// Advance to next frame
					this.frameIndex++;
					this.tick = -1;
					
					this.parentIsDirty = true;
				}
			}
		}
		
		public function getName():String
		{
			return this.name;
		}
		
		public function getNext():String
		{
			return this.nextAnimation;
		}
		
		public function getCurrentFrame():AnimationFrame
		{
			return this.frames[this.frameIndex];
		}
		
		public function isParentDirty():Boolean
		{
			var dirty:Boolean = this.parentIsDirty;
			this.parentIsDirty = false;
			return dirty;
		}
		
		public function isFinished():Boolean
		{
			return this.frameIndex == this.frames.length;
		}
		
		public function reset():void
		{
			this.frameIndex = 0;
			this.tick = -1;
			this.parentIsDirty = true;
		}
	}
}
