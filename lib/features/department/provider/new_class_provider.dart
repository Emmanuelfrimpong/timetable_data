import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/core/widget/custom_dialog.dart';
import 'package:timetable_data/features/department/data/models/class_data_model.dart';
import 'package:timetable_data/features/department/services/classes_services.dart';
import 'package:timetable_data/features/department/views/pages/classes_page.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';
import 'package:timetable_data/features/settings/provider/settings_provider.dart';

final newClassProvider = StateNotifierProvider<NewClass, ClassModel>((ref) {
  return NewClass();
});

class NewClass extends StateNotifier<ClassModel> {
  NewClass()
      : super(ClassModel(level: '', department: '', year: '', semester: ''));

  void setName(String name) {
    state = state.copyWith(name: () => name);
  }

  void setLevel(String string) {
    state = state.copyWith(level: string);
  }

  void setSize(String string) {
    state = state.copyWith(size: () => string);
  }

  void setProgram(String string) {
    state = state.copyWith(program: () => string);
  }

  void setMode(String string) {
    state = state.copyWith(studyMode: () => string);
  }

  void setDisability(String string) {
    state = state.copyWith(hasDisability: () => string);
  }

  void saveClass(
      {required BuildContext context,
      required WidgetRef ref,
      required GlobalKey<FormState> form}) async {
    CustomDialog.showLoading(message: 'Saving class....');
    var id = state.name.toString().replaceAll(' ', '').toLowerCase().trim();
    var department = ref.watch(userProvider);
    var settings = ref.watch(settingsProvider);
    state = state.copyWith(
      id: () => id,
      department: () => department!.name,
      year: settings.currentYear,
      semester: settings.currentSemester,
    );
    var existenClass = await ClassesServices.getClass(
        department: department!.name!, name: state.name.toString());
    if (existenClass != null) {
      CustomDialog.dismiss();
      CustomDialog.showError(message: 'Class already exist');
    } else {
      var result = await ClassesServices.addClass(state.toMap());
      if (result) {
        CustomDialog.dismiss();
        CustomDialog.showToast(message: 'Class saved successfully');
        Navigator.of(context).pop();
      } else {
        CustomDialog.dismiss();
        CustomDialog.showError(message: 'Failed to save class');
      }
    }
  }
}
