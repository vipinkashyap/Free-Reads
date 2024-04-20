import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_reads/blocs/bloc/books_bloc.dart';
import 'package:free_reads/models/list_picks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:free_reads/screens/screens.dart';

import '../services/services.dart';

class ListPreviewScreen extends StatefulWidget {
  const ListPreviewScreen({super.key});

  @override
  ListPreviewScreenState createState() => ListPreviewScreenState();
}

class ListPreviewScreenState extends State<ListPreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Browse Books',
            style: GoogleFonts.merriweather(),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<BooksBloc, BooksState>(builder: ((context, state) {
          if (state is BooksLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BooksLoaded) {
            List<ListPicks> books = state.booksList;
            return GridView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: books.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  ListPicks book = books[index];

                  return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return BlocProvider<BooksBloc>.value(
                            value: BooksBloc(
                                NytApiService(), LibGenApiService())
                              ..add(
                                  FetchDownloadLinks(isbn: book.primaryIsbn13)),
                            child: BookDetailScreen(
                              bookTitle: book.title,
                              bookAuthor: book.author,
                              bookDescription: book.description,
                              bookImage: book.bookImage,
                              bookBuyLinks: book.buyLinks,
                              primaryIsbn13: book.primaryIsbn13,
                            ),
                          );
                        }));
                      },
                      child: Hero(
                          tag: book.title,
                          child: Image.network(book.bookImage)));
                });
          }
          return const Center(
            child: Text('Unknown State'),
          );
        })));
  }
}
