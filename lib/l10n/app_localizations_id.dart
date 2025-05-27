// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get title => 'Story App';

  @override
  String get login => 'Masuk';

  @override
  String get register => 'Daftar';

  @override
  String get name_error => 'Nama tidak boleh kosong';

  @override
  String get email_empty_error => 'Email tidak boleh kosong';

  @override
  String get email_not_valid => 'Masukkan email yang valid';

  @override
  String get password_empty_error => 'Email tidak boleh kosong';

  @override
  String get password_length_error => 'Kata sandi minimal 8 karakter';

  @override
  String get change_language => 'Pilih Bahasa';

  @override
  String get dont_have_account => 'Belum punya akun? ';

  @override
  String get have_account => 'Sudah punya akun? ';

  @override
  String get password => 'Kata Sandi';

  @override
  String get email => 'Email';

  @override
  String get username => 'Nama Pengguna';

  @override
  String get sign_out => 'Keluar';

  @override
  String get description => 'Deskripsi';

  @override
  String get error_message => 'Terjadi kesalahan...';

  @override
  String get field_warning_message => 'Isi semua field';

  @override
  String get post => 'Kirim';
}
