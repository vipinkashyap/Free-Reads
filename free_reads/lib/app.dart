import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/blocs.dart';
import 'screens/screens.dart';
import 'services/services.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BooksBloc(NytApiService(), LibGenApiService())
        ..add(FetchCategories()),
      child: MaterialApp(
        title: 'Free Reads',
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        home: const CategoryScreen(),
      ),
    );
  }
}
