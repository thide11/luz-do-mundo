import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class AppFile extends Equatable {
  final String md5Hash;
  final String fileUrl;
  final File? tempFile;

  get isEmpty => !isNotEmpty;
  get isNotEmpty => tempFile != null || fileUrl != "";

  AppFile({
    required this.md5Hash,
    required this.fileUrl,
    this.tempFile,
  });

  factory AppFile.empty() => AppFile(md5Hash: "", fileUrl: "");

  @override
  List<Object?> get props => [md5Hash, fileUrl, tempFile];

  AppFile copyWith({
    String? md5Hash,
    String? fileUrl,
    File? tempFile,
  }) {
    return AppFile(
      md5Hash: md5Hash ?? this.md5Hash,
      fileUrl: fileUrl ?? this.fileUrl,
      tempFile: tempFile ?? this.tempFile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'md5Hash': md5Hash,
      'fileUrl': fileUrl,
    };
  }

  factory AppFile.fromMap(Map<String, dynamic>? map) {
    if(map == null) {
      return AppFile.empty();
    }
    return AppFile(
      md5Hash: map['md5Hash'],
      fileUrl: map['fileUrl'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory AppFile.fromJson(String source) => AppFile.fromMap(json.decode(source));
}
