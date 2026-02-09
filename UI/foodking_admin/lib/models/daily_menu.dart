class DailyMenu {
  final int? id;
  final String? title;
  final String? createdAt;
  final String? updatedAt;

  DailyMenu({this.id, this.title, this.createdAt, this.updatedAt});

  factory DailyMenu.fromJson(Map<String, dynamic> json) {
    return DailyMenu(
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
