import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';

ImageProvider appFileToImageProvider(AppFile? baseAppFile) {
  final appFile = baseAppFile ?? AppFile.empty();
  if (appFile.isEmpty) {
    return AssetImage("assets/images/without-image.jpg");
  } else {
    return CachedNetworkImageProvider(
      appFile.fileUrl,
      cacheKey: appFile.md5Hash,
    );
  }
}