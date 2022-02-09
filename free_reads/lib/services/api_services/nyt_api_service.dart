import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NytApiService {
  Future<List<dynamic>> fetchBookCategories() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=dC9w0i96YjAkoy9j0dkAgRAMMIu1fbt5'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['results'];
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<dynamic>> fetchCategoryBooks(String encodedName) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.nytimes.com/svc/books/v3/lists/$encodedName.json?api-key=dC9w0i96YjAkoy9j0dkAgRAMMIu1fbt5'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['results']['books'];
    } else {
      throw Exception(response.statusCode);
    }
  }

  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw Exception("Could not launch $url");
    }
  }
}
