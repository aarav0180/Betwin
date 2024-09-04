import 'package:betwin/Pages/Homepage.dart';
import 'package:betwin/Pages/Joinroom.dart';
import 'package:betwin/Pages/createRoom.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      routes: {
        Homepage.routeName: (context) => const Homepage(),
        JoinRoom.routeName: (context) => const JoinRoom(),
        CreateRoom.routeName: (context) => const CreateRoom()
      },

      initialRoute: Homepage.routeName ,
    );
  }
}
