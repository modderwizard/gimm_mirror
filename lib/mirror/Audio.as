package lib.mirror
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;

	public class Audio
	{
		private static var soundMappings:Dictionary = new Dictionary();
		
		private static var playingMusic:Dictionary = new Dictionary();
		
		public static var volumeMultiplier:Number = 1.0;
		
		public static const DEFAULT:SoundTransform = new SoundTransform(volumeMultiplier, 0.0);
		public static const DEFAULT_MUSIC:SoundTransform = new SoundTransform(volumeMultiplier / 2.0, 0.0);
		
		public static const PAN_LEFT:SoundTransform = new SoundTransform(volumeMultiplier, -1.0);
		public static const PAN_RIGHT:SoundTransform = new SoundTransform(volumeMultiplier, 1.0);
		
		// Static initializer
		{
			Audio.soundMappings.put("ArcadeMusic", new SoundArcadeMusic());
			Audio.soundMappings.put("Glitch", new SoundGlitch());
			Audio.soundMappings.put("Helicopter", new SoundHelicopter());
			Audio.soundMappings.put("Hurt", new SoundHurt2());
			Audio.soundMappings.put("Jump", new SoundJump());
			Audio.soundMappings.put("Land", new SoundLand2());
			Audio.soundMappings.put("Music1", new SoundMusic1());
			Audio.soundMappings.put("Power", new SoundPower());
			Audio.soundMappings.put("Shoot", new SoundShoot());
			Audio.soundMappings.put("Siren", new SoundSiren());
			Audio.soundMappings.put("Slide", new SoundSlide());
			Audio.soundMappings.put("Smoke", new SoundSmoke());
		}
		
		private static function _play(soundName:String, loops:int, soundTransform:SoundTransform):void
		{
			if(!Audio.playingMusic.hasKey(soundName))
			{
				var soundChannel:SoundChannel = (Audio.soundMappings.get(soundName) as Sound).play(0, loops, soundTransform);
				soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				
				Audio.playingMusic.put(soundName, soundChannel);
			}
		}
		
		private static function onSoundComplete(evt:Event):void
		{
			Audio.playingMusic.removeFromValue(evt.target);
		}
		
		public static function play(soundName:String, soundTransform:SoundTransform = null):void
		{
			Audio._play(soundName, 0, soundTransform == null ? Audio.DEFAULT : soundTransform);
		}
		
		public static function playLooping(soundName:String, soundTransform:SoundTransform = null):void
		{
			Audio._play(soundName, int.MAX_VALUE, soundTransform == null ? Audio.DEFAULT_MUSIC : soundTransform);
		}
		
		public static function stop(soundName:String):void
		{
			if(Audio.playingMusic.hasKey(soundName))
			{
				(Audio.playingMusic.get(soundName) as SoundChannel).stop();
				Audio.playingMusic.remove(soundName);
			}
		}
		
		public static function setVolume(soundName:String, volume:Number):void
		{
			if(Audio.playingMusic.hasKey(soundName))
			{
				var sound:SoundChannel = (Audio.playingMusic.get(soundName) as SoundChannel);
				sound.soundTransform = new SoundTransform(MathHelper.clamp(volume, 0.0, 1.0) * (Audio.volumeMultiplier / 2.0), sound.soundTransform.pan);
			}
		}
	}
}