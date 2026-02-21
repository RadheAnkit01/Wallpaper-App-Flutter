import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:wallpaper/fetch_api.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/fullscreen_image.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List images = [];
  int page = 1;
  @override
  void initState() {
    super.initState();
    fetchApi();
  }

  Future<void> fetchApi() async {
    await http
        .get(
          Uri.parse("https://api.pexels.com/v1/curated?per_page=80"),
          headers: {
            'Authorization':
                'r0mf5TJ6DWMGvEFOf50GC5TeBdvwMR2hUk2JOWnuMFdtgUdGO0ctBxs8',
          },
        )
        .then((value) {
          // print(value.body);
          Map result = jsonDecode(value.body);
          // print(result);
          setState(() {
            images = result['photos'];
          });
          // print(images);
        });
  }

  Future<void> loadMore() async {
    setState(() {
      page++;
    });
    String url = 'https://api.pexels.com/v1/curated?per_page=80$page';
    await http
        .get(
          Uri.parse(url),
          headers: {
            'Authorization':
                'r0mf5TJ6DWMGvEFOf50GC5TeBdvwMR2hUk2JOWnuMFdtgUdGO0ctBxs8',
          },
        )
        .then((value) {
          Map result = jsonDecode(value.body);
          setState(() {
            images.addAll(result['photos']);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 199, 173, 244),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        title: Text('Free Wallpaper'),
      ),
      drawer: Drawer(backgroundColor: Colors.deepPurple),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                childAspectRatio: 9 / 16,
              ),
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FullscreenImage(
                          url: images[index]['src']['large2x'],
                        ),
                      ),
                    );
                  },

                  child: Container(
                    color: Colors.white,
                    child: Image.network(
                      images[index]['src']['tiny'],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: TextButton(
              style: ElevatedButton.styleFrom(
                shape: ContinuousRectangleBorder(),
                side: BorderSide(color: Colors.deepPurple),
              ),
              onPressed: () {
                loadMore();
              },
              child: Text(
                'Load more..',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
