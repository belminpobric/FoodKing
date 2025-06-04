import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foodking_admin/models/menu.dart';
import 'package:foodking_admin/providers/MenuProvider.dart';
import 'package:foodking_admin/screens/menu_list_screen.dart';
import 'package:provider/provider.dart';

class MenuInsertScreen extends StatefulWidget {
  @override
  _MenuInsertScreenState createState() => _MenuInsertScreenState();
}

class _MenuInsertScreenState extends State<MenuInsertScreen> {
  final _formKey = GlobalKey<FormState>();
  late MenuProvider _menuProvider;

  String _title = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _menuProvider = context.read<MenuProvider>();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final Map<String, dynamic> requestBody = {
        'title': _title,
      };
      final data = _menuProvider.insertMenu(requestBody);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Meni uspjesno dodan!')),
      );

      // Go back to the menu list screen
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MenuListScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dodaj meni')),
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
    );
  }
}
