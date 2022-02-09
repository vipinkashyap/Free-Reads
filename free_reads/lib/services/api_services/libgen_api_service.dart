import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class LibGenApiService {
  // ignore: non_constant_identifier_names
  final String isbn;

  LibGenApiService({required this.isbn});

  Future<List<String>> makeRequest() async {
    http.Response response = await http.get(
      Uri.parse(
          'http://libgen.rs/search.php?req=$isbn&open=0&res=25&view=simple&phrase=1&column=identifier'),
    );

    return response.statusCode == 200
        ? getDownloadLinks(parse(response.body))
        : throw Exception('Error getting response');
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
        String mirrorFour = dataRow
                .getElementsByTagName('td')[12]
                .getElementsByTagName('a')[0]
                .attributes['href'] ??
            '';
        String mirrorFive = dataRow
                .getElementsByTagName('td')[13]
                .getElementsByTagName('a')[0]
                .attributes['href'] ??
            '';
        return [mirrorOne, mirrorTwo, mirrorThree, mirrorFour, mirrorFive];
      }
    } catch (e) {
      return Exception(e);
    }
  }

//   Future<List<dynamic>> fetchDownloadLinks(
//       {String query = 'Harry Potter'}) async {
//     var resultsList = [];
//     String parsedQuery = parseQuery(query);
//     Document soup = await bs.requestUrl(
//         'http://gen.lib.rus.ec/search.php?req=$parsedQuery&column=title');
//     var informationTable = soup.getElementsByTagName('table')[2];
//     var tableBody = informationTable.querySelector('tbody');
//     var tableRows = tableBody!.getElementsByTagName('tr');
//     var numTableRows = tableRows.length;
//     var neededTableRows = tableRows.getRange(1, numTableRows);
//     for (var tableRow in neededTableRows) {
//       var mirrorOne = tableRow
//           .getElementsByTagName('td')[9]
//           .getElementsByTagName('a')[0]
//           .attributes;
//       resultsList.add(mirrorOne);
//     }

//     return resultsList;
//   }
}
