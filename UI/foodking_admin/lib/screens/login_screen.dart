import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:foodking_admin/providers/OrderProvider.dart';
import 'package:foodking_admin/screens/order_list_screen.dart';
import 'package:foodking_admin/utils/auth.dart';
import 'package:foodking_admin/widgets/foodKing_button.dart';
import 'package:foodking_admin/widgets/foodKing_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late OrderProvider _orderProvider;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    _orderProvider = context.read<OrderProvider>();
    return Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Center(
          child: Container(
              width: 400,
              constraints: const BoxConstraints(maxWidth: 400, maxHeight: 400),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 24),
                    FoodKingTextField(
                      labelText: "Username",
                      prefixIcon: Icons.email,
                      controller: _usernameController,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    FoodKingTextField(
                      labelText: "Password",
                      prefixIcon: Icons.password,
                      controller: _passwordController,
                      isPassword: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    FoodKingButton(
                      buttonColor: Colors.deepOrange,
                      text: "Login",
                      icon: Icons.login,
                      textColor: Colors.white,
                      onPressed: _handleLogin,
                    ),
                  ]),
                ),
              )),
        ));
  }

  Future<void> _handleLogin() async {
    if (!mounted) return;

    final username = _usernameController.text;
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      _showErrorDialog("Please enter both username and password");
      return;
    }

    Auth.username = username;
    Auth.password = password;
    try {
      await _orderProvider.get();
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OrderListScreen(),
        ),
      );
    } on Exception catch (e) {
      if (!mounted) return;
      _showErrorDialog("Login failed: ${e.toString()}");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Error"),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"))
              ],
            ));
  }
}
