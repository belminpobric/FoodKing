import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:foodking_admin/providers/UserProvider.dart';
import 'package:foodking_admin/providers/RoleProvider.dart';
import 'package:foodking_admin/screens/user_list_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';

class UserInsertScreen extends StatefulWidget {
  const UserInsertScreen({super.key});

  @override
  _UserInsertScreenState createState() => _UserInsertScreenState();
}

class _UserInsertScreenState extends State<UserInsertScreen> {
  final _formKey = GlobalKey<FormState>();
  late UserProvider _UserProvider;

  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  String _email = '';
  String? _photoBase64;
  String? _photoFileName;

  List<dynamic> _roles = [];
  dynamic _selectedRole;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _UserProvider = context.read<UserProvider>();
    _loadRoles();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map<String, dynamic> requestBody = {
        'FirstName': _firstName,
        'LastName': _lastName,
        'PhoneNumber': _phoneNumber,
        'Email': _email,
        if (_photoBase64 != null) 'Photo': _photoBase64,
        if (_selectedRole != null)
          'RoleId':
              _selectedRole['id'] ?? _selectedRole['Id'] ?? _selectedRole['ID'],
      };
      try {
        final data = await _UserProvider.insertUser(requestBody);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Osoblje uspjesno dodano!')),
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const UserListScreen(),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Greška: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _pickPhoto() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      final file = File(result.files.single.path!);
      final bytes = await file.readAsBytes();
      setState(() {
        _photoBase64 = base64Encode(bytes);
        _photoFileName = result.files.single.name;
      });
    }
  }

  Future<void> _loadRoles() async {
    try {
      final rp = context.read<RoleProvider>();
      final res = await rp.getRoles();
      setState(() {
        _roles = res is List ? res : (res['result'] ?? res['Result'] ?? []);
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dodaj korisnika')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              if (_photoBase64 != null) ...[
                SizedBox(
                  height: 120,
                  child: Image.memory(base64Decode(_photoBase64!)),
                ),
                Text(_photoFileName ?? ''),
                const SizedBox(height: 8),
              ],
              ElevatedButton.icon(
                onPressed: _pickPhoto,
                icon: Icon(Icons.photo_camera),
                label: Text('Odaberi fotografiju'),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<dynamic>(
                decoration: InputDecoration(labelText: 'Uloga'),
                items: _roles.map<DropdownMenuItem<dynamic>>((role) {
                  final label = role['name'] ??
                      role['Name'] ??
                      role['Name']?.toString() ??
                      role.toString();
                  return DropdownMenuItem<dynamic>(
                    value: role,
                    child: Text(label.toString()),
                  );
                }).toList(),
                value: _selectedRole,
                onChanged: (v) => setState(() => _selectedRole = v),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ime'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Upisite ime' : null,
                onSaved: (value) => _firstName = value!,
                cursorColor: Colors.black,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Prezime'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Upisite prezime' : null,
                onSaved: (value) => _lastName = value!,
                cursorColor: Colors.black,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Broj telefona'),
                validator: (value) => value == null || value.isEmpty
                    ? 'Upisite broj telefona'
                    : null,
                onSaved: (value) => _phoneNumber = value!,
                cursorColor: Colors.black,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Upisite email' : null,
                onSaved: (value) => _email = value!,
                cursorColor: Colors.black,
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
