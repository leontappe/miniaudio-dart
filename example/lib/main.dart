import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:audio_stream/audio_stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audio Stream Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Audio Stream Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final AudioStream audioStream;

  @override
  void initState() {
    super.initState();
    audioStream = getAudioStream();
    audioStream.init();
  }

  @override
  void dispose() {
    audioStream.uninit();
    super.dispose();
  }

  void synthSineWave(int freq, int rate, int sec) {
    final sineWave = List.generate(
        sec * rate, (i) => math.sin(2 * math.pi * ((i * freq) % rate) / rate));
    audioStream.push(Float32List.fromList(sineWave));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => synthSineWave(440, 44100, 1),
                child: const Text(
                  'generate sine wave',
                ))
          ],
        ),
      ),
    );
  }
}
