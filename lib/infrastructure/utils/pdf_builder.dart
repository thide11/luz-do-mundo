import 'dart:typed_data';

import 'package:luz_do_mundo/domain/entity/app_file.dart';
import 'package:luz_do_mundo/domain/entity/dependent.dart';
import 'package:luz_do_mundo/domain/entity/needy_person.dart';
import 'package:luz_do_mundo/presentation/utils/currency_pt_br_input_formatter.dart';
import 'package:luz_do_mundo/utils/datetime_extension.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<Uint8List> pdfBuilder(NeedyPerson person) async {
    // Create the Pdf document
    final pw.Document doc = pw.Document();

    pw.ImageProvider? pictureImage, workCardImage;
    if (person.picture != null && person.picture != AppFile.empty()) {
      pictureImage = await networkImage(person.picture!.fileUrl);
    }
    if (person.workCard != AppFile.empty()) {
      workCardImage = await networkImage(person.workCard!.fileUrl);
    }
    // Add one page with centered text "Hello World"
    doc.addPage(
      pw.MultiPage(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        margin: pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.standard,
        build: (pw.Context context) {
          return [
            if (pictureImage != null)
              pw.SizedBox(
                height: 200,
                width: 200,
                child: pw.ClipRRect(
                  horizontalRadius: 100,
                  verticalRadius: 100,
                  child: pw.Image(pictureImage),
                ),
              ),
            _simpleText('Relátório de:', pw.TextStyle(fontSize: 30)),
            _simpleText(person.name,
                pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 32)),
            pw.SizedBox(height: 10),
            _text('Data de nascimento', person.birthDate.toBrazilianDateString()),
            if (person.rg != "") _text('Rg', person.rg),
            if (person.cpf != "") _text('Cpf', person.cpf),
            if (person.adress != "") _text('Endereço', person.adress),
            if (person.telephone != null) _text('Telefone', person.telephone!),
            if (person.motherName != "")
              _text('Nome da mãe', person.motherName),
            if (person.fatherName != "")
              _text('Nome do pai', person.fatherName),
            _text('Renda', "R\$ ${CurrencyPtBrInputFormatter.formatNumber(person.income)}"),
            if (workCardImage != null) ...[
              _simpleText('Foto da carteira de trabalho: '),
              pw.SizedBox(
                height: 200,
                width: 200,
                child: pw.Image(workCardImage),
              ),
            ],
            pw.SizedBox(height: 5),
            if (person.dependents.length > 0)
              ...[
                pw.Text("Dependentes:", style: pw.TextStyle(fontSize: 31)),
              ]..addAll(person.dependents.map(_dependentPdfElement)),
            pw.Spacer(),
            _simpleText('Documento gerado pelo aplicativo Luz do mundo'),
          ];
        },
      ),
    );

    // Build and return the final Pdf file data
    return await doc.save();
  }

  pw.Widget _dependentPdfElement(Dependent dependent) {
    return pw.Padding(
      padding: pw.EdgeInsets.symmetric(vertical: 6),
      child:
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
        _text("Nome", dependent.name),
        if (dependent.age != null) _text("Idade", dependent.age!),
        if (dependent.rg != null) _text("Rg", dependent.rg!),
      ]),
    );
  }

  _simpleText(String content, [pw.TextStyle? textStyle]) {
    return pw.Text(
      content,
      style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold).merge(textStyle)
    );
  }

  _text(String content, String value, [pw.TextStyle? textStyle]) {
    return pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: "$content: ",
            style: textStyle ??
                pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold),
          ),
          pw.TextSpan(
            text: value,
            style: textStyle ?? pw.TextStyle(fontSize: 20).merge(textStyle),
          ),
        ],
      ),
    );
  }