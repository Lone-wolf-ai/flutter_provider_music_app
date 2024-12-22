import 'package:audio_app/controller/controller.dart';
import 'package:audio_app/controller/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioPlayerView extends StatelessWidget {
  final VoidCallback picfile;

  const AudioPlayerView(
      {super.key,
      required this.picfile,
      required AudioPlayerController controller});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    final controller =
        context.watch<AudioPlayerControllerProvider>().controller;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: "Play",
              key: const Key('play_button'),
              onPressed: controller.isPlaying ? null : controller.play,
              iconSize: 48.0,
              icon: const Icon(
                Icons.play_arrow_rounded,
                color: Colors.amber,
              ),
              color: color,
            ),
            IconButton(
              key: const Key('pause_button'),
              onPressed: controller.isPlaying ? controller.pause : null,
              iconSize: 48.0,
              icon: const Icon(
                Icons.pause_rounded,
                color: Colors.amber,
              ),
              color: color,
            ),
            IconButton(
              key: const Key('stop_button'),
              onPressed: controller.isPlaying || controller.isPaused
                  ? controller.stop
                  : null,
              iconSize: 48.0,
              icon: const Icon(
                Icons.stop_rounded,
                color: Colors.amber,
              ),
              color: color,
            ),
            IconButton(
              onPressed: () {
                final position = controller.position ?? Duration.zero;
                final duration = controller.duration ?? Duration.zero;
                controller.update(
                    position + const Duration(seconds: 10), duration);
              },
              icon: const Icon(
                Icons.skip_next_rounded,
                color: Colors.amber,
                size: 48,
              ),
            ),
            IconButton(
              onPressed: picfile,
              icon: const Icon(
                Icons.list_rounded,
                color: Colors.amber,
              ),
              iconSize: 36,
            ),
          ],
        ),
        Slider(
          activeColor: Colors.amber,
          inactiveColor: Colors.grey,
          onChanged: (value) {
            final duration = controller.duration;
            if (duration == null) {
              return;
            }
            final position = value * duration.inMilliseconds;
            controller.update(
                Duration(milliseconds: position.round()), duration);
          },
          value: (controller.position != null &&
                  controller.duration != null &&
                  controller.position!.inMilliseconds > 0 &&
                  controller.position!.inMilliseconds <
                      controller.duration!.inMilliseconds)
              ? controller.position!.inMilliseconds /
                  controller.duration!.inMilliseconds
              : 0.0,
        ),
        Semantics(
          label: "Play button",
          child: Text(
            controller.position != null
                ? '${controller.positionText} / ${controller.durationText}'
                : controller.duration != null
                    ? controller.durationText
                    : '',
            style: const TextStyle(fontSize: 16.0, color: Colors.amber),
          ),
        ),
      ],
    );
  }
}
