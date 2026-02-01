class Order {
  final int? id;
  final double? price;
  final bool? isAccepted;
  final String? stateMachine;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? customerName;
  final String? customerAddress;
  final String? customerPhone;
  final List<OrderItem>? items;
  final Map<String, dynamic>? raw;

  Order({
    this.id,
    this.price,
    this.isAccepted,
    this.stateMachine,
    this.createdAt,
    this.updatedAt,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
    this.items,
    this.raw,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    // Extract customer info from Customer object
    String? customerName;
    String? customerAddress;
    String? customerPhone;

    final customer = json['Customer'] ??
        json['customer'] ??
        json['user'] ??
        json['customerDto'] ??
        json['CustomerDto'];
    if (customer is Map<String, dynamic>) {
      final first = customer['FirstName'] ??
          customer['firstName'] ??
          customer['name'] ??
          '';
      final last = customer['LastName'] ?? customer['lastName'] ?? '';
      customerName =
          ((first as String).isNotEmpty || (last as String).isNotEmpty)
              ? ('$first ${last ?? ''}'.trim())
              : null;
      customerAddress = customer['Address'] ??
          customer['address'] ??
          customer['fullAddress'] ??
          customer['location'];
      customerPhone =
          customer['Phone'] ?? customer['phone'] ?? customer['phoneNumber'];
    } else {
      customerName = json['customerName'] ?? json['name'];
      customerAddress = json['customerAddress'] ?? json['address'];
      customerPhone = json['customerPhone'] ?? json['phone'];
    }

    // If still not found, try to locate a nested customer-like map anywhere in json
    if (customerName == null || customerName.isEmpty) {
      Map<String, dynamic>? findCustomer(Map<String, dynamic> node) {
        for (final entry in node.entries) {
          final v = entry.value;
          if (v is Map<String, dynamic>) {
            final keys = v.keys.map((k) => k.toString()).toList();
            final hasName = keys.any((k) => k.toLowerCase().contains('name'));
            final hasPhone = keys.any((k) => k.toLowerCase().contains('phone'));
            if (hasName &&
                (hasPhone ||
                    keys.any((k) => k.toLowerCase().contains('address')))) {
              return v;
            }
            final nested = findCustomer(v);
            if (nested != null) return nested;
          } else if (v is List) {
            for (final item in v) {
              if (item is Map<String, dynamic>) {
                final nested = findCustomer(item);
                if (nested != null) return nested;
              }
            }
          }
        }
        return null;
      }

      final nestedCustomer = findCustomer(json);
      if (nestedCustomer != null) {
        final first = nestedCustomer['FirstName'] ??
            nestedCustomer['firstName'] ??
            nestedCustomer['name'] ??
            '';
        final last =
            nestedCustomer['LastName'] ?? nestedCustomer['lastName'] ?? '';
        customerName =
            ((first as String).isNotEmpty || (last as String).isNotEmpty)
                ? ('$first ${last ?? ''}'.trim())
                : customerName;
        customerAddress = customerAddress ??
            nestedCustomer['Address'] ??
            nestedCustomer['address'];
        customerPhone = customerPhone ??
            nestedCustomer['Phone'] ??
            nestedCustomer['phone'] ??
            nestedCustomer['phoneNumber'];
      }
    }

    // Parse items from orderHasOrderDetails array
    List<OrderItem>? items;
    final itemsJson = json['orderHasOrderDetails'] ??
        json['items'] ??
        json['orderItems'] ??
        json['orderItemsDto'];
    if (itemsJson is List) {
      items = itemsJson.map((e) {
        if (e is Map<String, dynamic>) {
          return OrderItem.fromJson(e);
        }
        return OrderItem();
      }).toList();
    }

    return Order(
      id: json['id'],
      price: json['price']?.toDouble(),
      isAccepted: json['isAccepted'],
      stateMachine: json['stateMachine'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      customerName: customerName,
      customerAddress: customerAddress,
      customerPhone: customerPhone,
      items: items,
      raw: Map<String, dynamic>.from(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'isAccepted': isAccepted,
      'stateMachine': stateMachine,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerPhone': customerPhone,
      'items': items?.map((i) => i.toJson()).toList(),
      'raw': raw,
    };
  }

  double itemsTotal() {
    if (items == null || items!.isEmpty) return 0.0;
    return items!
        .map((i) => (i.price ?? 0.0) * (i.quantity ?? 1))
        .fold(0.0, (a, b) => a + b);
  }
}

class OrderItem {
  final int? id;
  final String? productName;
  final String? description;
  final int? quantity;
  final double? price;

  OrderItem({
    this.id,
    this.productName,
    this.description,
    this.quantity,
    this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    String? productName;
    String? description;
    double? price;

    // Handle nested Product structure in multiple possible locations
    Map<String, dynamic>? product;
    if (json['Product'] is Map<String, dynamic>) {
      product = json['Product'] as Map<String, dynamic>?;
    } else if (json['product'] is Map<String, dynamic>) {
      product = json['product'] as Map<String, dynamic>?;
    } else if ((json['orderDetail'] is Map<String, dynamic>) &&
        (json['orderDetail']['Product'] is Map<String, dynamic>)) {
      product = json['orderDetail']['Product'] as Map<String, dynamic>?;
    } else if ((json['orderDetail'] is Map<String, dynamic>) &&
        (json['orderDetail']['product'] is Map<String, dynamic>)) {
      product = json['orderDetail']['product'] as Map<String, dynamic>?;
    }

    if (product != null) {
      productName = product['Title'] ?? product['title'] ?? product['name'];
      price = (product['Price'] ?? product['price'])?.toDouble();
    } else {
      productName = json['productName'] ??
          json['name'] ??
          json['title'] ??
          json['product']?['name'];
      price = (json['price'] ?? json['unitPrice'] ?? json['product']?['price'])
          ?.toDouble();
    }

    // Handle orderDetail structure
    final orderDetail = json['orderDetail'] as Map<String, dynamic>?;
    if (orderDetail != null) {
      description = orderDetail['details'] ?? orderDetail['description'];
    } else {
      description = json['description'] ?? json['details'];
    }

    return OrderItem(
      id: json['id'],
      productName: productName,
      description: description,
      quantity: json['quantity'] ?? json['qty'] ?? 1,
      price: price,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'description': description,
      'quantity': quantity,
      'price': price,
    };
  }
}
