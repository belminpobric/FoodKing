import 'package:flutter/material.dart';
import 'package:foodking_admin/providers/OrderProvider.dart';
import 'package:foodking_admin/widgets/master_screen.dart';
import 'package:provider/provider.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  late OrderProvider _orderProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _orderProvider = context.read<OrderProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreenWidget(
        Column(children: [
          const Text("Order List"),
          ElevatedButton(
            onPressed: () async {
              var data = await _orderProvider.get();
            },
            child: const Text("Details"),
          )
        ]),
        appBarTitle: "Order list screen");
  }
}
