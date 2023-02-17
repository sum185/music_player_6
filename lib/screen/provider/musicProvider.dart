import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:music_player_6/screen/model/musicModel.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class AudioProvider extends ChangeNotifier {
  List<MusicModel> m1 = [
    MusicModel(
        name: "Dhokha",
        music: "assets/music/Arijit Singh - Dhokha(PagalWorld.com.se).mp3",
        colo: Colors.red,
        singer: "Arijit Singh",
        image: "assets/image/dhokha.png",
        isplay: false),
    MusicModel(
        name: "Besharam Rang",
        music: "assets/music/Besharam Rang(PagalWorld.com.se).mp3",
        colo: Colors.blue,
        singer: "Shilpa Rao & Caralisa Monteiro",
        image: "assets/image/b1.png",
        isplay: false),
    MusicModel(
        name: "Jhoome Jo Pathaan",
        music: "assets/music/Jhoome Jo Pathaan(PagalWorld.com.se).mp3",
        colo: Colors.green,
        singer: "Arijit Singh & Sukriti Kakar",
        image: "assets/image/jhomee.png",
        isplay: false),
    MusicModel(
        name: "Kesariya",
        music: "assets/music/Kesariya(PagalWorld.com.se).mp3",
        colo: Colors.yellow,
        singer: "Arijit Singh",
        image: "assets/image/kes.png",
        isplay: false),
    MusicModel(
        name: "Maan Meri Jaan",
        music: "assets/music/Maan Meri Jaan(PagalWorld.com.se).mp3",
        colo: Colors.deepOrange,
        singer: "King",
        image: "assets/image/maan.png",
        isplay: false),
    MusicModel(
        name: "Manike",
        music: "assets/music/Manike(PagalWorld.com.se).mp3",
        colo: Colors.greenAccent,
        singer: "Yohani & Jubin Nautiyal",
        image: "assets/image/manike.png",
        isplay: false),
  ];
  String? songpath =
      "assets/music/Arijit Singh - Dhokha(PagalWorld.com.se).mp3";
  int i = 0;
  int index = 0;
  bool mute = true;
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  Duration songDuration = Duration(seconds: 0);

  void changeplay(bool value) {
    m1[index].isplay = value;
    notifyListeners();
  }

  void loadAudio() {
    print(songpath);
    assetsAudioPlayer.open(Audio("${songpath}"), autoStart: false);
    print(songpath);
    totalDuration();
    notifyListeners();
  }

  void totalDuration() {
    assetsAudioPlayer.current.listen((event) {
      songDuration = event!.audio.duration;
    });
    notifyListeners();
  }

  MusicModel? data;

  void AddData(MusicModel da, inde) {
    data = da;
    index = inde;
    notifyListeners();
  }

  void changesongPath(value) {
    songpath = value;
    notifyListeners();
  }
  void stopAudio(){
    assetsAudioPlayer.stop();
    notifyListeners();
  }
  void muteAudio(){
    mute = !mute;
    mute?assetsAudioPlayer.setVolume(1):assetsAudioPlayer.setVolume(0);
    notifyListeners();
  }
}
