

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AppThemeCubit extends Cubit<ThemeMode> {
  AppThemeCubit() : super(ThemeMode.system);
  void darkTheme()=>emit(ThemeMode.dark);
  void lightTheme()=>emit(ThemeMode.light);
  void systemTheme()=>emit(ThemeMode.dark);
}
