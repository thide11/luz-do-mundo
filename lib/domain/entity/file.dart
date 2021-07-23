import 'package:equatable/equatable.dart';

class File extends Equatable {
  String crc32cHash;
  String filename;

  File({
    required this.crc32cHash,
    required this.filename,
  });

  @override
  List<Object?> get props => [crc32cHash, filename];
}
