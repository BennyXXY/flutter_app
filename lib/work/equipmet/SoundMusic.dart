import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main(){
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('播放本地音频'),),
      body: Sound(),
    ),
  ));
}

class Sound extends StatefulWidget {
  @override
  _SoundState createState() => _SoundState();
}

class _SoundState extends State<Sound> {
  AudioPlayer audioPlugin = AudioPlayer();
  String mp3Uri;


  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<Null> _load() async {
    final ByteData data = await rootBundle.load('assets/mic/musicone.mp3');
    print('=====================$data');
    Directory tempDir = await getTemporaryDirectory();
    File tempFile = File('${tempDir.path}/demo.mp3');
    await tempFile.writeAsBytes(data.buffer.asUint8List(), flush: true);
    mp3Uri = tempFile.uri.toString();
    print('==================================================finished loading, uri=$mp3Uri');
  }


  void _playSound() {
    print('=-====================$mp3Uri');
    if (mp3Uri != null) {
      audioPlugin.play(mp3Uri, isLocal: true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio Player Demo Home Page'),
      ),
      body: Center(),
      floatingActionButton: FloatingActionButton(
        onPressed: _playSound,
        tooltip: 'Play',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
