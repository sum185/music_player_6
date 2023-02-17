import 'package:flutter/material.dart';
import 'package:music_player_6/screen/provider/musicProvider.dart';
import 'package:music_player_6/screen/view/homePage.dart';
import 'package:music_player_6/screen/view/musicPage.dart';
import 'package:provider/provider.dart';
void main()
{
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AudioProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/':(context) => HomePage(),
          'M':(context) => MusicPage()
        },
      ),
    )
  );
}