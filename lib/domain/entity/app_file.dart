import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

class AppFile extends Equatable {
  String md5Hash;
  String filename;
  String fileUrl;
  File? tempFile;

  get isEmpty => !isNotEmpty;
  get isNotEmpty => tempFile != null || fileUrl != "";

  AppFile({
    required this.md5Hash,
    required this.filename,
    required this.fileUrl,
    this.tempFile,
  });

  factory AppFile.empty() => AppFile(md5Hash: "", filename: "", fileUrl: "");

  @override
  List<Object?> get props => [md5Hash, filename, fileUrl, tempFile];

  AppFile copyWith({
    String? md5Hash,
    String? filename,
    String? fileUrl,
    File? tempFile,
  }) {
    return AppFile(
      md5Hash: md5Hash ?? this.md5Hash,
      filename: filename ?? this.filename,
      fileUrl: fileUrl ?? this.fileUrl,
      tempFile: tempFile ?? this.tempFile,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'md5Hash': md5Hash,
      'filename': filename,
      'fileUrl': fileUrl,
    };
  }

  factory AppFile.fromMap(Map<String, dynamic> map) {
    return AppFile(
      md5Hash: map['md5Hash'],
      filename: map['filename'],
      fileUrl: map['fileUrl']
    );
  }

  String toJson() => json.encode(toMap());

  factory AppFile.fromJson(String source) => AppFile.fromMap(json.decode(source));
}
