import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:periferiamovies/core/core.dart';
import 'package:periferiamovies/dependencies_injection.dart';
import 'package:periferiamovies/features/auth/auth.dart';
import 'package:periferiamovies/features/features.dart';
import 'package:periferiamovies/features/movies/pages/dashboard/bloc/bloc/movies_bloc.dart';
import 'package:periferiamovies/features/movies/pages/dashboard/internet/connection_status_cubit.dart';
import 'package:periferiamovies/features/movies/pages/movies/cubit/favoritemovies_cubit.dart';
import 'package:periferiamovies/utils/helper/helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

class PeriferiaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    log.d(const String.fromEnvironment('ENV'));
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthBlog>()),
        BlocProvider(create: (_) => sl<SettingsCubit>()..getActiveTheme()),
        BlocProvider(create: (_) => sl<ConnectionStatusCubit>()),
        BlocProvider(create: (_) => sl<MoviesBloc>()),
        BlocProvider(create: (_) => sl<FavoriteMoviesCubit>()),
      ],
      child: OKToast(
        child: ScreenUtilInit(
          /// Set screen size to make responsive
          /// Almost all device

          designSize: const Size(375, 667),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, __) {
            /// Pass context to appRoute
            AppRoute.setStream(context);

            return BlocBuilder<SettingsCubit, DataHelper>(
              builder: (_, data) => MaterialApp.router(
                routerConfig: AppRoute.router,
                localizationsDelegates: const [
                  Strings.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                debugShowCheckedModeBanner: false,
                builder: (BuildContext context, Widget? child) {
                  final MediaQueryData data = MediaQuery.of(context);

                  return MediaQuery(
                    data: data.copyWith(
                      textScaleFactor: 1,
                      alwaysUse24HourFormat: true,
                    ),
                    child: child!,
                  );
                },
                title: Constants.get.appName,
                theme: themeLight(context),
                darkTheme: themeDark(context),
                locale: Locale(data.type ?? "en"),
                supportedLocales: L10n.all,
                themeMode: data.activeTheme.mode,
              ),
            );
          },
        ),
      ),
    );
  }
}
