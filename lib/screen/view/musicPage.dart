import 'package:flutter/material.dart';
import 'package:music_player_6/screen/provider/musicProvider.dart';
import 'package:provider/provider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  AudioProvider? providerT;
  AudioProvider? providerF;
@override
  void initState() {
    super.initState();
    Provider.of<AudioProvider>(context, listen: false).loadAudio();
  }
  @override

  Widget build(BuildContext context) {
    providerT = Provider.of<AudioProvider>(context, listen: true);
    providerF = Provider.of<AudioProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text("Now Playing",style: TextStyle(color: Colors.white),),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                "${providerF!.data!.image}",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black54,
            ),
            Align(
              alignment: Alignment.center,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          height: 200,
                          width: 200,
                          child: Image.asset(
                            "${providerF!.data!.image}",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${providerF!.data!.name}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${providerF!.data!.singer}",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 50),
                                child: IconButton(onPressed: (){
                                  providerF!.AddData(providerT!.data!, providerT!.index);
                                  providerF!.changeplay(false);
                                  providerF!.stopAudio();
                                }, icon: Icon(Icons.square,color: Colors.white,size: 15,)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 25,bottom: 10),
                                child: IconButton(
                                    onPressed: () {
                                      if(providerF!.data!.isplay!){
                                        providerF!.assetsAudioPlayer.pause();
                                      }
                                      else{
                                        providerF!.assetsAudioPlayer.play();
                                      }
                                      providerF!.changeplay(!providerF!.data!.isplay!);
                                    },
                                    icon: Icon(
                                      providerT!.data!.isplay!
                                          ? Icons.pause
                                          : Icons.play_arrow_sharp,
                                      color: Colors.white,
                                      size: 35,
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: IconButton(onPressed: (){
                                  providerF!.muteAudio();
                                }, icon: Icon(providerT!.mute?Icons.headphones:Icons.headset_off,color: Colors.white,size: 25,)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 150,
                        child: PlayerBuilder.currentPosition(player: providerF!.assetsAudioPlayer, builder: (context, position) {
                          return Column(
                            children: [
                              Slider(value: position.inSeconds.toDouble(), onChanged: (value){
                                providerF!.assetsAudioPlayer.seek(Duration(seconds: value.toInt()));
                              },
                                max: providerT!.songDuration.inSeconds.toDouble(),
                                activeColor: Colors.green,
                                inactiveColor: Colors.white,

                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("${position.inMinutes<10?"0${position.inMinutes}":"${position.inMinutes}"} : ${(position.inSeconds - position.inMinutes * 60) < 10 ? "0${position.inSeconds - position.inMinutes * 60}" : "${position.inSeconds - position.inMinutes * 60}"}   /  ",style: TextStyle(color: Colors.white,fontSize: 20),),
                                    Text("${providerT!.songDuration.inMinutes<10?"0${providerT!.songDuration.inMinutes}":"${providerT!.songDuration.inMinutes}"} : ${(providerT!.songDuration.inSeconds - providerT!.songDuration.inMinutes * 60) < 10 ? "0${providerT!.songDuration.inSeconds - providerT!.songDuration.inMinutes * 60}":"${providerT!.songDuration.inSeconds - providerT!.songDuration.inMinutes * 60}"}",style: TextStyle(color: Colors.white,fontSize: 20))
                                  ],
                                ),
                              )
                            ],
                          );
                        },),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
