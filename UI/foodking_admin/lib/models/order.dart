class Order {
  final int? id;
  final double? price;
  final bool? isAccepted;
  final String? stateMachine;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Order({
    this.id,
    this.price,
    this.isAccepted,
    this.stateMachine,
    this.createdAt,
    this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      price: json['price']?.toDouble(),
      isAccepted: json['isAccepted'],
      stateMachine: json['stateMachine'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
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
