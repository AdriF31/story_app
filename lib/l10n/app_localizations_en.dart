// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get title => 'Story App';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get name_error => 'Name can\'t be empty';

  @override
  String get email_empty_error => 'Email can\'t be empty';

  @override
  String get email_not_valid => 'Input a valid email';

  @override
  String get password_empty_error => 'can\'t be empty';

  @override
  String get password_length_error => 'Password minimum 8 character';

  @override
  String get change_language => 'Choose language';

  @override
  String get dont_have_account => 'Don\'t have an account? ';

  @override
  String get have_account => 'Already have an account? ';

  @override
  String get password => 'Password';

  @override
  String get email => 'Email';

  @override
  String get username => 'Username';

  @override
  String get sign_out => 'Sign Out';

  @override
  String get description => 'Description';

  @override
  String get error_message => 'Something went wrong...';

  @override
  String get field_warning_message => 'Fill in all fields';

  @override
  String get post => 'Post';
}
