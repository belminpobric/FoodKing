class Menu {
  final int? id;
  final String? title;
  final String? createdAt;
  final String? updatedAt;

  Menu({this.id, this.title, this.createdAt, this.updatedAt});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
        id: json['id'],
        title: json['title'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}
