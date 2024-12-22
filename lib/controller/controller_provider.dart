import 'package:flutter/material.dart';
import 'controller.dart';

class AudioPlayerControllerProvider with ChangeNotifier {
  final AudioPlayerController _controller;

  AudioPlayerControllerProvider(this._controller) {
    _controller.model.onDurationChanged.listen((_) => notifyListeners());
    _controller.model.onPositionChanged.listen((_) => notifyListeners());
    _controller.model.onPlayerStateChanged.listen((_) => notifyListeners());
  }

  AudioPlayerController get controller => _controller;

  Future<void> setSource(String path) async {
    await _controller.setSource(path);
    notifyListeners();
  }

  Future<void> update(Duration duration, Duration position) async {
    _controller.update(position, duration);
    notifyListeners();
  }

  Future<void> play() async {
    await _controller.play();
    notifyListeners();
  }

  Future<void> pause() async {
    await _controller.pause();
    notifyListeners();
  }

  Future<void> stop() async {
    await _controller.stop();
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
