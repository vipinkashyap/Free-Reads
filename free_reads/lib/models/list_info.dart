import 'package:intl/intl.dart';

class ListInfo {
  final String name;
  final String displayName;
  final String encodedName;
  final DateTime firstPublished;
  final DateTime lastPublished;
  final String updateFrequency;

  ListInfo({
    required this.name,
    required this.displayName,
    required this.encodedName,
    required this.firstPublished,
    required this.lastPublished,
    required this.updateFrequency,
  });

  factory ListInfo.fromJson(Map<String, dynamic> json) {
    return ListInfo(
      name: json['list_name'],
      displayName: json['display_name'],
      encodedName: json['list_name_encoded'],
      firstPublished:
          DateFormat('yyyy-mm-dd').parse(json['oldest_published_date']),
      lastPublished:
          DateFormat('yyyy-mm-dd').parse(json['newest_published_date']),
      updateFrequency: json['updated'],
    );
  }
}
