import 'pdf_saver.dart';
import 'pdf_saver_web.dart' if (dart.library.io) 'pdf_saver_desktop.dart'
    as impl;

PdfSaver getPdfSaver() {
  return impl.PdfSaverImpl();
}
