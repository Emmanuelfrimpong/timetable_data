import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/features/department/provider/department_provider.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';
import 'package:timetable_data/features/main/views/main_page.dart';
import 'package:timetable_data/utils/styles.dart';

class DetpartmentView extends ConsumerStatefulWidget {
  const DetpartmentView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetpartmentViewState();
}

class _DetpartmentViewState extends ConsumerState<DetpartmentView> {
  @override
  void initState() {
    super.initState();
    //check if widget is done building
    // WidgetsBinding.instance.addPostFrameCallback((_) {

    // });
  }

  @override
  Widget build(BuildContext context) {
     var styles = Styles(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Welcome, ',
                style: styles.subtitle(
                    fontWeight: FontWeight.w400,
                    desktop: 26,
                    mobile: 24,
                    tablet: 23),
              ),
              Text(
                ref.watch(userProvider)!.name!,
                style: styles.title(
                    fontWeight: FontWeight.bold,
                    desktop: 30,
                    mobile: 22,
                    tablet: 28),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: styles.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  NavItem(
                      title: 'Programs',
                      icon: Icons.school,
                      isSelected: ref.watch(departmentNavProvider) == 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      onPress: () {
                        ref.read(departmentNavProvider.notifier).state = 0;
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  NavItem(
                      title: 'Classes',
                      icon: Icons.hotel_class_rounded,
                      isSelected: ref.watch(departmentNavProvider) == 1,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      onPress: () {
                        ref.read(departmentNavProvider.notifier).state = 1;
                      }),
                  const SizedBox(
                    width: 10,
                  ),
                  NavItem(
                      title: 'Courses',
                      icon: Icons.library_books,
                      isSelected: ref.watch(departmentNavProvider) == 2,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 20),
                      onPress: () {
                        ref.read(departmentNavProvider.notifier).state = 2;
                      }),
                ],
              ),
            ),
          ),
          // Expanded(
          //     child: ref.watch(departmentNavProvider) == 0
          //         ? const ProgramsTab()
          //         : ref.watch(departmentNavProvider) == 1
          //             ? const ClassTab()
          //             : const CourseTab()), // Defaul
        ],
      ),
    );
  }
}
