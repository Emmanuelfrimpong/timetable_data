import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/config/routes/router.dart';
import 'package:timetable_data/config/routes/router_info.dart';
import 'package:timetable_data/core/widget/custom_drop_down.dart';
import 'package:timetable_data/core/widget/side_bar_item.dart';
import 'package:timetable_data/utils/colors.dart';
import 'package:timetable_data/utils/styles.dart';
import '../../features/login/provider/login_provider.dart';
import '../../features/settings/provider/settings_provider.dart';

class SideBar extends ConsumerWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var styles = Styles(context);
    var user = ref.watch(userProvider);
    return Container(
        width: 200,
        height: styles.height,
        color: primaryColor,
        child: Column(children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RichText(
                text: TextSpan(
                    text: 'Hello, \n',
                    style: styles.body(
                        color: Colors.white38, fontFamily: 'Raleway'),
                    children: [
                  TextSpan(
                      text: user!.name,
                      style: styles.subtitle(
                          fontWeight: FontWeight.bold,
                          desktop: 16,
                          mobile: 13,
                          tablet: 14,
                          color: Colors.white,
                          fontFamily: 'Raleway'))
                ])),
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(child: buildAdminManu(ref, context)),
          // footer
          Text('© 2024 All rights reserved',
              style: styles.body(
                  color: Colors.white38, desktop: 12, fontFamily: 'Raleway')),
        ]));
  }

  Widget buildAdminManu(WidgetRef ref, BuildContext context) {
    var settings = ref.watch(settingsProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
          child: CustomDropDown(
            items: settings.years
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
            color: Colors.white,
            dropDownColor: primaryColor.withOpacity(.8),
            label: 'Current Year',
            value: settings.currentYear,
            onChanged: (year) {
              ref.read(settingsProvider.notifier).setCurrentYear(year);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
          child: CustomDropDown(
            items: settings
                .semesters
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
            color: Colors.white,
            label: 'Current Semester',
            dropDownColor: primaryColor.withOpacity(.8),
            value: settings.currentSemester,
            onChanged: (semester) {
              ref.read(settingsProvider.notifier).setCurrentSemester(semester);
            },
          ),
        ),
        const SizedBox(height: 20),
        SideBarItem(
          title: 'Tables',
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          icon: Icons.dashboard,
          isActive: ref.watch(routerProvider) ==
              RouterItem.departmentTablesRoute.name,
          onTap: () {
            MyRouter(context: context, ref: ref).navigateToNamed(
              item: RouterItem.departmentTablesRoute,
              pathParms: {'id': ref.watch(userProvider)!.id!},
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Programs',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.shelves,
            isActive: ref.watch(routerProvider) ==
                RouterItem.departmentProgramsRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref).navigateToNamed(
                item: RouterItem.departmentProgramsRoute,
                pathParms: {'id': ref.watch(userProvider)!.id!},
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Classes',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.group,
            isActive: ref.watch(routerProvider) ==
                RouterItem.departmentClassesRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref).navigateToNamed(
                item: RouterItem.departmentClassesRoute,
                pathParms: {'id': ref.watch(userProvider)!.id!},
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: SideBarItem(
            title: 'Allocations',
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            icon: Icons.assignment,
            isActive: ref.watch(routerProvider) ==
                RouterItem.departmenCoursesRoute.name,
            onTap: () {
              MyRouter(context: context, ref: ref).navigateToNamed(
                item: RouterItem.departmenCoursesRoute,
                pathParms: {'id': ref.watch(userProvider)!.id!},
                
              );
            },
          ),
        ),
      ],
    );
  }
}
