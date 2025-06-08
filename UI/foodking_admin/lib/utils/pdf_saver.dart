import 'package:pdf/widgets.dart' as pw;

abstract class PdfSaver {
  Future<void> savePdf(pw.Document pdf, String fileName);
}
