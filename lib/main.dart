import 'package:audio_app/controller/controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'controller/controller.dart';
import 'model/audiomodel.dart';
import 'view/mainui.dart';
import 'widget/rotatecd.dart';

void main() {
  runApp(
    //its like getmaterial app in to observe ui change in app
    ChangeNotifierProvider(
      create: (context) => AudioPlayerControllerProvider(
        AudioPlayerController(
          AudioPlayerModel(AudioPlayer()),
        ),
      ),
      child: const MaterialApp(
        home: MusicApp(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class MusicApp extends StatefulWidget {
  const MusicApp({super.key});

  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  String _songname = 'Select a song from your directory';
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        _songname = file.name;
      });
      // ignore: use_build_context_synchronously
      await context.read<AudioPlayerControllerProvider>().setSource(file.path!);
      // ignore: use_build_context_synchronously
      await context.read<AudioPlayerControllerProvider>().play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          leading: const Icon(
            Icons.music_note,
            color: Colors.amber,
            size: 24,
          ),
          title: const Text(
            'Music Player',
            style: TextStyle(
                color: Colors.amber, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            const CDPlayerApp(),
            const SizedBox(
              height: 200,
            ),
            Text(
              _songname,
              style: const TextStyle(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Expanded(
              child: AudioPlayerView(
                controller:
                    context.watch<AudioPlayerControllerProvider>().controller,
                picfile: () => _pickFile(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
