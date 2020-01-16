package lib.mirror.graphics.shaders
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	
	import starling.rendering.FilterEffect;
	import starling.rendering.Program;
	
	public class CrtDistortionEffect extends FilterEffect
	{
		private var resolutionWidth:Number, resolutionHeight:Number;
		private var distortFactor:Number;
		
		private var ratioSquared:Number;
		
		private const fragSource:String = "// Store original texcoords\nmov ft0, v0\n\n// Calculate shifted texcoords for algorithm\nmul ft1.xy, ft0.xy, fc1.yy\nsub ft1.xy, ft1.xy, fc1.ww\n\n// Calculate r2\nmul ft2.x, fc0.z, ft1.x\nmul ft2.x, ft2.x, ft1.x\nmul ft2.y, ft1.y, ft1.y\nadd ft2.x, ft2.x, ft2.y\n\n// Calculate f\nsqt ft3.x, ft2.x\nmul ft3.x, ft3.x, fc1.x\nmul ft3.x, ft3.x, ft2.x\nadd ft3.x, ft3.x, fc1.w\n\n// Calculate newtex\nmul ft4.xy, ft1.xy, ft3.xx\nadd ft4.xy, ft4.xy, fc1.ww\ndiv ft4.xy, ft4.xy, fc1.yy\n\n// Sample at newtex\ntex ft5, ft4.xy, fs0 <2d, clamp, linear, mipnone>\nmov ft5.w, fc1.z\n//Brighten the output color\nadd ft5.xyz, ft5.xyz, fc2.xxx\n\n// Write output\nmov oc, ft5";
		
		public function CrtDistortionEffect(resolutionWidth:Number, resolutionHeight:Number, distortFactor:Number)
		{
			this.resolutionWidth = resolutionWidth;
			this.resolutionHeight = resolutionHeight;
			this.distortFactor = distortFactor;
			
			this.ratioSquared = (this.resolutionWidth / this.resolutionHeight) * (this.resolutionWidth / this.resolutionHeight);
		}
		
		protected override function createProgram():Program
		{
			return Program.fromSource(STD_VERTEX_SHADER, fragSource, 1);
		}
		
		protected override function beforeDraw(context:Context3D):void
		{
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, new <Number>[1280.0, 720.0, this.ratioSquared, 0.0, this.distortFactor, 2.0, 0.5, 1.0, 0.1, 0, 0, 0]);
			
			super.beforeDraw(context);
		}
	}
}
