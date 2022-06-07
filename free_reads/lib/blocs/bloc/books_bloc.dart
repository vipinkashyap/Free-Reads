import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:free_reads/models/list_info.dart';
import 'package:free_reads/models/list_picks.dart';
import 'package:free_reads/services/data/libgen_api_service.dart';
import 'package:free_reads/services/data/nyt_api_service.dart';
import 'package:meta/meta.dart';

part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final NytApiService _nytApiService;
  final LibGenApiService _libGenApiService;

  BooksBloc(NytApiService? nytApiService, LibGenApiService? libGenApiService)
      : _nytApiService = nytApiService ?? NytApiService(),
        _libGenApiService = libGenApiService ?? LibGenApiService(),
        super(BooksInitial()) {
    on<FetchCategories>(_onFetchCategories);
    on<FetchBooksByCategory>(_onFetchBooksByCategory);
    on<FetchDownloadLinks>(_onFetchDownloadLinks);
  }

  void _onFetchCategories(event, emit) async {
    emit(CategoriesLoading());
    final List<ListInfo> categoriesList =
        await _nytApiService.fetchBookCategories();
    emit(CategoriesLoaded(categoryList: categoriesList));
  }

  void _onFetchBooksByCategory(event, emit) async {
    emit(BooksLoading());
    final List<ListPicks> booksList =
        await _nytApiService.fetchCategoryBooks(event.encodedName);
    emit(BooksLoaded(booksList: booksList));
  }

  void _onFetchDownloadLinks(event, emit) async {
    emit(FetchingDownloadLinks());
    final List<String>? downloadUrls =
        await _libGenApiService.makeRequest(event.isbn);
    emit(DownloadLinksLoaded(downloadUrls: downloadUrls!));
  }
}
