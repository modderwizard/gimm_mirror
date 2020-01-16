package lib.mirror.graphics.shaders
{
	import starling.filters.FragmentFilter;
	import starling.rendering.FilterEffect;
	
	public class CrtBrightenFilter extends FragmentFilter
	{
		protected override function createEffect():FilterEffect
		{
			return new CrtBrightenEffect();
		}
	}
}
