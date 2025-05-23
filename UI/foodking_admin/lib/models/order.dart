class Order {
  final int? id;
  final double? price;
  final bool? isAccepted;
  final String? stateMachine;

  Order({
    this.id,
    this.price,
    this.isAccepted,
    this.stateMachine,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      price: json['price']?.toDouble(),
      isAccepted: json['isAccepted'],
      stateMachine: json['stateMachine'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'price': price,
      'isAccepted': isAccepted,
      'stateMachine': stateMachine,
    };
  }
}

class OrderItem {
  final int? id;
  final String? productName;
  final int? quantity;
  final double? price;

  OrderItem({
    this.id,
    this.productName,
    this.quantity,
    this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      productName: json['productName'],
      quantity: json['quantity'],
      price: json['price']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productName': productName,
      'quantity': quantity,
      'price': price,
    };
  }
}
