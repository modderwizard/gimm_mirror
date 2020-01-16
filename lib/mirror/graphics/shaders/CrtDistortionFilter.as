package lib.mirror.graphics.shaders
{
	import starling.filters.FragmentFilter;
	import starling.rendering.FilterEffect;
	
	public class CrtDistortionFilter extends FragmentFilter
	{
		private var resolutionWidth:int, resolutionHeight:int;
		private var distortFactor:Number;
		
		public function CrtDistortionFilter(resolutionWidth:int, resolutionHeight:int, distortFactor:Number)
		{
			this.resolutionWidth = resolutionWidth;
			this.resolutionHeight = resolutionHeight;
			this.distortFactor = distortFactor;
		}
		
		protected override function createEffect():FilterEffect
		{
			return new CrtDistortionEffect(this.resolutionWidth, this.resolutionHeight, this.distortFactor);
		}
	}
}
