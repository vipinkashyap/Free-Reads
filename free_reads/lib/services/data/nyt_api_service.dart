import 'dart:convert';
import 'dart:developer';

import 'package:free_reads/models/list_info.dart';
import 'package:free_reads/models/list_picks.dart';
import 'package:http/http.dart' as http;

class NytApiService {
  Future<List<ListInfo>> fetchBookCategories() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=dC9w0i96YjAkoy9j0dkAgRAMMIu1fbt5'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body)['results'] as List<dynamic>;
      return body
          .map((e) => ListInfo.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<ListPicks>> fetchCategoryBooks(String encodedName) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/books/v3/lists/$encodedName.json?api-key=dC9w0i96YjAkoy9j0dkAgRAMMIu1fbt5'));

    if (response.statusCode == 200) {
      var body = jsonDecode(response.body)['results']['books'] as List<dynamic>;
      return body
          .map((e) => ListPicks.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(response.statusCode);
    }
  }
}
