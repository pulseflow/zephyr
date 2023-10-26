using Godot;
using System;
using Godot.Collections;

namespace Zephyr.Core
{
	public partial class Sync : Node
	{
		[Export] public double Bpm = 124;
		private double _bps;
		private double _hbps;
		private double _last_half_beat;
		private AudioStreamPlayer _stream;
		
		public override void _Ready()
		{
			Connect("track_selected", new Callable(this, MethodName._LoadTrack))
		}

		public void PlayAudio()
		{
			var timeDelay = AudioServer.GetTimeToNextMix() + AudioServer.GetOutputLatency();
			GetTree().CreateTimer(timeDelay);
			
			_stream.Play();
		}
		
		public override void _Process(double delta)
		{
			var time =
				_stream.GetPlaybackPosition()
				+ AudioServer.GetTimeSinceLastMix()
				- AudioServer.GetOutputLatency();
			
		}

		private void _LoadTrack()
		{
			_stream.Stream = GD.Load()
		}
	}
}