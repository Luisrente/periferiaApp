import 'strings.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class StringsEs extends Strings {
  StringsEs([String locale = 'es']) : super(locale);

  @override
  String get dashboard => 'Tablero';

  @override
  String get about => 'Acerca de';

  @override
  String get selectDate => 'Elegir Fecha';

  @override
  String get selectTime => 'Elegir Hora';

  @override
  String get select => 'Seleccionar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get pleaseWait => 'Por favor, espera...';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get register => 'Registrarse';

  @override
  String get askRegister => '¿No tienes una cuenta?';

  @override
  String get errorInvalidEmail => 'El correo electrónico no es válido';

  @override
  String get errorEmptyField => 'No puede estar vacío';

  @override
  String get errorPasswordLength => 'La contraseña debe tener al menos 6 caracteres';

  @override
  String get passwordRepeat => 'Repetir contraseña';

  @override
  String get errorPasswordNotMatch => 'Las contraseñas no coinciden';

  @override
  String get settings => 'Configuraciones';

  @override
  String get themeLight => 'Tema Claro';

  @override
  String get themeDark => 'Tema Oscuro';

  @override
  String get themeSystem => 'Tema del Sistema';

  @override
  String get chooseTheme => 'Elegir Tema';

  @override
  String get chooseLanguage => 'Elegir Idioma';

  @override
  String get errorNoData => 'Sin datos';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get logoutDesc => '¿Deseas cerrar sesión en la aplicación?';

  @override
  String get yes => 'Sí';

  @override
  String get noInternetConnection => '⚠ Sin conexión a Internet';

  @override
  String get inTheaters => 'En Cines';

  @override
  String get comingSoon => 'Próximamente';

  @override
  String get popular => 'Populares';

  @override
  String get topRated => 'Mejor Calificadas';

  @override
  String get monday => 'Lunes 20';

  @override
  String get thisMonth => 'Este mes';

  @override
  String get allTime => 'De todos los tiempos';
}
