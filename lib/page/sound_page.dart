import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

Map audioData = {
  'image':
      'https://thegrowingdeveloper.org/thumbs/1000x1000r/audios/quiet-time-photo.jpg',
  'url':
      //'https://drive.google.com/file/d/0B48UTb_3mp3VZnN6ZjQyVEc3Qm8/view?usp=sharing&resourcekey=0-nD12TFEuyAFtNTFDWOBLKA'
      //'https://thegrowingdeveloper.org/files/audios/quiet-time.mp3?b4869097e4'
      //'https://drive.google.com/file/d/0B48UTb_3mp3VaFFZUWNpU0lXTUU/view?usp=sharing&resourcekey=0-8krcNQ1O2ZrZFcZnpqP7DA'
      //'https://firebasestorage.googleapis.com/v0/b/ewipe-b9e0a.appspot.com/o/dog.wav?alt=media&token=2a4621f5-a1b9-4f57-9991-dd9204eca8a4'
      'https://firebasestorage.googleapis.com/v0/b/ewipe-b9e0a.appspot.com/o/masha.mp3?alt=media&token=9729cc62-9a15-4c4a-8134-332ea0f60842'
};

class SoudPage extends StatefulWidget {
  const SoudPage({Key? key}) : super(key: key);

  @override
  State<SoudPage> createState() => _SoudPageState();
}

class _SoudPageState extends State<SoudPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  late Duration totalDuration;

  final Stream<QuerySnapshot> books =
      FirebaseFirestore.instance.collection('books').snapshots();
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }),
        title: const Text("BooksBank",
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: books,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (snapshot.hasError) {
            return const Text("erroe!!");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.pink,
              ),
            );
          }
          //var items = snapshot.data?.docs ?? [];

          final data = snapshot.requireData;

          return Stack(
            children: [
              PageView.builder(
                controller: pageController,
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  totalDuration = Duration(hours: 0, minutes: 0, seconds: 0);
                  //Duration dd;
                  Duration position =
                      Duration(hours: 0, minutes: 0, seconds: 0);

                  initAudio() {
                    //audioPlayer.play(data.docs[index]['sound']);
                    //audioPlayer.play(audioData['url']);
                    audioPlayer.onDurationChanged.listen((updatedDuration) {
                      setState(() {
                        totalDuration = updatedDuration;
                      });
                    });
                    audioPlayer.onAudioPositionChanged
                        .listen((updatedPosition) {
                      setState(() {
                        position = updatedPosition;
                      });
                    });
                  }

                  playAudio() {
                    audioPlayer.play(data.docs[index]['sound']);
                  }

                  pauseAudio() {
                    audioPlayer.pause();
                  }

                  stopAudio() {
                    audioPlayer.stop();
                  }

                  return Column(children: [
                    Container(
                      color: Colors.pink,
                      height: 400,
                      width: double.infinity,
                      child: Text(
                        data.docs[index]['name'],
                        style: const TextStyle(color: Colors.white),
                        textDirection: TextDirection.rtl,
                      ),
                      alignment: Alignment.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(totalDuration.toString()),
                        Container(
                            width: 100,
                            child: Slider(
                              value: 0,
                              onChanged: (val) {},
                            )),
                        Text(position.toString())
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            stopAudio();
                          },
                          icon: const Icon(Icons.stop_outlined),
                          iconSize: 34,
                          color: Colors.pink,
                        ),
                        IconButton(
                          onPressed: () {
                            playAudio();
                          },
                          icon: const Icon(Icons.play_arrow_outlined),
                          iconSize: 34,
                          color: Colors.pink,
                        ),
                        IconButton(
                          onPressed: () {
                            pauseAudio();
                          },
                          icon: const Icon(Icons.pause_outlined),
                          iconSize: 34,
                          color: Colors.pink,
                        ),

                        // InkWell(
                        //   onTap: () {
                        //     getAudio();
                        //   },
                        //   child: Icon(playing == false
                        //       ? Icons.pause_outlined
                        //       : Icons.play_arrow_outlined),
                        // ),
                      ],
                    ),
                  ]);
                },
              ),
              Positioned(
                right: 12,
                top: MediaQuery.of(context).size.height / 3.5,
                child: SmoothPageIndicator(
                  effect: WormEffect(activeDotColor: Colors.pink.shade300),
                  axisDirection: Axis.vertical,
                  controller: pageController,
                  count: data.size,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
