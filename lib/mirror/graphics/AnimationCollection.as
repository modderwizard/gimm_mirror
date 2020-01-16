package lib.mirror.graphics
{
	import starling.display.Image;
	import starling.display.Sprite;
	
	import lib.mirror.Assets;
	import lib.mirror.Dictionary;
	
	public class AnimationCollection extends Sprite
	{
		private var animations:Dictionary = new Dictionary();
		private var currentAnimation:Animation = null;
		
		public function update():void
		{
			if(this.currentAnimation != null)
			{
				this.currentAnimation.update();
				
				if(this.currentAnimation.isFinished())
				{
					if(this.currentAnimation.getNext() == this.currentAnimation.getName())
					{
						this.currentAnimation.reset();
					}
					else
					{
						this.setAnimation(this.currentAnimation.getNext());
					}
				}
				else if(this.currentAnimation.isParentDirty())
				{
					this.removeChildren();
					this.addChild(this.currentAnimation.getCurrentFrame().getImage());
				}
			}
		}
		
		public function setAnimation(anim:String):void
		{
			if(this.animations.hasKey(anim))
			{
				if(this.currentAnimation != null)
				{
					this.currentAnimation.reset();
				}
				
				this.removeChildren();
				this.currentAnimation = this.animations.get(anim) as Animation;
				this.addChild(this.currentAnimation.getCurrentFrame().getImage());
			}
			else
			{
				throw new Error("AnimationCollection does not contain a definition for the animation '" + anim + "'!");
			}
		}
		
		public function getAnimationName():String
		{
			if(this.currentAnimation == null)
			{
				return "NULL";
			}
			
			return this.currentAnimation.getName();
		}
		
		public function load(data:Array):void
		{
			var animation:Animation = null;
			
			// Loop every line in the definition file
			for each(var fileLine:String in data)
			{
				var line:Array = fileLine.split(' ');
				
				if(line[0] == "ANIM")
				{
					animation = new Animation(line[1], line[2]);
				}
				else if(line[0] == "FRAME")
				{
					var frame:AnimationFrame = new AnimationFrame(new Image(Assets.getTexture(line[1])), parseInt(line[2]), parseInt(line[3]), parseInt(line[4]));
					animation.addFrame(frame);
				}
				else if(line[0] == "END")
				{
					this.animations.put(animation.getName(), animation);
					animation = null;
				}
			}
		}
	}
}
