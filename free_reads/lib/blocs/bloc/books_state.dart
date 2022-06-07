part of 'books_bloc.dart';

@immutable
abstract class BooksState {}

class BooksInitial extends BooksState {}

class CategoriesLoading extends BooksState {}

class BooksLoading extends BooksState {}

class FetchingDownloadLinks extends BooksState {}

class CategoriesLoaded extends BooksState with EquatableMixin {
  final List<ListInfo> categoryList;

  CategoriesLoaded({required this.categoryList});

  @override
  List<Object?> get props => [categoryList];
}

class BooksLoaded extends BooksState with EquatableMixin {
  final List<ListPicks> booksList;

  BooksLoaded({required this.booksList});

  @override
  List<Object?> get props => [booksList];
}

class DownloadLinksLoaded extends BooksState with EquatableMixin {
  final List<String> downloadUrls;

  DownloadLinksLoaded({required this.downloadUrls});

  @override
  List<Object?> get props => [downloadUrls];
}
