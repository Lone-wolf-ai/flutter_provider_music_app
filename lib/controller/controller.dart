import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import '../model/audiomodel.dart';

class AudioPlayerController {
  final AudioPlayerModel model;
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;
  get duration => _duration;
  get position => _position;
  get playerstate => _playerState;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;

  AudioPlayerController(this.model) {
    _initStreams();
  }

  bool get isPlaying => _playerState == PlayerState.playing;
  bool get isPaused => _playerState == PlayerState.paused;
  String get durationText => _duration?.toString().split('.').first ?? '';
  String get positionText => _position?.toString().split('.').first ?? '';

  void _initStreams() {
    _durationSubscription = model.onDurationChanged.listen((duration) {
      _duration = duration;
    });

    _positionSubscription = model.onPositionChanged.listen((p) {
      _position = p;
    });

    _playerCompleteSubscription = model.onPlayerComplete.listen((event) {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });

    _playerStateChangeSubscription = model.onPlayerStateChanged.listen((state) {
      _playerState = state;
    });
  }

  Future<void> setSource(String path) async {
    await model.setSource(path);
  }

  Future<void> play() async {
    await model.play();
    _playerState = PlayerState.playing;
  }

  Future<void> pause() async {
    await model.pause();
    _playerState = PlayerState.paused;
  }

  Future<void> stop() async {
    await model.stop();
    _playerState = PlayerState.stopped;
    _position = Duration.zero;
  }

  void update(Duration position, Duration duration) {
    _position = position;
    _duration = duration;
    model.seek(position);
  }

  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
  }
}
