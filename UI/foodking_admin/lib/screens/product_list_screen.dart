import 'package:flutter/material.dart';
import 'package:foodking_admin/screens/product_details_screen.dart';
import 'package:foodking_admin/widgets/master_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        Container(
          child: Column(children: [
            Text("Product List"),
            ElevatedButton(
              onPressed: () {
                print("Login proceed");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProductDetailsScreen(),
                  ),
                );
              },
              child: const Text("Details"),
            )
          ]),
        ),
        appBarTitle: "Product list screen");
  }
}
