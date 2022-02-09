class BuyLink {
  final String sellerName;
  final String buyUrl;

  BuyLink({
    required this.sellerName,
    required this.buyUrl,
  });

  factory BuyLink.fromJson(Map<String, dynamic> json) {
    return BuyLink(
      sellerName: json['name'],
      buyUrl: json['url'],
    );
  }
}
