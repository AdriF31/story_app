part of 'language_cubit.dart';

@immutable
abstract class LocaleState {}

class LocaleInitial extends LocaleState {
  String? locale;
  LocaleInitial({this.locale});
}


