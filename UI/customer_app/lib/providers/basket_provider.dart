import 'package:flutter/material.dart';

class BasketProvider extends StatefulWidget {
  final Widget child;
  const BasketProvider({super.key, required this.child});

  static _BasketProviderState of(BuildContext context) {
    final _BasketProviderInherited? inherited =
        context.dependOnInheritedWidgetOfExactType<_BasketProviderInherited>();
    assert(inherited != null,
        'BasketProvider.of() called with a context that does not contain a BasketProvider. Make sure your widget is a descendant of BasketProvider.');
    return inherited!.data;
  }

  @override
  State<BasketProvider> createState() => _BasketProviderState();
}

class _BasketProviderState extends State<BasketProvider> {
  final List<Map<String, dynamic>> _basket = [];

  List<Map<String, dynamic>> get basket => _basket;
  int get basketCount => _basket.length;

  void addToBasket(Map<String, dynamic> item) {
    setState(() {
      _basket.add(item);
    });
  }

  void removeFromBasket(Map<String, dynamic> item) {
    setState(() {
      _basket.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _BasketProviderInherited(
      data: this,
      child: widget.child,
    );
  }
}

class _BasketProviderInherited extends InheritedWidget {
  final _BasketProviderState data;
  const _BasketProviderInherited({required this.data, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(_BasketProviderInherited oldWidget) => true;
}
