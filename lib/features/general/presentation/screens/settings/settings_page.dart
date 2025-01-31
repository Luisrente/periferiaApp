import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:periferiamovies/core/app_route.dart';
import 'package:periferiamovies/core/localization/generated/strings.dart';
import 'package:periferiamovies/core/resources/dimens.dart';
import 'package:periferiamovies/dependencies_injection.dart';
import 'package:periferiamovies/features/general/presentation/blog/settings/settings_cubit.dart';
import 'package:periferiamovies/features/movies/pages/widgets/shared/appbar/appbar.dart';
import 'package:periferiamovies/utils/helper/constant.dart';
import 'package:periferiamovies/utils/helper/data_helper.dart';
import 'package:periferiamovies/utils/services/hive/main_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with MainBoxMixin {
  late final ActiveTheme _selectedTheme = sl<SettingsCubit>().getActiveTheme();

  late final List<DataHelper> _listLanguage = [
    DataHelper(title: Constants.get.english, type: "en"),
    DataHelper(title: Constants.get.spanish, type: "es"),
  ];
  late DataHelper _selectedLanguage =
      (getData(MainBoxKeys.locale) ?? "en") == "en"
          ? _listLanguage[0]
          : _listLanguage[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        title: Center(child: Text('Configuraciones')),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Dimens.space16),
          child: Column(
            children: [
              DropdownButtonFormField<DataHelper>(
                key: const Key("dropdown_language"),
                value: _selectedLanguage,
                // dropdownColor:
                //     Theme.of(context).extension<AppColors>()!.background,
                items: _listLanguage
                    .map(
                      (data) => DropdownMenuItem(
                        value: data,
                        child: Text(
                          data.title ?? "-",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (DataHelper? value) async {
                  _selectedLanguage = value ?? _listLanguage[0];

                  /// Reload theme
                  if (!mounted) return;
                  context.read<SettingsCubit>().updateLanguage(value?.type ?? "en");
                  context.goNamed(Routes.splashScreen.name);
                },
              ),
              // const SizedBox(height: TSizes.spaceBtwItems),
              DropdownButtonFormField<ActiveTheme>(
                key: const Key("dropdown_theme"),
                // dropdownColor:
                //     Theme.of(context).extension<>()!.background,
                // hint: Strings.of(context)!.chooseTheme,
                value: _selectedTheme,
                // prefixIcon: const Icon(Icons.light),
                items: ActiveTheme.values
                    .map(
                      (data) => DropdownMenuItem(
                        value: data,
                        child: Text(
                          _getThemeName(data, context),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  /// Reload theme
                  context
                      .read<SettingsCubit>()
                      .updateTheme(value ?? ActiveTheme.system);
                },
              ),
              // const SizedBox(height: TSizes.spaceBtwItems),

              /// Language
            ],
          ),
        ),
      ),
    );
  }

  String _getThemeName(ActiveTheme activeTheme, BuildContext context) {
    if (activeTheme == ActiveTheme.system) {
      return Strings.of(context)!.themeSystem;
    } else if (activeTheme == ActiveTheme.dark) {
      return Strings.of(context)!.themeDark;
    } else {
      return Strings.of(context)!.themeLight;
    }
  }
}
