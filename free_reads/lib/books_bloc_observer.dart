import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class BooksBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('Bloc : $bloc, Transition : $transition');
    super.onTransition(bloc, transition);
  }
}
