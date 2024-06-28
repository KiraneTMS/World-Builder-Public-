import 'dart:async';

import 'package:flutter/material.dart';

class ImageUtils {
  static Future<Size> getImageSize(String imageUrl) async {
    Completer<Size> completer = Completer();
    Image image = Image.network(imageUrl);

    image.image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    return completer.future;
  }
}
