import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:luz_do_mundo/presentation/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PdfPreview extends StatelessWidget {
  const PdfPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data =
        ModalRoute.of(context)!.settings.arguments as Uint8List;

    final pdfController = PdfController(
      document: PdfDocument.openData(data),
    );

    return Widgets.scaffold(
        context,
        title: "Preview do PDF gerado",
        actions: [
          IconButton(
            onPressed: () async {
              final tempDir = await getTemporaryDirectory();
              final generatedPath = "${tempDir.path}/documento.pdf";
              File(generatedPath).writeAsBytesSync(data.toList());
              Share.shareFiles(
                [generatedPath],
                mimeTypes: ["application/pdf"],
                subject: "Luz do Mundo",
              );
            },
            icon: Icon(Icons.share),
          ),
        ],
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: PdfView(
            controller: pdfController,
          ),
        ),
    );
  }
}