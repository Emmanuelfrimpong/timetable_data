import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/core/functions/string_actions.dart';
import 'package:timetable_data/core/widget/custom_dialog.dart';
import 'package:timetable_data/features/department/data/department_model.dart';
import 'package:timetable_data/features/department/data/models/program_data_model.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';
import 'package:timetable_data/features/settings/provider/settings_provider.dart';
import '../services/programs_services.dart';

final programsStreamProvider =
    StreamProvider<List<ProgramsDataModel>>((ref) async* {
  var department = ref.watch(userProvider);
  var settings = ref.watch(settingsProvider);
  if (department != null) {
    var data = ProgramsServices.getPrograms(dep: department.id!);
    await for (var value in data) {
      var programs = value
          .where((element) =>
              element.semester == settings.currentSemester &&
              element.year == settings.currentYear)
          .toList();
      ref.read(programsProvider.notifier).setPrograms(programs);
      yield programs;
    }
  }
});

class ProgramFilter {
  List<ProgramsDataModel> items;
  List<ProgramsDataModel> filter;
  ProgramFilter({
    required this.items,
    required this.filter,
  });

  ProgramFilter copyWith({
    List<ProgramsDataModel>? items,
    List<ProgramsDataModel>? filter,
  }) {
    return ProgramFilter(
      items: items ?? this.items,
      filter: filter ?? this.filter,
    );
  }
}

final programsProvider = StateNotifierProvider<ProgramsProvider, ProgramFilter>(
    (ref) => ProgramsProvider());

class ProgramsProvider extends StateNotifier<ProgramFilter> {
  ProgramsProvider() : super(ProgramFilter(filter: [], items: []));

  void setPrograms(List<ProgramsDataModel> programs) {
    state = state.copyWith(items: programs, filter: programs);
  }

  void filterPrograms({required String value}) {
    var filter = state.items
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()) ||
            element.studyMode!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    state = state.copyWith(filter: filter);
  }

  void addProgram(
      {required WidgetRef ref,
      required String program,
      required String mode,
      required DepartmentModel department}) async {
    var exist = state.items
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
        var settings = ref.read(settingsProvider);
    var programData = ProgramsDataModel(
      id: id,
      name: program.toCapitalized(),
      departmentId: department.id,
      semester: settings.currentSemester!,
      year: settings.currentYear!,
      studyMode: mode,
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

  void deleteProgram({required WidgetRef ref, required String id}) async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Deleting Program......');
    var result = await ProgramsServices.deleteProgram(id);
    CustomDialog.dismiss();
    if (result) {
      CustomDialog.showToast(message: 'Program Deleted Successfully');
    } else {
      CustomDialog.showError(message: 'Failed to Delete Program');
    }
  }
}
