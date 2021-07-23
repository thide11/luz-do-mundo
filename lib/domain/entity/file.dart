import 'package:equatable/equatable.dart';

class File extends Equatable {
  String crc32cHash;
  String filename;
  String fileUrl;

  File({
    required this.crc32cHash,
    required this.filename,
    required this.fileUrl,
  });

  @override
  List<Object?> get props => [crc32cHash, filename, fileUrl];
}