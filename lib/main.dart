import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';
import 'countryInfo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Country Information', home: SplashPage());
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  AudioPlayer player = AudioPlayer();
  
  @override
  void initState() {
    super.initState();
    player.play(AssetSource("audios/start.mp3"));
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (content) => const CountryInfo())));
    }
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.amber[50],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/worldMap.jpg', scale: 1.5),
                const SizedBox(height: 50),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Searching Application:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 71, 55, 5))),
                    Image.asset('assets/images/search.png',
                        height: 100, width: 60),
                  ],
                ),
                const SizedBox(height: 10),
                const Text("Country Information!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 71, 55, 5))),
                
              ],
            )
          )
          
        );
        
  }
}
