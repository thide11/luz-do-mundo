import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';

class Predicates {
  static findAppFile(AppFile appFile) {
    return find.byWidgetPredicate((widget) {
      if (widget is Container) {
        final decoration = widget.decoration;
        if (decoration is BoxDecoration) {
          final image = decoration.image?.image;
          if (image is CachedNetworkImageProvider) {
            return image.url == appFile.fileUrl && image.cacheKey == appFile.md5Hash;
          }
        }
      }
      if(widget is CachedNetworkImage) {
        return widget.imageUrl == appFile.fileUrl && widget.cacheKey == appFile.md5Hash;
      }
      return false;
    });
  }
}
