import 'package:flutter/material.dart';
import 'package:foodking_admin/screens/order_details_screen.dart';
import 'package:foodking_admin/widgets/master_screen.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        Container(
          child: Column(children: [
            Text("Order List"),
            ElevatedButton(
              onPressed: () {
                print("Login proceed");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrderDetailsScreen(),
                  ),
                );
              },
              child: const Text("Details"),
            )
          ]),
        ),
        appBarTitle: "Order list screen");
  }
}
