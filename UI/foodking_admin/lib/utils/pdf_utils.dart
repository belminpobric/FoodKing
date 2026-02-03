import 'package:foodking_admin/models/User.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import '../models/order.dart';
import '../models/customer.dart';
import '../models/menu.dart';
import 'pdf_saver_impl.dart';

Future<void> _savePdf(pw.Document pdf, String title) async {
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyyMMdd_HHmmss').format(now);
  final fileName = '${title}_$formattedDate.pdf';

  try {
    final pdfSaver = getPdfSaver();
    await pdfSaver.savePdf(pdf, fileName);
  } catch (e) {
    print('Error saving PDF: $e');
    rethrow;
  }
}

Future<void> generateOrdersPdf(List<Order> orders,
    {void Function()? onStart}) async {
  onStart?.call();
  print('Starting Order PDF generation...');
  final pdf = pw.Document();
  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Header(level: 0, child: pw.Text('Order Report')),
        pw.Table.fromTextArray(
          headers: ['ID', 'Price', 'Accepted', 'State'],
          data: orders
              .map((o) => [
                    o.id?.toString() ?? '',
                    o.price?.toStringAsFixed(2) ?? '',
                    o.isAccepted == true ? 'Yes' : 'No',
                    o.stateMachine ?? '',
                  ])
              .toList(),
        ),
      ],
    ),
  );
  await _savePdf(pdf, 'Order_Report');
  print('Order PDF download started');
}

Future<void> generateCustomersPdf(List<Customer> customers,
    {void Function()? onStart}) async {
  onStart?.call();
  print('Starting Customer PDF generation...');
  final pdf = pw.Document();
  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Header(level: 0, child: pw.Text('Customer Report')),
        pw.Table.fromTextArray(
          headers: [
            'ID',
            'First Name',
            'Last Name',
            'Phone',
            'Email',
            'Address',
            'Username'
          ],
          data: customers
              .map((c) => [
                    c.id?.toString() ?? '',
                    c.firstName ?? '',
                    c.lastName ?? '',
                    c.phoneNumber ?? '',
                    c.email ?? '',
                    c.address ?? '',
                    c.username ?? '',
                  ])
              .toList(),
        ),
      ],
    ),
  );
  await _savePdf(pdf, 'Customer_Report');
  print('Customer PDF download started');
}

Future<void> generateMenusPdf(List<Menu> menus,
    {void Function()? onStart}) async {
  onStart?.call();
  print('Starting Menu PDF generation...');
  final pdf = pw.Document();
  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Header(level: 0, child: pw.Text('Menu Report')),
        pw.Table.fromTextArray(
          headers: ['ID', 'Title', 'Created At', 'Updated At'],
          data: menus
              .map((m) => [
                    m.id?.toString() ?? '',
                    m.title ?? '',
                    m.createdAt ?? '',
                    m.updatedAt ?? '',
                  ])
              .toList(),
        ),
      ],
    ),
  );
  await _savePdf(pdf, 'Menu_Report');
  print('Menu PDF download started');
}

Future<void> generateUsersPdf(List<User> Users,
    {void Function()? onStart}) async {
  onStart?.call();
  print('Starting User PDF generation...');
  final pdf = pw.Document();
  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Header(level: 0, child: pw.Text('User Report')),
        pw.Table.fromTextArray(
          headers: [
            'ID',
            'First Name',
            'Last Name',
            'Phone Number',
            'Email',
            'Created At',
            'Updated At'
          ],
          data: Users.map((m) => [
                m.id?.toString() ?? '',
                m.firstName ?? '',
                m.lastName ?? '',
                m.phoneNumber ?? '',
                m.email ?? '',
                m.createdAt ?? '',
                m.updatedAt ?? '',
              ]).toList(),
        ),
      ],
    ),
  );
  await _savePdf(pdf, 'User_Report');
  print('User PDF download started');
}

Future<void> generateSingleOrderPdf(Order order,
    {void Function()? onStart}) async {
  onStart?.call();
  print('Starting Single Order PDF generation...');
  final pdf = pw.Document();
  final items = order.items ?? [];
  final itemsTotal = order.itemsTotal();
  final orderPrice = order.price ?? 0.0;
  final diff = (orderPrice - itemsTotal);
  // load a font that supports diacritics: prefer bundled NotoSans assets,
  // otherwise try common system fonts, finally fall back to Helvetica.
  pw.Font baseFont;
  pw.Font? boldFont;
  try {
    ByteData? regularData;
    ByteData? boldData;
    try {
      regularData = await rootBundle.load('assets/fonts/NotoSans-Regular.ttf');
    } catch (_) {
      regularData = null;
    }
    try {
      boldData = await rootBundle.load('assets/fonts/NotoSans-Bold.ttf');
    } catch (_) {
      boldData = null;
    }

    if (regularData != null) {
      baseFont = pw.Font.ttf(regularData);
      if (boldData != null) boldFont = pw.Font.ttf(boldData);
    } else {
      // Try common system fonts if bundled assets not present
      Uint8List? bytes;
      final candidates = [
        'C:\\Windows\\Fonts\\arial.ttf',
        'C:\\Windows\\Fonts\\calibri.ttf',
        '/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf',
        '/Library/Fonts/Arial Unicode.ttf',
      ];
      for (final p in candidates) {
        try {
          final f = File(p);
          if (await f.exists()) {
            bytes = await f.readAsBytes();
            break;
          }
        } catch (_) {}
      }
      if (bytes != null) {
        baseFont = pw.Font.ttf(bytes.buffer.asByteData());
      } else {
        baseFont = pw.Font.helvetica();
      }
    }
  } catch (e) {
    print('PDF font load error: $e');
    baseFont = pw.Font.helvetica();
  }

  pdf.addPage(
    pw.MultiPage(
      theme: (boldFont != null)
          ? pw.ThemeData.withFont(base: baseFont, bold: boldFont)
          : pw.ThemeData.withFont(base: baseFont),
      build: (context) => [
        // Header with order info
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('FOODKING',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.Text('Detalji Narudžbe',
                    style:
                        pw.TextStyle(fontSize: 14, color: PdfColors.grey700)),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text('Narudžba #${order.id ?? '-'}',
                    style: pw.TextStyle(
                        fontSize: 16, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 4),
                pw.Text('Kreirano: ${_formatPdfDate(order.createdAt)}',
                    style: pw.TextStyle(fontSize: 11)),
                pw.Text(
                    'Status: ${order.stateMachine ?? (order.isAccepted == true ? 'Prihvaćena' : 'Nije prihvaćena')}',
                    style: pw.TextStyle(fontSize: 11)),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 20),

        // Customer Info
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Podaci o naručiocu',
                style:
                    pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 8),
            pw.Text(order.customerName ?? '-',
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold)),
            pw.Text(order.customerAddress ?? '-',
                style: pw.TextStyle(fontSize: 11)),
            pw.Text(order.customerPhone ?? '-',
                style: pw.TextStyle(fontSize: 11)),
          ],
        ),
        pw.SizedBox(height: 20),

        // Order Items Table
        pw.Text('Stavke Narudžbe',
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.Table(
          border: pw.TableBorder.all(color: PdfColors.grey300, width: 1),
          columnWidths: {
            0: const pw.FlexColumnWidth(4),
            1: const pw.FlexColumnWidth(2),
            2: const pw.FlexColumnWidth(2),
            3: const pw.FlexColumnWidth(2),
          },
          children: [
            // Header row
            pw.TableRow(
              decoration: pw.BoxDecoration(color: PdfColors.grey200),
              children: [
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Proizvod',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Količina',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Cijena',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
                pw.Padding(
                  padding: const pw.EdgeInsets.all(8),
                  child: pw.Text('Ukupno',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ),
              ],
            ),
            // Data rows
            ...items.map((it) {
              final lineTotal = (it.price ?? 0.0) * (it.quantity ?? 1);
              return pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(it.productName ?? '-',
                            style:
                                pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                        if (it.description != null &&
                            it.description!.isNotEmpty)
                          pw.Text(it.description!,
                              style: pw.TextStyle(
                                  fontSize: 9, color: PdfColors.grey700)),
                      ],
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text('${it.quantity ?? 1}'),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child:
                        pw.Text('${(it.price ?? 0.0).toStringAsFixed(2)} KM'),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(8),
                    child: pw.Text('${lineTotal.toStringAsFixed(2)} KM',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                  ),
                ],
              );
            }).toList(),
          ],
        ),
        pw.SizedBox(height: 16),

        // Totals
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.end,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text('Cijena stavki: ${itemsTotal.toStringAsFixed(2)} KM',
                    style: pw.TextStyle(fontSize: 11)),
                pw.Text('Razlika / PDV / Ostalo: ${diff.toStringAsFixed(2)} KM',
                    style: pw.TextStyle(fontSize: 11)),
                pw.SizedBox(height: 8),
                pw.Text('UKUPNO: ${orderPrice.toStringAsFixed(2)} KM',
                    style: pw.TextStyle(
                        fontSize: 13, fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  await _savePdf(pdf, 'Narudba_${order.id}');
  print('Single Order PDF download started');
}

String _formatPdfDate(DateTime? dt) {
  if (dt == null) return '-';
  final d = dt.toLocal();
  return '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')} ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}';
}
