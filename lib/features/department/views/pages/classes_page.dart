import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/core/widget/custom_button.dart';
import 'package:timetable_data/features/department/provider/classes_provider.dart';

import '../../../../core/functions/transparent_page.dart';
import '../../../../core/widget/custom_dialog.dart';
import '../../../../core/widget/custom_input.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';
import 'components/new_class.dart';

class ClassesPage extends ConsumerStatefulWidget {
  const ClassesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ClassesPageState();
}

class _ClassesPageState extends ConsumerState<ClassesPage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var titleStyles = styles.title(
        color: Colors.white,
        fontFamily: 'Raleway',
        desktop: 15,
        mobile: 13,
        tablet: 14);
    var rowStyles = styles.body(desktop: 16, mobile: 14, tablet: 15);
    var classStreamProvider = ref.watch(classStream);
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Classes List'.toUpperCase(),
                style: styles.title(
                    desktop: 34, mobile: 20, tablet: 24, color: primaryColor),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: styles.isMobile
                        ? styles.width * 0.7
                        : styles.isTablet
                            ? styles.width * 0.4
                            : styles.width * 0.35,
                    child: const CustomTextFields(
                      hintText: 'Search for class',
                      prefixIcon: Icons.search,
                    ),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CustomButton(
                      text: '',
                      icon: Icons.add,
                      padding: const EdgeInsets.all(10),
                      radius: 10,
                      onPressed: () {
                        Navigator.of(context).push(MaterialTransparentRoute(
                            builder: (BuildContext context) =>
                                const NewClassPage()));
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: classStreamProvider.when(data: (data) {
                var classData = ref.watch(classesProvider).filter;
                return DataTable2(
                  columnSpacing: 20,
                  horizontalMargin: 12,
                  empty: Center(
                      child: Text(
                    'No class found for this year and semester',
                    style: rowStyles,
                  )),
                  minWidth: styles.isMobile ? styles.width : 600,
                  headingRowColor: WidgetStateColor.resolveWith(
                      (states) => primaryColor.withOpacity(0.6)),
                  headingTextStyle: titleStyles,
                  columns: [
                    DataColumn2(
                        label: Text(
                          'INDEX',
                          style: titleStyles,
                        ),
                        size: ColumnSize.S),
                    DataColumn2(
                        label: Text(
                          'Level'.toUpperCase(),
                          style: titleStyles,
                        ),
                        size: ColumnSize.S),
                    DataColumn2(
                      label: Text('Class Name'.toUpperCase()),
                    ),
                    DataColumn2(
                        label: Text(
                          'Class Size'.toUpperCase(),
                          style: titleStyles,
                        ),
                        size: ColumnSize.S),
                    DataColumn2(
                        label: Text(
                          'Disability'.toUpperCase(),
                          style: titleStyles,
                        ),
                        size: ColumnSize.S),
                    DataColumn2(
                      label: Text('Program'.toUpperCase()),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                      label: Text('Department'.toUpperCase()),
                      size: ColumnSize.L,
                    ),
                    DataColumn2(
                        label: Text('Mode'.toUpperCase()),
                        size: ColumnSize.S,
                        onSort: (columnIndex, ascending) {
                          classData.sort((a, b) {
                            if (ascending) {
                              return a.studyMode!.compareTo(b.studyMode!);
                            } else {
                              return b.studyMode!.compareTo(a.studyMode!);
                            }
                          });
                        }),
                    DataColumn2(
                        label: Text(
                          'YEAR',
                          style: titleStyles,
                        ),
                        size: ColumnSize.S),
                    DataColumn2(
                        label: Text(
                          'SEMESTER',
                          style: titleStyles,
                        ),
                        size: ColumnSize.S),
                    DataColumn2(
                      label: Text('Action'.toUpperCase()),
                      size: ColumnSize.S,
                    ),
                  ],
                  rows: List<DataRow>.generate(classData.length, (index) {
                    var classItem = classData[index];
                    return DataRow(
                      cells: [
                        DataCell(Text('${index + 1}', style: rowStyles)),
                        DataCell(
                          Text(classItem.level, style: rowStyles),
                        ),
                        DataCell(
                          Text(classItem.size ?? '', style: rowStyles),
                        ),
                        DataCell(
                          Text(classItem.hasDisability ?? '', style: rowStyles),
                        ),
                        DataCell(
                          Text(classItem.program ?? '', style: rowStyles),
                        ),
                        DataCell(
                            Text(classItem.department ?? '', style: rowStyles)),
                        DataCell(
                            Text(classItem.studyMode ?? '', style: rowStyles)),
                        DataCell(Text(classItem.year, style: rowStyles)),
                        DataCell(Text(classItem.semester, style: rowStyles)),
                        DataCell(
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  CustomDialog.showInfo(
                                      buttonText: 'Delete',
                                      message:
                                          'Are you sure you want to delete this program?',
                                      onPressed: () {
                                        ref
                                            .read(classesProvider.notifier)
                                            .deleteProgram(
                                                ref: ref, id: classItem.id!);
                                      });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                );
              }, error: (error, stack) {
                return Center(child: Text('Error: $error'));
              }, loading: () {
                return const Center(child: CircularProgressIndicator());
              }))
            ]));
  }
}
