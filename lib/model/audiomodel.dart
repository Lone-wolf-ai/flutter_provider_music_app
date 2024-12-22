import 'package:audioplayers/audioplayers.dart';

class AudioPlayerModel {
  final AudioPlayer player;

  AudioPlayerModel(this.player);

  Future<void> setSource(String path) async {
    await player.setSource(DeviceFileSource(path));
  }

  Future<void> play() async {
    await player.resume();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> seek(Duration position) async {
    await player.seek(position);
  }

  Future<void> stop() async {
    await player.stop();
  }

  Future<Duration?> getDuration() async {
    return await player.getDuration();
  }

  Future<Duration?> getCurrentPosition() async {
    return await player.getCurrentPosition();
  }

  Stream<Duration> get onDurationChanged => player.onDurationChanged;
  Stream<Duration> get onPositionChanged => player.onPositionChanged;
  Stream<void> get onPlayerComplete => player.onPlayerComplete;
  Stream<PlayerState> get onPlayerStateChanged => player.onPlayerStateChanged;
}
