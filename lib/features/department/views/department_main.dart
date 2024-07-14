import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/config/routes/router.dart';
import 'package:timetable_data/core/widget/custom_dialog.dart';
import 'package:timetable_data/core/widget/custom_drop_down.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';
import 'package:timetable_data/features/settings/provider/settings_provider.dart';
import 'package:timetable_data/generated/assets.dart';
import 'package:timetable_data/utils/styles.dart';
import 'package:universal_html/js_util.dart';

import '../../../config/routes/router_info.dart';
import '../../../core/widget/components/app_bar_item.dart';
import '../../../core/widget/side_bar.dart';
import '../../../utils/colors.dart';

class DepartmentMain extends ConsumerStatefulWidget {
  const DepartmentMain(this.child, {super.key});
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DetpartmentViewState();
}

class _DetpartmentViewState extends ConsumerState<DepartmentMain> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var settingsStreamProvider = ref.watch(settingsStream);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            actions: [
              const SizedBox(width: 10),
              PopupMenuButton(
                  color: primaryColor,
                  offset: const Offset(0, 70),
                  child: CircleAvatar(
                    backgroundColor: secondaryColor,
                    backgroundImage: () {
                      return const AssetImage(Assets.imagesAdmin);
                    }(),
                  ),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: BarItem(
                            padding: const EdgeInsets.only(
                                right: 40, top: 10, bottom: 10, left: 10),
                            icon: Icons.home,
                            title: 'GoTo Home',
                            onTap: () {
                              MyRouter(context: context, ref: ref)
                                  .navigateToRoute(RouterItem.homeRoute);
                              Navigator.of(context).pop();
                            }),
                      ),
                      PopupMenuItem(
                        child: BarItem(
                            padding: const EdgeInsets.only(
                                right: 40, top: 10, bottom: 10, left: 10),
                            icon: Icons.logout,
                            title: 'Logout',
                            onTap: () {
                              CustomDialog.showInfo(
                                message: 'Are you sure you want to logout?',
                                buttonText: 'Logout',
                                onPressed: () {
                                  ref
                                      .read(userProvider.notifier)
                                      .logOut(ref, context);
                                  //close popup
                                  Navigator.of(context).pop();
                                },
                              );
                            }),
                      ),
                    ];
                  }),
              const SizedBox(width: 10),
            ],
            title: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    Assets.imagesLogoT,
                    height: 50,
                  ),
                ),
                const SizedBox(width: 10),
                if (styles.smallerThanTablet) buildAdminManu(ref, context)
              ],
            ),
          ),
          body: settingsStreamProvider.when(
            data: (data) {
              return Container(
                color: Colors.white60,
                padding: const EdgeInsets.all(10),
                child: styles.smallerThanTablet
                    ? widget.child
                    : Row(
                        children: [
                          const SideBar(),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Container(
                            color: Colors.grey[100],
                            padding: const EdgeInsets.all(10),
                            child: widget.child,
                          ))
                        ],
                      ),
              );
            },
            error: (error, stack) {
              return Center(child: Text('Error: $error'));
            },
            loading: () {
              return const Center(child: CircularProgressIndicator());
            },
          )),
    );
  }

  Widget buildAdminManu(WidgetRef ref, BuildContext context) {
    var settings = ref.watch(settingsProvider);
    return PopupMenuButton(
      color: primaryColor,
      offset: const Offset(0, 70),
      child: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
          PopupMenuItem(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: CustomDropDown(
              items: settings.semesters
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
                ref
                    .read(settingsProvider.notifier)
                    .setCurrentSemester(semester);
              },
            ),
          ),
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.dashboard,
                title: 'Tables',
                onTap: () {
                  MyRouter(context: context, ref: ref).navigateToNamed(
                      item: RouterItem.departmentTablesRoute,
                      pathParms: {'id': ref.watch(userProvider)!.id!});
                  Navigator.of(context).pop();
                }),
          ),
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.shelves,
                title: 'Programs',
                onTap: () {
                  MyRouter(context: context, ref: ref).navigateToNamed(
                      item: RouterItem.departmentProgramsRoute,
                      pathParms: {'id': ref.watch(userProvider)!.id!});
                  Navigator.of(context).pop();
                }),
          ),
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.group,
                title: 'Classes',
                onTap: () {
                  MyRouter(context: context, ref: ref).navigateToNamed(
                      item: RouterItem.departmentClassesRoute,
                      pathParms: {'id': ref.watch(userProvider)!.id!});
                  Navigator.of(context).pop();
                }),
          ),
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.assignment,
                title: 'Courses',
                onTap: () {
                  MyRouter(context: context, ref: ref).navigateToNamed(
                      item: RouterItem.departmenCoursesRoute,
                      pathParms: {'id': ref.watch(userProvider)!.id!});
                  Navigator.of(context).pop();
                }),
          ),
        ];
      },
    );
  }
}
