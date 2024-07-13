import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/core/functions/string_actions.dart';
import 'package:timetable_data/core/widget/custom_dialog.dart';
import 'package:timetable_data/features/department/data/department_model.dart';
import 'package:timetable_data/features/department/data/models/program_data_model.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';

import '../services/programs_services.dart';

final programsStreamProvider =
    StreamProvider<List<ProgramsDataModel>>((ref) async* {
  var department = ref.watch(userProvider);
  if (department != null) {
    var data = ProgramsServices.getPrograms(dep: department.id!);
    await for (var value in data) {
      ref.read(programsProvider.notifier).setPrograms(value);
      yield value;
    }
  }
});

final programsProvider =
    StateNotifierProvider<ProgramsProvider, List<ProgramsDataModel>>(
        (ref) => ProgramsProvider());

class ProgramsProvider extends StateNotifier<List<ProgramsDataModel>> {
  ProgramsProvider() : super([]);

  void setPrograms(List<ProgramsDataModel> programs) {
    state = programs;
  }

  void addProgram(
      {required WidgetRef ref,
      required String program,
      required DepartmentModel department}) async {
    var exist = state
        .where((element) => element.name == program.toCapitalized())
        .toList();
    if (exist.isNotEmpty) {
      CustomDialog.showError(message: 'Program Already Added');
      return;
    }
    CustomDialog.showLoading(message: 'Adding Program......');
    // check if program exist under same departemnt
    var id = '$program${department.name}'
        .toLowerCase()
        .replaceAll(' ', '')
        .hashCode
        .toString();
    var programData = ProgramsDataModel(
      id: id,
      name: program.toCapitalized(),
      departmentId: department.id,
      department: department.name!.toCapitalized(),
      createdAt: DateTime.now().millisecondsSinceEpoch,
    );

    var result = await ProgramsServices.addProgram(programData);
    CustomDialog.dismiss();
    if (result) {
      CustomDialog.showToast(message: 'Program Added Successfully');
    } else {
      CustomDialog.showError(message: 'Failed to Add Program');
    }
  }

  void deleteProgram({required WidgetRef ref, required String id}) {}
}


