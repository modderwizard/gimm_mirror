package lib.mirror.graphics.shaders
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	
	import starling.rendering.FilterEffect;
	import starling.rendering.Program;
	
	public class CrtBrightenEffect extends FilterEffect
	{
		private const fragSource:String = "tex ft5, v0.xy, fs0 <2d, clamp, linear, mipnone>\nmov ft5.w, fc0.z\nadd ft5.xyz, ft5.xyz, fc0.yyy\nmov oc, ft5";
		
		protected override function createProgram():Program
		{
			return Program.fromSource(STD_VERTEX_SHADER, fragSource, 1);
		}
		
		protected override function beforeDraw(context:Context3D):void
		{
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, new <Number>[0, 0.1, 1.0, 0]);
			
			super.beforeDraw(context);
		}
	}
}
