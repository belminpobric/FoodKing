import 'dart:html' as html;
import 'package:pdf/widgets.dart' as pw;
import 'pdf_saver.dart';

class PdfSaverImpl implements PdfSaver {
  @override
  Future<void> savePdf(pw.Document pdf, String fileName) async {
    final bytes = await pdf.save();
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
