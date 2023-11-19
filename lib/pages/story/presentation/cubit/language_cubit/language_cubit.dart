import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LocaleState> {
  LanguageCubit() : super(LocaleInitial(locale: 'en'));

  bool? switchValue=false;

  @override
  void getLanguage({bool? value,String? code}) {
    switchValue=value;
    emit(LocaleInitial(locale: code));
  }
}
