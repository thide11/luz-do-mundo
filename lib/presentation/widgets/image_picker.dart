import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:image_picker/image_picker.dart' as lib;
import 'package:md5_plugin/md5_plugin.dart';

class ImagePicker extends StatefulWidget {
  final AppFile file;
  final Function(AppFile) onChanged;
  const ImagePicker({Key? key, required this.file, required this.onChanged})
      : super(key: key);

  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Insira uma foto :"),
        SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () async {
            final lib.ImagePicker _picker = lib.ImagePicker();
            final xfile =
                await _picker.pickImage(source: lib.ImageSource.gallery);
            if (xfile != null) {
              final file = File(xfile.path);
              File? croppedFile = await ImageCropper.cropImage(
                sourcePath: file.path,
                aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                maxWidth: 700,
                maxHeight: 700,
                compressFormat: ImageCompressFormat.png,
                cropStyle: CropStyle.circle,
                androidUiSettings: AndroidUiSettings(
                  toolbarTitle: 'Cortar imagem',
                  toolbarColor: Colors.deepOrange,
                  toolbarWidgetColor: Colors.white,
                  initAspectRatio: CropAspectRatioPreset.original,
                  lockAspectRatio: true
                ),
                iosUiSettings: IOSUiSettings(
                  minimumAspectRatio: 1.0,
                )
              );
              if(croppedFile != null) {
                final a = await Md5Plugin.getMD5WithPath(croppedFile.path);
                print("MD5 da lib:");
                print(a);
                final md5Hash = md5.convert(croppedFile.readAsBytesSync().toList()).toString();
                print(md5Hash);
                widget
                    .onChanged(
                      widget.file.copyWith(
                        tempFile: croppedFile,
                        md5Hash: a,
                      )
                    );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Por favor, recorte sua imagem")));
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Nenhum arquivo recebido")));
            }
          },
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Color(0xff224E00),
              borderRadius: BorderRadius.all(
                Radius.circular(200),
              ),
              image: getImage(widget.file) != null ?
                DecorationImage(
                  image: getImage(widget.file)!
                )
                :
                null
            ),
            // child: 
                // Padding(
                //     padding: const EdgeInsets.all(40),
                //     child: Icon(
                //       Icons.picture_as_pdf,
                //       color: Colors.white,
                //     ),
                //   ),
          ),
        ),
      ],
    );
  }

  ImageProvider? getImage(AppFile appFile) {
    if(widget.file.isNotEmpty) {
      if(widget.file.tempFile != null) {
        return FileImage(widget.file.tempFile!);
      } else {
        return CachedNetworkImageProvider(
          widget.file.fileUrl,
          cacheKey: appFile.md5Hash,
        );
      }
    }
    return null;
  }

  Widget imageContainer({required ImageProvider child}) {
    return SizedBox(
      height: 200,
      width: 200,
      // child: child,
    );
  }
}
