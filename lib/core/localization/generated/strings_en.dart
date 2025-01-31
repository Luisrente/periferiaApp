import 'strings.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class StringsEn extends Strings {
  StringsEn([String locale = 'en']) : super(locale);

  @override
  String get dashboard => 'Dashboard';

  @override
  String get about => 'About';

  @override
  String get selectDate => 'Select Date';

  @override
  String get selectTime => 'Select Time';

  @override
  String get select => 'Select';

  @override
  String get cancel => 'Cancel';

  @override
  String get pleaseWait => 'Please wait...';

  @override
  String get login => 'Login';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get register => 'Register';

  @override
  String get askRegister => 'Don\'t have an account?';

  @override
  String get errorInvalidEmail => 'Invalid email';

  @override
  String get errorEmptyField => 'Field cannot be empty';

  @override
  String get errorPasswordLength => 'Password must be at least 6 characters';

  @override
  String get passwordRepeat => 'Repeat Password';

  @override
  String get errorPasswordNotMatch => 'Passwords do not match';

  @override
  String get settings => 'Settings';

  @override
  String get themeLight => 'Light Theme';

  @override
  String get themeDark => 'Dark Theme';

  @override
  String get themeSystem => 'System Theme';

  @override
  String get chooseTheme => 'Choose theme';

  @override
  String get chooseLanguage => 'Choose language';

  @override
  String get errorNoData => 'No Data';

  @override
  String get logout => 'Logout';

  @override
  String get logoutDesc => 'Do you want to log out of the app?';

  @override
  String get yes => 'Yes';

  @override
  String get noInternetConnection => '⚠ No Internet Connection';

  @override
  String get inTheaters => 'In Theaters';

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String get popular => 'Popular';

  @override
  String get topRated => 'Top Rated';

  @override
  String get monday => 'Monday 20';

  @override
  String get thisMonth => 'This month';

  @override
  String get allTime => 'Of all time';
}
