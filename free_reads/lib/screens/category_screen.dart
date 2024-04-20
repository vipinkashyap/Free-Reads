import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_reads/blocs/bloc/books_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:free_reads/models/list_info.dart';
import 'package:free_reads/screens/screens.dart';

import '../services/services.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Book Categories',
            style: GoogleFonts.merriweather(),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<BooksBloc, BooksState>(builder: ((context, state) {
          if (state is CategoriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CategoriesLoaded) {
            return ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  ListInfo bookCategory = state.categoryList[index];

                  return ListTile(
                      title: TextButton(
                    style: const ButtonStyle(
                        alignment: Alignment.centerLeft, enableFeedback: true),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        bookCategory.displayName,
                        style: GoogleFonts.merriweather(
                            color: Colors.white, fontSize: 20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return BlocProvider<BooksBloc>.value(
                          value: BooksBloc(NytApiService(), LibGenApiService())
                            ..add(FetchBooksByCategory(
                                encodedName: bookCategory.encodedName)),
                          child: const ListPreviewScreen(),
                        );
                      }));
                    },
                  ));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    color: Colors.grey,
                  );
                },
                itemCount: state.categoryList.length);
          }
          return const Center(
            child: Text('Unknown State'),
          );
        })));
  }
}
