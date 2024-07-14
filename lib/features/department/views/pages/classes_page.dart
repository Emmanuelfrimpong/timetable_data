import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/core/widget/custom_button.dart';

import '../../../../core/widget/custom_input.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/styles.dart';

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
        desktop: 16,
        mobile: 14,
        tablet: 14);
    var rowStyles = styles.body(desktop: 16, mobile: 14, tablet: 15);
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
                      onPressed: () {},
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(child: )
            ]));
  }
}
