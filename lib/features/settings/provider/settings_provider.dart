import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:timetable_data/features/settings/data/settings.dart';

import '../services/settings_services.dart';

final settingsStream = StreamProvider<List<SettingsData>>((ref) async* {
  var data = SettingsServices().settingsStream();
  await for (var value in data) {
    ref.read(settingsProvider.notifier).setSettings(value);
    yield value;
  }
});

class SettingsObject {
  List<SettingsData> settingsList;
  SettingsData? currentSettings;
  List<String> years;
  List<String> semesters;
  String? currentYear;
  String? currentSemester;
  SettingsObject({
    this.settingsList = const [],
    this.currentSettings,
    this.years = const [],
    this.semesters = const [],
    this.currentYear,
    this.currentSemester,
  });

  SettingsObject copyWith({
    List<SettingsData>? settingsList,
    ValueGetter<SettingsData?>? currentSettings,
    List<String>? years,
    List<String>? semesters,
    String? currentYear,
    String? currentSemester,
  }) {
    return SettingsObject(
      settingsList: settingsList ?? this.settingsList,
      currentSettings:
          currentSettings != null ? currentSettings() : this.currentSettings,
      years: years ?? this.years,
      semesters: semesters ?? this.semesters,
      currentYear: currentYear ?? this.currentYear,
      currentSemester: currentSemester ?? this.currentSemester,
    );
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsProvider, SettingsObject>(
        (ref) => SettingsProvider());

class SettingsProvider extends StateNotifier<SettingsObject> {
  SettingsProvider() : super(SettingsObject());

  void setSettings(List<SettingsData> settings) {
    var years = settings.map((e) => e.year).toSet().toList();
    var semesters = settings.map((e) => e.semester).toSet().toList();
    var currentSettings = settings.firstWhere((element) => element.isCurrent);
    var currentYear = currentSettings.year;
    var currentSemester = currentSettings.semester;
    state = state.copyWith(
        settingsList: settings,
        years: years,
        semesters: semesters,
        currentSettings: () => currentSettings,
        currentSemester: currentSemester,
        currentYear: currentYear);
  }

  void setCurrentSemester(semester) {
    state = state.copyWith(currentSemester: semester.toString());
  }

  void setCurrentYear(year) {
    state = state.copyWith(currentYear: year.toString());
  }
}
