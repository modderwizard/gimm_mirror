using System;

namespace Jvernon.RedFox.Vulpine
{
	public class TextureFXFire : TextureFX
	{
		private double[] intensity;
		private double[] previousIntensity;

		public TextureFXFire(int width, int height) : base(width, height, 30)
		{
			this.intensity = new double[this.GetWidth() * this.GetHeight() * 4];
			this.previousIntensity = new double[this.GetWidth() * this.GetHeight() * 4];
		}

		public override void Update(float delta, bool force)
		{
			this.previousIntensity = this.intensity;

			if(!this.ShouldUpdate(delta, force))
			{
				return;
			}

			// Calculate intensity variables
			for(int y = 0; y < this.GetHeight(); y++)
			{
				for(int x = 0; x < this.GetWidth(); x++)
				{
					if(y == this.GetHeight() - 1)
					{
						this.intensity[x + this.GetWidth() * y] = this.random.NextDouble() * this.random.NextDouble() * 1.2F;
					}
					else
					{
						float intensitySubtraction = 0.1F * (1.0F - (((float)y) / this.GetHeight())) * (float)this.random.NextDouble() * 1.1F * (float)this.random.NextDouble();
						if(this.GetHeight() >= 16)
						{
							intensitySubtraction /= (this.GetHeight() / 16);
						}

						if(x == 0 || x == this.GetWidth() - 1)
						{
							intensitySubtraction += 0.5F;
						}

						float intensityMultiplier = 1.0F - Math.Abs(x - (this.GetWidth() / 2.0F)) / (this.GetWidth() / 1.5F);
						intensityMultiplier = MathUtils.Clamp(intensityMultiplier, 0.0F, 0.9F);

						this.intensity[x + this.GetWidth() * y] = (this.previousIntensity[x + this.GetWidth() * (y + 1)] - intensitySubtraction) * intensityMultiplier;
					}
				}
			}

			// Convert intensity to color
			for(int y = 0; y < this.GetHeight(); y++)
			{
				for(int x = 0; x < this.GetWidth(); x++)
				{
					int index = x + this.GetWidth() * y;
					float intensity = MathUtils.Clamp((float)this.intensity[index] * 1.1F, 0.0F, 1.0F);

					byte alpha = 255;
					if(intensity == 0.00F)
					{
						alpha = 0;
					}

					byte red = (byte)(intensity * 100 + 155);
					byte green = (byte)(intensity * 255);
					byte blue = (byte)(intensity * intensity * intensity * intensity * 255);

					this.pixelData[index * 4 + 0] = red;
					this.pixelData[index * 4 + 1] = green;
					this.pixelData[index * 4 + 2] = blue;
					this.pixelData[index * 4 + 3] = alpha;
				}
			}
		}
	}
}
