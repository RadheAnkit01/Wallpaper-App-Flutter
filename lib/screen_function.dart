// import 'package:flutter/cupertino.dart';
// import 'dart:io';
import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wallpaper_manager_plus/wallpaper_manager_plus.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:gal/gal.dart';

Future<void> setwallpaperHomeScreen(final String url) async {
  int location = WallpaperManagerPlus.homeScreen;
  final file = await DefaultCacheManager().getSingleFile(url);
  await WallpaperManagerPlus().setWallpaper(file, location);
}

Future<void> setwallpaperLockScreen(final String url) async {
  int location = WallpaperManagerPlus.lockScreen;
  final file = await DefaultCacheManager().getSingleFile(url);
  await WallpaperManagerPlus().setWallpaper(file, location);
}

Future<void> setwallpaperBothScreen(final String url) async {
  int location = WallpaperManagerPlus.bothScreens;
  final file = await DefaultCacheManager().getSingleFile(url);
  await WallpaperManagerPlus().setWallpaper(file, location);
}

Future<bool> downloadPexelsImage(String imageUrl) async {
  // 1️⃣ Permission
  if (Platform.isAndroid) {
    final status = await Permission.storage.request();
    if (!status.isGranted) return false;
  } else if (Platform.isIOS) {
    final status = await Permission.photosAddOnly.request();
    if (!status.isGranted) return false;
  }
  // 2️⃣ Download image
  var response = await http.get(Uri.parse(imageUrl));
  if (response.statusCode != 200) return false;
  // 3️⃣ Save to gallery
  Uint8List bytes = response.bodyBytes;
  await Gal.putImageBytes(bytes, album: 'Pexels');

  return true;
}

// Future<void> saveNetworkImage() async {
//   var response = await Dio().get(
//     "https://ss0.baidu.com/94o3dSag_xI4khGko9WTAnF6hhy/image/h%3D300/sign=a62e824376d98d1069d40a31113eb807/838ba61ea8d3fd1fc9c7b6853a4e251f94ca5f46.jpg",
//     options: Options(responseType: ResponseType.bytes),
//   );
//   final result = await ImageGallerySaver.saveImage(
//     Uint8List.fromList(response.data),
//     quality: 60,
//     name: "hello",
//   );
//   print(result);
// }
