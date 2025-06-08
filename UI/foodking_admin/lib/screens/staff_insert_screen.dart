import 'package:flutter/material.dart';
import 'package:foodking_admin/providers/StaffProvider.dart';
import 'package:foodking_admin/screens/staff_list_screen.dart';
import 'package:provider/provider.dart';

class StaffInsertScreen extends StatefulWidget {
  const StaffInsertScreen({super.key});

  @override
  _StaffInsertScreenState createState() => _StaffInsertScreenState();
}

class _StaffInsertScreenState extends State<StaffInsertScreen> {
  final _formKey = GlobalKey<FormState>();
  late StaffProvider _staffProvider;

  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  String _email = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _staffProvider = context.read<StaffProvider>();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map<String, dynamic> requestBody = {
        'FirstName': _firstName,
        'LastName': _lastName,
        'PhoneNumber': _phoneNumber,
        'Email': _email,
      };
      final data = _staffProvider.insertStaff(requestBody);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Osoblje uspjesno dodano!')),
      );

      // Go back to the staff list screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const StaffListScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dodaj osoblje')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Ime'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Upisite ime' : null,
                onSaved: (value) => _firstName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Prezime'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Upisite prezime' : null,
                onSaved: (value) => _lastName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Broj telefona'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Upisite broj telefona'
                    : null,
                onSaved: (value) => _phoneNumber = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Upisite email' : null,
                onSaved: (value) => _email = value!,
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
    );
  }
}
