import 'package:foodking_admin/models/staff.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
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

Future<void> generateStaffsPdf(List<Staff> staffs,
    {void Function()? onStart}) async {
  onStart?.call();
  print('Starting Staff PDF generation...');
  final pdf = pw.Document();
  pdf.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Header(level: 0, child: pw.Text('Staff Report')),
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
          data: staffs
              .map((m) => [
                    m.id?.toString() ?? '',
                    m.firstName ?? '',
                    m.lastName ?? '',
                    m.phoneNumber ?? '',
                    m.email ?? '',
                    m.createdAt ?? '',
                    m.updatedAt ?? '',
                  ])
              .toList(),
        ),
      ],
    ),
  );
  await _savePdf(pdf, 'Staff_Report');
  print('Staff PDF download started');
}
