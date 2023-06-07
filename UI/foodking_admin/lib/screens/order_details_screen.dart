import 'package:flutter/material.dart';
import 'package:foodking_admin/widgets/master_screen.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
      Text("Details"),
      appBarTitle: "Order Details Screen",
    );
  }
}
