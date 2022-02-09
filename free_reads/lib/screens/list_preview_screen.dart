import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:free_reads/models/models.dart';
import 'package:free_reads/screens/screens.dart';
import 'package:free_reads/services/api_services/nyt_api_service.dart';

class ListPreviewScreen extends StatefulWidget {
  final String listTitle;
  final String encodedName;
  const ListPreviewScreen(
      {Key? key, required this.listTitle, required this.encodedName})
      : super(key: key);

  @override
  _ListPreviewScreenState createState() => _ListPreviewScreenState();
}

class _ListPreviewScreenState extends State<ListPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.listTitle,
          style: GoogleFonts.merriweather(),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
          future: NytApiService().fetchCategoryBooks(widget.encodedName),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: snapshot.data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 15,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var result = snapshot.data;
                    var parsedResult = ListPicks.fromJson(result[index]);

                    return GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return BookDetailScreen(
                              bookTitle: parsedResult.title,
                              bookAuthor: parsedResult.author,
                              bookDescription: parsedResult.description,
                              bookImage: parsedResult.bookImage,
                              bookBuyLinks: parsedResult.buyLinks,
                              primaryIsbn13: parsedResult.primaryIsbn13,
                            );
                          }));
                        },
                        child: Hero(
                            tag: parsedResult.title,
                            child: Image.network(parsedResult.bookImage)));
                  });
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
