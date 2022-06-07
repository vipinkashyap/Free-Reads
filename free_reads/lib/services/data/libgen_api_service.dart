import 'dart:developer';

import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class LibGenApiService {
  Future<List<String>?>? makeRequest(String isbn) async {
    http.Response response = await http.get(
      Uri.parse(
          'http://libgen.rs/search.php?req=$isbn&open=0&res=5&view=simple&phrase=1&column=identifier'),
    );
    return response.statusCode == 200
        ? getDownloadLinks(parse(response.body))
        : getDummyDownloadLinks();
  }

  Future<List<String>> getDummyDownloadLinks() async {
    return await Future.value(['', '', '']);
  }

  getDownloadLinks(Document htmlDoc) {
    try {
      Element informationTable = htmlDoc.getElementsByTagName('table')[2];
      Element dataTable = informationTable.querySelector('tbody')!;
      List<Element> dataRows = dataTable.getElementsByTagName("tr");
      for (Element dataRow in dataRows.sublist(1)) {
        String mirrorOne = dataRow
                .getElementsByTagName('td')[9]
                .getElementsByTagName('a')[0]
                .attributes['href'] ??
            '';
        String mirrorTwo = dataRow
                .getElementsByTagName('td')[10]
                .getElementsByTagName('a')[0]
                .attributes['href'] ??
            '';
        String mirrorThree = dataRow
                .getElementsByTagName('td')[11]
                .getElementsByTagName('a')[0]
                .attributes['href'] ??
            '';

        List<String> downloadLinks = [mirrorOne, mirrorTwo, mirrorThree];
        return downloadLinks;
      }
    } catch (e) {
      throw Exception('Issue fetching download links');
    }
  }
}
