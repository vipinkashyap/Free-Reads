part of 'books_bloc.dart';

abstract class BooksEvent {}

class FetchCategories extends BooksEvent {}

class FetchBooksByCategory extends BooksEvent {
  final String encodedName;

  FetchBooksByCategory({required this.encodedName});
}

class FetchDownloadLinks extends BooksEvent {
  final String isbn;

  FetchDownloadLinks({required this.isbn});
}
