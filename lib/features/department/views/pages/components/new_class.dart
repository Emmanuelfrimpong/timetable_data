import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/core/widget/custom_drop_down.dart';
import 'package:timetable_data/core/widget/custom_input.dart';
import 'package:timetable_data/utils/colors.dart';
import 'package:timetable_data/utils/styles.dart';

import '../../../../../core/widget/custom_button.dart';

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
                    padding: EdgeInsets.symmetric(horizontal: 15),
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
                  Form(
                    key: _formKey,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 22,
                      children: [
                        SizedBox(
                          width: styles.isMobile
                              ? styles.width * 0.9
                              : styles.isTablet
                                  ? styles.width * 0.32
                                  : styles.width * 0.22,
                          child: const CustomTextFields(
                            label: 'Class Name',
                          ),
                        ),
                        SizedBox(
                          width: styles.isMobile
                              ? styles.width * 0.9
                              : styles.isTablet
                                  ? styles.width * 0.32
                                  : styles.width * 0.22,
                          child: const CustomDropDown(
                            label: 'Class Level',
                            
                          ),
                        ),
                        const SizedBox(height: 10), 
                        const CustomTextFields(
                          hintText: 'Class Size',
                          prefixIcon: Icons.class_,
                        ),
                        const SizedBox(height: 10),
                        const CustomTextFields(
                          hintText: 'Class Year',
                          prefixIcon: Icons.class_,
                        ),
                        const SizedBox(height: 10),
                        const CustomTextFields(
                          hintText: 'Class Semester',
                          prefixIcon: Icons.class_,
                        ),
                        const SizedBox(height: 10),
                        const CustomTextFields(
                          hintText: 'Class Department',
                          prefixIcon: Icons.class_,
                        ),
                        const SizedBox(height: 10),
                        const CustomTextFields(
                          hintText: 'Class Program',
                          prefixIcon: Icons.class_,
                        ),
                        const SizedBox(height: 10),
                        const CustomTextFields(
                          hintText: 'Class Study Mode',
                          prefixIcon: Icons.class_,
                        ),
                        const SizedBox(height: 10),
                        const CustomTextFields(
                          hintText: 'Class Disability',
                          prefixIcon: Icons.class_,
                        ),
                        const SizedBox(height: 10),
                        CustomButton(
                          onPressed: () {},
                          text: 'Save',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
