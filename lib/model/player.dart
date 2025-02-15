class Player {
  final String name;
  final String position;
  final int clubId;
  final String logoUrl;
  final double price;
  final String? form;

  Player({
    required this.name,
    required this.position,
    required this.clubId,
    required this.logoUrl,
    required this.price,
    this.form,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'] as String? ?? 'Unknown',
      position: json['position'] as String? ?? 'Unknown',
      clubId: json['clubId'] as int,
      logoUrl: json['logoUrl'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      form: json['form'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'clubId': clubId,
      'logoUrl': logoUrl,
      'price': price,
      'form': form,
    };
  }
}
