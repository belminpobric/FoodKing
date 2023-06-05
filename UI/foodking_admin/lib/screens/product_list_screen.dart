import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text("Product List"),
        ElevatedButton(
          onPressed: () {
            print("Login proceed");
            Navigator.of(context).pop();
          },
          child: const Text("Back"),
        )
      ]),
    );
  }
}
