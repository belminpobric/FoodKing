import 'package:flutter/material.dart';
import 'package:foodking_admin/screens/login_screen.dart';
import 'package:foodking_admin/screens/menu_list_screen.dart';
import 'package:foodking_admin/screens/user_list_screen.dart';
import 'package:foodking_admin/utils/auth.dart';
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
                leading: const Icon(Icons.home),
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
                leading: const Icon(Icons.person),
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
                leading: const Icon(Icons.restaurant_menu),
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
                leading: const Icon(Icons.group),
                title: const Text('User'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const UserListScreen(),
                    ),
                  );
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () async {
                  // Clear stored credentials
                  await Auth.clearCredentials();

                  // Navigate to LoginPage and remove all previous routes
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
        body: widget.child!);
  }
}
