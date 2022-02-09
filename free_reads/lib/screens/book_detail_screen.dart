import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:free_reads/models/buy_link.dart';
import 'package:free_reads/services/api_services/libgen_api_service.dart';
import 'package:free_reads/services/api_services/nyt_api_service.dart';

class BookDetailScreen extends StatefulWidget {
  final String bookTitle;
  final String bookDescription;
  final String bookImage;
  final String bookAuthor;
  final List<BuyLink> bookBuyLinks;
  final String primaryIsbn13;
  const BookDetailScreen({
    Key? key,
    required this.bookTitle,
    required this.bookDescription,
    required this.bookImage,
    required this.bookAuthor,
    required this.bookBuyLinks,
    required this.primaryIsbn13,
  }) : super(key: key);

  @override
  _BookDetailScreenState createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.bookTitle,
            style: GoogleFonts.merriweather(),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<List<String>>(
          future: LibGenApiService(isbn: widget.primaryIsbn13).makeRequest(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Hero(
                          tag: widget.bookTitle,
                          child: Image.network(widget.bookImage)),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          widget.bookDescription,
                          style: GoogleFonts.merriweather(),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        color: Colors.deepOrangeAccent,
                        height: 70,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return MaterialButton(
                                child: Text(
                                  'Mirror ${index + 1}',
                                  style: GoogleFonts.merriweather(),
                                ),
                                onPressed: () {
                                  NytApiService()
                                      .launchUrl(snapshot.data[index]);
                                });
                          },
                        ),
                      ),
                      GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 1,
                                  crossAxisSpacing: 1),
                          itemCount: widget.bookBuyLinks.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return TextButton(
                              child:
                                  Text(widget.bookBuyLinks[index].sellerName),
                              onPressed: () {
                                NytApiService().launchUrl(
                                    widget.bookBuyLinks[index].buyUrl);
                              },
                            );
                          })
                    ],
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Hero(
                          tag: widget.bookTitle,
                          child: Image.network(widget.bookImage)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.bookDescription,
                          style: GoogleFonts.merriweather(),
                        ),
                      ),
                      GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 1,
                                  crossAxisSpacing: 1),
                          itemCount: widget.bookBuyLinks.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return TextButton(
                              child: Text(
                                widget.bookBuyLinks[index].sellerName,
                                style: GoogleFonts.merriweather(),
                              ),
                              onPressed: () {
                                NytApiService().launchUrl(
                                    widget.bookBuyLinks[index].buyUrl);
                              },
                            );
                          })
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
