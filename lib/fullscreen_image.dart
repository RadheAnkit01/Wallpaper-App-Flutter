import 'package:flutter/material.dart';
// import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper/choose_screen_dialog.dart';
import 'package:wallpaper/screen_function.dart';
// import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';

class FullscreenImage extends StatefulWidget {
  final String url;

  const FullscreenImage({super.key, required this.url});
  @override
  State<FullscreenImage> createState() => _FullscreenImageState();
}

class _FullscreenImageState extends State<FullscreenImage> {
  bool isFullScreen = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: InkWell(
              onDoubleTap: () => Navigator.pop(context),
              onTap: () {
                setState(() {
                  if (isFullScreen) {
                    isFullScreen = false;
                  } else {
                    isFullScreen = true;
                  }
                });
              },
              child: Image.network(widget.url, fit: BoxFit.cover),
            ),
          ),
          if (isFullScreen)
            Positioned(
              bottom: 70,
              right: 20,

              child: FloatingActionButton(
                mini: false,
                backgroundColor: Colors.deepPurple.withValues(alpha: 0.8),
                onPressed: () async {
                  final success = await downloadPexelsImage(widget.url);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success ? 'Image saved to gallery' : 'Download failed',
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.download, color: Colors.white),
              ),
            ),
          if (isFullScreen)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    shape: ContinuousRectangleBorder(),
                    side: BorderSide(color: Colors.deepPurple),
                    backgroundColor: Colors.white.withValues(alpha: 0.4),
                  ),
                  onPressed: () {
                    chooseScreenDialog(context, widget.url);
                  },
                  child: Text(
                    'Set Wallpaper',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 75, 1, 203),
                      // inherit: false,
                      // decoration: TextDecoration.lineThrough,
                      // decorationColor: Colors.black,
                      // decorationThickness: 10,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
