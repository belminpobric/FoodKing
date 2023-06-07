import 'package:flutter/material.dart';
import 'package:foodking_admin/widgets/master_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      Text("Details"),
      appBarTitle: "Product Details Screen",
    );
  }
}
