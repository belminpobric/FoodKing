import 'package:flutter/material.dart';
import 'package:foodking_admin/providers/MenuProvider.dart';
import 'package:foodking_admin/providers/DailyMenuProvider.dart';
import 'package:foodking_admin/providers/OrderProvider.dart';
import 'package:foodking_admin/providers/CustomerProvider.dart';
import 'package:foodking_admin/providers/UserProvider.dart';
import 'package:foodking_admin/providers/RoleProvider.dart';
import 'package:foodking_admin/providers/ProductProvider.dart';
import 'package:foodking_admin/screens/login_screen.dart';
import 'package:foodking_admin/screens/order_list_screen.dart';
import 'package:foodking_admin/utils/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => OrderProvider()),
      ChangeNotifierProvider(create: (_) => CustomerProvider()),
      ChangeNotifierProvider(create: (_) => MenuProvider()),
      ChangeNotifierProvider(create: (_) => DailyMenuProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => RoleProvider()),
    ],
    child: const MyMaterialApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LayoutExamples());
  }
}

class MyAppBar extends StatelessWidget {
  String title;
  MyAppBar(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(title); //guarantee that title won't be null with !
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("You have pushed button $count times"),
        ElevatedButton(
            onPressed: incrementCounter, child: const Text("Incremend++"))
      ],
    );
  }
}

class LayoutExamples extends StatelessWidget {
  const LayoutExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          color: Colors.red,
          child: Center(
              child: Container(
            height: 100,
            color: Colors.blue,
            alignment: Alignment.bottomLeft,
            child: const Text("Example text"),
          )),
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Item 1"), Text("Item 2"), Text("Item 3")],
        ),
        Container(
          height: 150,
          color: Colors.red,
          alignment: Alignment.center,
          child: Text("Container"),
        )
      ],
    );
  }
}

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _loading = true;
  bool _hasCreds = false;

  @override
  void initState() {
    super.initState();
    _checkCreds();
  }

  Future<void> _checkCreds() async {
    final ok = await Auth.loadCredentials();
    if (!mounted) return;
    setState(() {
      _hasCreds = ok;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return _hasCreds ? const OrderListScreen() : const LoginPage();
  }
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "FoodKing Material App",
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: const AuthGate());
  }
}
