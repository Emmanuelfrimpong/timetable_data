import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/core/widget/custom_drop_down.dart';
import 'package:timetable_data/core/widget/custom_input.dart';
import 'package:timetable_data/features/department/provider/programs_provider.dart';
import 'package:timetable_data/utils/colors.dart';
import 'package:timetable_data/utils/styles.dart';
import '../../../../../core/widget/custom_button.dart';
import '../../../provider/new_class_provider.dart';

class NewClassPage extends ConsumerStatefulWidget {
  const NewClassPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewClassPageState();
}

class _NewClassPageState extends ConsumerState<NewClassPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var programStream = ref.watch(programsStreamProvider);
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(.5),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: styles.isMobile
                  ? styles.width * 0.9
                  : styles.isTablet
                      ? styles.width * 0.7
                      : styles.width * 0.55,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ]),
              child: Column(
                children: [
                  Container(
                    width: styles.isMobile
                        ? styles.width * 0.9
                        : styles.isTablet
                            ? styles.width * 0.7
                            : styles.width * 0.55,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'New Class'.toUpperCase(),
                            style: styles.title(
                              desktop: 34,
                              mobile: 20,
                              tablet: 24,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  programStream.when(loading: () {
                    return const Center(child: CircularProgressIndicator());
                  }, error: (error, stack) {
                    return Text(
                      'There was an error gettinng programs, check your internet and try again',
                      style: styles.body(),
                    );
                  }, data: (data) {
                    var programsNames = data
                        .map(
                          (e) => e.name,
                        )
                        .toList();
                        var newClassNotifier = ref.read(newClassProvider.notifier);
                    return Form(
                      key: _formKey,
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 22,
                        alignment: WrapAlignment.center,
                        runAlignment: WrapAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: styles.isMobile
                                ? styles.width * 0.9
                                : styles.isTablet
                                    ? styles.width * 0.32
                                    : styles.width * 0.22,
                            child: CustomTextFields(
                              label: 'Class Name',
                              isCapitalized: true,
                              validator: (name) {
                                if (name == null || name.isEmpty) {
                                  return 'Name is required';
                                }
                                return null;
                              },
                              onSaved: (name) {
                                newClassNotifier.setName(name!);
                              },
                            ),
                          ),
                          SizedBox(
                            width: styles.isMobile
                                ? styles.width * 0.9
                                : styles.isTablet
                                    ? styles.width * 0.32
                                    : styles.width * 0.22,
                            child: CustomDropDown(
                              label: 'Class Level',
                              validator: (level) {
                                if (level == null) {
                                  return 'class level is required';
                                }
                                return null;
                              },
                              onChanged: (level) {
                                newClassNotifier.setLevel(level.toString());
                              },
                              items: [
                                '100',
                                '200',
                                '300',
                                '400',
                                '500',
                                '600',
                                '700',
                                '800'
                              ]
                                  .map((level) => DropdownMenuItem(
                                        value: level,
                                        child: Text(level),
                                      ))
                                  .toList(),
                            ),
                          ),

                          SizedBox(
                            width: styles.isMobile
                                ? styles.width * 0.9
                                : styles.isTablet
                                    ? styles.width * 0.32
                                    : styles.width * 0.22,
                            child: CustomTextFields(
                              hintText: 'Class Size',
                              isDigitOnly: true,
                              max: 3,
                              validator: (size) {
                                if (size == null || size.isEmpty) {
                                  return 'Class sized is required';
                                }
                                return null;
                              },
                              onSaved: (size) {
                                newClassNotifier.setSize(size.toString());
                              },
                            ),
                          ),
                          //program
                          SizedBox(
                              width: styles.isMobile
                                  ? styles.width * 0.9
                                  : styles.isTablet
                                      ? styles.width * 0.32
                                      : styles.width * 0.22,
                              child: CustomDropDown(
                                  validator: (program) {
                                    if (program == null) {
                                      return 'program is required';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    newClassNotifier.setProgram(value.toString());
                                  },
                                  label: 'Program',
                                  items: programsNames
                                      .map((program) => DropdownMenuItem(
                                          value: program,
                                          child: Text(program ?? '')))
                                      .toList())),
                          SizedBox(
                            width: styles.isMobile
                                ? styles.width * 0.9
                                : styles.isTablet
                                    ? styles.width * 0.32
                                    : styles.width * 0.22,
                            child: CustomDropDown(
                              hintText: 'Class Study Mode',
                              onChanged: (mode) {
                                newClassNotifier.setMode(mode.toString());
                              },
                              validator: (mode) {
                                if (mode == null) {
                                  return 'Study mode is required';
                                }
                                return null;
                              },
                              items: ['Regular', 'Evening', 'Sandwich']
                                  .map((mode) => DropdownMenuItem(
                                      value: mode, child: Text(mode)))
                                  .toList(),
                            ),
                          ),
                          SizedBox(
                            width: styles.isMobile
                                ? styles.width * 0.9
                                : styles.isTablet
                                    ? styles.width * 0.32
                                    : styles.width * 0.22,
                            child: CustomDropDown(
                              hintText: 'Has Disability',
                              validator: (e) {
                                if (e == null) {
                                  return 'Class disability state required';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                newClassNotifier.setDisability(value.toString());
                              },
                              items: ['Yes', 'No']
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                            ),
                          ),

                          SizedBox(
                            width: styles.isMobile
                                ? styles.width * 0.9
                                : styles.isTablet
                                    ? styles.width * 0.64
                                    : styles.width * 0.45,
                            child: CustomButton(
                              radius: 10,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  newClassNotifier.saveClass(context:context,ref:ref,form:_formKey);
                                }
                              },
                              text: 'Save',
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
