import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/core/widget/custom_button.dart';
import 'package:timetable_data/core/widget/custom_drop_down.dart';
import 'package:timetable_data/core/widget/custom_input.dart';
import 'package:timetable_data/features/department/provider/programs_provider.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';
import 'package:timetable_data/utils/colors.dart';
import 'package:timetable_data/utils/styles.dart';

import '../../../../core/widget/custom_dialog.dart';

class ProgramsPage extends ConsumerStatefulWidget {
  const ProgramsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProgramsPageState();
}

class _ProgramsPageState extends ConsumerState<ProgramsPage> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var titleStyles = styles.title(
        color: Colors.white,
        fontFamily: 'Raleway',
        desktop: 16,
        mobile: 14,
        tablet: 14);
    var rowStyles = styles.body(desktop: 16, mobile: 14, tablet: 15);
    var programsStream = ref.watch(programsStreamProvider);
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Programs List'.toUpperCase(),
            style: styles.title(
                desktop: 34, mobile: 20, tablet: 24, color: primaryColor),
          ),
          const SizedBox(height: 20),
          if (!ref.watch(openNew))
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: styles.isMobile
                      ? styles.width * 0.7
                      : styles.isTablet
                          ? styles.width * 0.4
                          : styles.width * 0.35,
                  child:  CustomTextFields(
                    hintText: 'Search Programs',
                    prefixIcon: Icons.search,
                    onChanged: (query){
                      ref.read(programsProvider.notifier).filterPrograms(value: query);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                if (!ref.watch(openNew))
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: CustomButton(
                      text: '',
                      icon: Icons.add,
                      padding: const EdgeInsets.all(10),
                      radius: 10,
                      onPressed: () {
                        ref.read(openNew.notifier).state = true;
                      },
                    ),
                  )
              ],
            )
          else
            buildNewForm(),
          const SizedBox(height: 20),
          Expanded(
            child: programsStream.when(
                data: (data) {
                  var programsList = ref.watch(programsProvider).filter;
                  return DataTable2(
                    columnSpacing: 20,
                    horizontalMargin: 12,
                    empty: Center(
                        child: Text(
                      'No Program found for this year and semester',
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
                        label: Text('Program'.toUpperCase()),
                      ),
                      DataColumn2(
                        label: Text('Department'.toUpperCase()),
                        size: ColumnSize.L,
                      ),
                      DataColumn2(
                          label: Text('Study Mode'.toUpperCase()),
                          size: ColumnSize.S,
                          onSort: (columnIndex, ascending) {
                            programsList.sort((a, b) {
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
                    rows: List<DataRow>.generate(programsList.length, (index) {
                      var program = programsList[index];
                      return DataRow(
                        cells: [
                          DataCell(Text('${index + 1}', style: rowStyles)),
                          DataCell(
                            Text(program.name ?? '', style: rowStyles),
                          ),
                          DataCell(
                              Text(program.department ?? '', style: rowStyles)),
                          DataCell(
                              Text(program.studyMode ?? '', style: rowStyles)),
                          DataCell(Text(program.year ?? '', style: rowStyles)),
                          DataCell(
                              Text(program.semester ?? '', style: rowStyles)),
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
                                              .read(programsProvider.notifier)
                                              .deleteProgram(
                                                  ref: ref, id: program.id!);
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
                },
                loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                error: (error, stack) {
                  return Center(
                    child: Text(
                      'Error: $error',
                      style: titleStyles,
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }

  var nameController = TextEditingController();
  String? mode;
  Widget buildNewForm() {
    var styles = Styles(context);
    return styles.rowColumnWidget(isRow: styles.largerThanTablet, [
      Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: styles.smallerThanTablet
              ? styles.width * 0.85
              : styles.width * 0.2,
          child: CustomTextFields(
            hintText: 'Program Name',
            prefixIcon: Icons.school,
            onChanged: (value) {
              setState(() {
                nameController.text = value;
              });
            },
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: styles.smallerThanTablet
              ? styles.width * 0.85
              : styles.width * 0.2,
          child: CustomDropDown(
            hintText: 'Study Mode',
            value: mode,
            prefixIcon: Icons.school,
            items: ['Regular', 'Evening', 'Sandwich']
                .map((mode) => DropdownMenuItem(value: mode, child: Text(mode)))
                .toList(),
            onChanged: (p0) {
              setState(() {
                mode = p0;
              });
            },
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
          width: styles.smallerThanTablet
              ? styles.width * 0.85
              : styles.width * 0.2,
          child: Row(
            children: [
              SizedBox(
                height: 50,
                child: CustomButton(
                  onPressed: () {
                    ref.read(programsProvider.notifier).addProgram(
                        ref: ref,
                        program: nameController.text,
                        mode: mode!,
                        department: ref.watch(userProvider)!);

                    setState(() {
                      mode = null;
                      nameController.clear();
                      ref.read(openNew.notifier).state = false;
                    });
                  },
                  radius: 10,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                  text: 'Save',
                  icon: Icons.save,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 50,
                height: 50,
                child: CustomButton(
                  text: '',
                  icon: Icons.cancel,
                  color: Colors.red,
                  padding: const EdgeInsets.all(10),
                  radius: 10,
                  onPressed: () {
                    ref.read(openNew.notifier).state = false;
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

final openNew = StateProvider<bool>((ref) => false);
