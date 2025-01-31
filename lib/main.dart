import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:periferiamovies/core/network/check_internet_connection.dart';
import 'package:periferiamovies/dependencies_injection.dart';
import 'package:periferiamovies/periferia_app.dart';
import 'package:periferiamovies/utils/utils.dart';
final internetChecker = CheckInternetConnection();

void main() {
  runZonedGuarded(
    /// Lock device orientation to portrait
    () async {
      await dotenv.load(fileName: '.env');
      WidgetsFlutterBinding.ensureInitialized();

      /// Register Service locator
      await serviceLocator();
      await FirebaseServices.init();

      return SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ],
      ).then((_) => runApp(PeriferiaApp()));
    },
    (error, stackTrace) async {
      FirebaseCrashlytics.instance.recordError(error, stackTrace);
    },
  );
}
