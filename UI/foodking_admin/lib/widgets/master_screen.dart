import 'package:flutter/material.dart';
import 'package:foodking_admin/screens/menu_list_screen.dart';
import 'package:foodking_admin/screens/staff_list_screen.dart';
import '../screens/order_list_screen.dart';
import '../screens/customer_list_screen.dart';

class MasterScreenWidget extends StatefulWidget {
  Widget? child;
  String? appBarTitle;
  MasterScreenWidget(this.child, {super.key, this.appBarTitle});

  @override
  State<MasterScreenWidget> createState() => _MasterScreenWidgetState();
}

class _MasterScreenWidgetState extends State<MasterScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.appBarTitle ?? "")),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                title: const Text('Home'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const OrderListScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Customers'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CustomerListScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Menu'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const MenuListScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Staff'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const StaffListScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: widget.child!);
  }
}
