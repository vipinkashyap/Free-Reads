import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_reads/blocs/bloc/books_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:free_reads/models/buy_link.dart';

import '../services/services.dart';

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
        body: BlocBuilder<BooksBloc, BooksState>(builder: ((context, state) {
          if (state is FetchingDownloadLinks) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DownloadLinksLoaded) {
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
                      color: Colors.orangeAccent,
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.downloadUrls.length,
                        itemBuilder: (context, index) {
                          return MaterialButton(
                              child: Text(
                                'D/L from ${index + 1}',
                                style: GoogleFonts.merriweather(),
                              ),
                              onPressed: () {
                                UrlService()
                                    .launchUrl(state.downloadUrls[index]);
                              });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.white,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 1,
                                  crossAxisSpacing: 1),
                          itemCount: widget.bookBuyLinks.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return TextButton(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child:
                                    Text(widget.bookBuyLinks[index].sellerName),
                              ),
                              onPressed: () {
                                UrlService().launchUrl(
                                    widget.bookBuyLinks[index].buyUrl);
                              },
                            );
                          }),
                    )
                  ],
                ),
              ),
            );
          }
          return const Center(
            child: Text('Unknown State'),
          );
        })));
  }
}
