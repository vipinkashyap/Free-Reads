import 'buy_link.dart';

class ListPicks {
  final int rank;
  final int rankLastWeek;
  final int weeksOnList;
  final String title;
  final String author;
  final String description;
  final String bookImage;
  final String amazonUrl;
  final String primaryIsbn13;

  final List<BuyLink> buyLinks;

  ListPicks({
    required this.rank,
    required this.rankLastWeek,
    required this.weeksOnList,
    required this.title,
    required this.author,
    required this.description,
    required this.bookImage,
    required this.amazonUrl,
    required this.buyLinks,
    required this.primaryIsbn13,
  });

  factory ListPicks.fromJson(Map<String, dynamic> json) {
    return ListPicks(
      rank: json['rank'],
      rankLastWeek: json['rank_last_week'],
      weeksOnList: json['weeks_on_list'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      bookImage: json['book_image'],
      amazonUrl: json['amazon_product_url'],
      buyLinks: List<BuyLink>.from(
          json['buy_links'].map((model) => BuyLink.fromJson(model))),
      primaryIsbn13: json['primary_isbn13'],
    );
  }
}
