class Currency {
  final String name;
  final double currency;

  Currency({
    required this.currency,
    required this.name,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      name: json['name'],
      currency: json['currency'],
    );
  }
}
