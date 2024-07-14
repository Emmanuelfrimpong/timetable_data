import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/features/department/data/models/class_data_model.dart';
import 'package:timetable_data/features/department/services/classes_services.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';
import 'package:timetable_data/features/settings/provider/settings_provider.dart';

final classStream = StreamProvider<List<ClassModel>>((ref) async* {
  var department = ref.watch(userProvider);
  var settings = ref.watch(settingsProvider);
  if (department != null) {
    var data = ClassesServices.getClasses(department.id!);
    await for (var value in data) {
      var classes = value
          .where((element) =>
              element.semester == settings.currentSemester &&
              element.year == settings.currentYear)
          .toList();
      ref.read(classesProvider.notifier).setClasses(classes);
      yield classes;
    }
  }
});


class ClassFilter {
  List<ClassModel> items;
  List<ClassModel> filter;
  ClassFilter({
    required this.items,
    required this.filter,
  });

  ClassFilter copyWith({
    List<ClassModel>? items,
    List<ClassModel>? filter,
  }) {
    return ClassFilter(
      items: items ?? this.items,
      filter: filter ?? this.filter,
    );
  }
}


final classesProvider = StateNotifierProvider<ClassesProvider, ClassFilter>(
    (ref) => ClassesProvider());


class ClassesProvider extends StateNotifier<ClassFilter> {
  ClassesProvider() : super(ClassFilter(filter: [], items: []));

  void setClasses(List<ClassModel> classes) {
    state = state.copyWith(items: classes, filter: classes);
  }

  void filterClasses({required String value}) {
    var filter = state.items
        .where((element) =>
            element.name!.toLowerCase().contains(value.toLowerCase()) ||
            element.studyMode!.toLowerCase().contains(value.toLowerCase()))
        .toList();
    state = state.copyWith(filter: filter);
  }

  void deleteProgram({required WidgetRef ref, required String id}) {}
}