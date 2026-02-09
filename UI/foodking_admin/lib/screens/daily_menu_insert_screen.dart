import 'package:flutter/material.dart';
import 'package:foodking_admin/providers/DailyMenuProvider.dart';
import 'package:foodking_admin/screens/daily_menu_list_screen.dart';
import 'package:provider/provider.dart';

class DailyMenuInsertScreen extends StatefulWidget {
  const DailyMenuInsertScreen({super.key});

  @override
  _DailyMenuInsertScreenState createState() => _DailyMenuInsertScreenState();
}

class _DailyMenuInsertScreenState extends State<DailyMenuInsertScreen> {
  final _formKey = GlobalKey<FormState>();
  late DailyMenuProvider _dailyMenuProvider;

  String _title = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _dailyMenuProvider = context.read<DailyMenuProvider>();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map<String, dynamic> requestBody = {
        'title': _title,
      };
      await _dailyMenuProvider.insertDailyMenu(requestBody);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Dnevni meni uspjesno dodan!')),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const DailyMenuListScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Scaffold(
        appBar: AppBar(title: Text('Dodaj dnevni meni')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Naziv'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Upisite naziv' : null,
                  onSaved: (value) => _title = value!,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Dodaj'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
