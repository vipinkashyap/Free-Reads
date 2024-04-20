import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_reads/books_bloc_observer.dart';

import 'app.dart';

void main() {
  Bloc.observer = BooksBlocObserver();
  runApp(const MyApp());
}
