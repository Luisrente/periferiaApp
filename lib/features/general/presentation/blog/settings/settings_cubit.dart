import 'package:periferiamovies/utils/helper/data_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:periferiamovies/utils/services/hive/main_box.dart';

class SettingsCubit extends Cubit<DataHelper> with MainBoxMixin {
  SettingsCubit() : super(DataHelper(type: "en"));

  void updateTheme(ActiveTheme activeTheme) {
    addData(MainBoxKeys.theme, activeTheme.name);
    emit(
      DataHelper(
        activeTheme: activeTheme,
        type: getData(MainBoxKeys.locale) ?? "en",
      ),
    );
  }

  void updateLanguage(String type) {
    /// Update locale code
    addData(MainBoxKeys.locale, type);
    emit(DataHelper(type: type, activeTheme: getActiveTheme()));
  }

  ActiveTheme getActiveTheme() {
    final activeTheme = ActiveTheme.values.singleWhere(
      (element) =>
          element.name ==
          // (getData(MainBoxKeys.theme)),
          (getData(MainBoxKeys.theme) ?? ActiveTheme.system.name),
    );
    emit(
      DataHelper(
        activeTheme: activeTheme,
        type: getData(MainBoxKeys.locale) ?? "en",
      ),
    );
    return activeTheme;
  }
}
