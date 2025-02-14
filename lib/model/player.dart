class Player {
  final String name;
  final String position;
  final String clubName;
  final double price;
  final String kitImageUrl;
  final String? form;

  Player({
    required this.name,
    required this.position,
    required this.clubName,
    required this.price,
    required this.kitImageUrl,
    this.form,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'clubName': clubName,
      'price': price,
      'kitImageUrl': kitImageUrl,
      'form': form,
    };
  }

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'] as String,
      position: json['position'] as String,
      clubName: json['clubName'] as String,
      price: json['price'] as double,
      kitImageUrl: json['kitImageUrl'] as String,
      form: json['form'] as String?,
    );
  }
}