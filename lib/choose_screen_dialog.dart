import 'package:flutter/material.dart';
import 'package:wallpaper/screen_function.dart';

Future<void> chooseScreenDialog(BuildContext context, final String url) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            title: Text(
              'Choose where to apply',
              style: TextStyle(fontSize: 25),
            ),
            content: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      setwallpaperHomeScreen(url);
                      Navigator.pop(context);
                      final snackBar = SnackBar(
                        duration: Duration(milliseconds: 1500),
                        behavior: SnackBarBehavior.floating,
                        content: Text('Wallpaper applied'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text("Home Screen"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      setwallpaperLockScreen(url);
                      Navigator.pop(context);
                      final snackbar = SnackBar(
                        duration: Duration(milliseconds: 1500),
                        behavior: SnackBarBehavior.floating,
                        content: Text('Wallpaper applied'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                    child: Text("Lock Screen"),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      setwallpaperBothScreen(url);
                      Navigator.pop(context);
                      final snackbar = SnackBar(
                        duration: Duration(milliseconds: 1500),
                        behavior: SnackBarBehavior.floating,
                        content: Text('Wallpaper applied'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    },
                    child: Text("Both Screen"),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
