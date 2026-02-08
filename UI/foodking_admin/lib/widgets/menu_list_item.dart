import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:foodking_admin/providers/ProductProvider.dart';
import 'package:foodking_admin/screens/product_list_screen.dart';

class MenuDetails {
  final String title;
  final String createdAt;
  final String updatedAt;

  MenuDetails({
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });
}

class MenuListItem extends StatelessWidget {
  final String text;
  final int? menuId;

  const MenuListItem({
    super.key,
    required this.text,
    this.menuId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 7,
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton(
            onPressed: () => _openAddProductDialog(context),
            child: const Text('Dodaj stavku'),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: menuId == null
                ? null
                : () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => ProductListScreen(
                              menuId: menuId!,
                              menuTitle: text,
                            )));
                  },
            child: const Text('Pogledaj stavke'),
          ),
        ],
      ),
    );
  }

  void _openAddProductDialog(BuildContext context) {
    final titleController = TextEditingController();
    final photoController = TextEditingController();
    String? photoBase64;
    String? photoFileName;
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        bool isSubmitting = false;

        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Dodaj stavku'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Naziv'),
                  ),
                  if (photoBase64 != null) ...[
                    SizedBox(
                      height: 120,
                      child: Image.memory(base64Decode(photoBase64!)),
                    ),
                    Text(photoFileName ?? ''),
                    const SizedBox(height: 8),
                  ],
                  ElevatedButton.icon(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles(
                        type: FileType.image,
                        withData: true,
                      );
                      if (result != null && result.files.isNotEmpty) {
                        final picked = result.files.single;
                        var bytes = picked.bytes;
                        if (bytes == null && picked.path != null) {
                          final file = File(picked.path!);
                          bytes = await file.readAsBytes();
                        }
                        if (bytes != null) {
                          setState(() {
                            photoBase64 = base64Encode(bytes!);
                            photoFileName = picked.name;
                          });
                        }
                      }
                    },
                    icon: const Icon(Icons.photo_camera),
                    label: const Text('Odaberi fotografiju'),
                  ),
                  TextField(
                    controller: priceController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(labelText: 'Cijena'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed:
                    isSubmitting ? null : () => Navigator.of(context).pop(),
                child: const Text('Otkaži'),
              ),
              ElevatedButton(
                onPressed: isSubmitting
                    ? null
                    : () async {
                        final title = titleController.text.trim();
                        final photo =
                            photoBase64 ?? photoController.text.trim();
                        final priceText = priceController.text.trim();

                        if (title.isEmpty || priceText.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Naziv i cijena su obavezni')));
                          return;
                        }

                        final price =
                            double.tryParse(priceText.replaceAll(',', '.'));
                        if (price == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Cijena nije valjan broj')));
                          return;
                        }

                        if (menuId == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Nevažeći meni.')));
                          return;
                        }

                        setState(() => isSubmitting = true);

                        try {
                          final provider = Provider.of<ProductProvider>(context,
                              listen: false);
                          final payload = {
                            'title': title,
                            'photo': photo,
                            'menuId': menuId,
                            'price': price,
                          };

                          await provider.insertProduct(payload);

                          if (context.mounted) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Stavka je uspješno dodana')));
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Greška: ${e.toString()}')));
                          }
                        } finally {
                          setState(() => isSubmitting = false);
                        }
                      },
                child: const Text('Spremi'),
              ),
            ],
          );
        });
      },
    );
  }
}
