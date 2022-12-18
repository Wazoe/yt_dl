import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  TextEditingController textControllerQ = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String judul = "", durasi = "", description = "", posterUrl = "";
  //String url = 'https://rr2---sn-4g5e6ns7.googlevideo.com/videoplayback?expire=1671295596&ei=DJ6dY7CpKMad8gPripfADg&ip=23.88.39.196&id=o-AM9rlwYyAHu5r-82w9DONWSB_b4Fb3b_UECANtqvVTg2&itag=17&source=youtube&requiressl=yes&mh=ix&mm=31%2C29&mn=sn-4g5e6ns7%2Csn-4g5ednsy&ms=au%2Crdu&mv=m&mvi=2&pl=25&initcwndbps=480000&vprv=1&svpuc=1&mime=video%2F3gpp&gir=yes&clen=16712754&dur=1749.855&lmt=1671221171058961&mt=1671273689&fvip=3&fexp=24001373%2C24007246&c=ANDROID&txp=5532434&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Csvpuc%2Cmime%2Cgir%2Cclen%2Cdur%2Clmt&sig=AOq0QJ8wRgIhAOr1fGgNCMQh2EtKmNkGTQC2MbkLgxBbbFp8ktgs5e8eAiEAibkOh48EMYKdddPEiAC8VTeKCc1MwJ5S0WaPdqjhAdI%3D&lsparams=mh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Cinitcwndbps&lsig=AG3C_xAwRQIgB7cDpwhpE_B6Yzi0bbAglvIJltEFYASGzNG6BmPUJvYCIQDCdC0TBmS_68I1E7XRVysFUhi0LPPABK4-P4F-P3q_CA%3D%3D';
  String url1 = '';
  String url2 = '';
  String url3 = '';
  String gambar = "";
  //late VideoPlayerController controller = VideoPlayerController.network('$url');
  Future<dynamic> getData() async {
    String q = textControllerQ.text;
    Uri uri = Uri(
        scheme: 'https',
        host: 'ytstream-download-youtube-videos.p.rapidapi.com',
        path: '/dl',
        queryParameters: {'id': q});

    final response = await http.get(uri, headers: {
      'X-RapidAPI-Key': 'ef662fd714msh6ea0fd26c624d74p10e3b9jsn80f709a0c869',
      'X-RapidAPI-Host': 'ytstream-download-youtube-videos.p.rapidapi.com'
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: textControllerQ,
                    decoration: InputDecoration(
                        labelText: "id Video Youtube",
                        hintText: 'masukkan id Youtube (https://youtube/id)'),
                  ),
                )
              ],
            )),
            Padding(
              padding: EdgeInsets.all(10),
              child: ElevatedButton(
                  onPressed: () async {
                    final result = await getData();
                    setState(() {
                      judul = result['title'];
                      description = result['description'];
                      url1 = result['formats'][0]['url'];
                      url2 = result['formats'][1]['url'];
                      url3 = result['formats'][2]['url'];
                      gambar = result['channelTitle'];
                      //Navigator.pushNamed(context, '/show', arguments: url);
                    });
                  },
                  child: Text('Submit')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Judul : ' + judul,
                          ),
                          Text(
                            'Channel : ' + gambar,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          Navigator.pushNamed(context, '/show',
                              arguments: url1);
                        });
                      },
                      child: Text('144p')),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          Navigator.pushNamed(context, '/show',
                              arguments: url2);
                        });
                      },
                      child: Text('360p')),
                  ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          Navigator.pushNamed(context, '/show',
                              arguments: url3);
                        });
                      },
                      child: Text('720p')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
