import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/config/routes/router.dart';
import 'package:timetable_data/config/routes/router_info.dart';
import 'package:timetable_data/core/widget/components/app_bar_item.dart';
import 'package:timetable_data/core/widget/custom_dialog.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';
import 'package:timetable_data/generated/assets.dart';
import 'package:timetable_data/utils/colors.dart';
import 'package:timetable_data/utils/styles.dart';

class NavBar extends ConsumerWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var styles = Styles(context);
    return Container(
      width: double.infinity,
      color: primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          // Logo
          Image.asset(
            Assets.imagesLogoDart,
            width: 100,
          ),
          const SizedBox(width: 20),
          if (styles.smallerThanTablet) const Spacer(),
          // Hamburger
          if (styles.smallerThanTablet)
            PopupMenuButton(
              color: primaryColor,
              offset: const Offset(0, 70),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: BarItem(
                      padding: const EdgeInsets.only(
                          right: 40, top: 10, bottom: 10, left: 10),
                      title: 'Home',
                      onTap: () {
                        MyRouter(ref: ref, context: context)
                            .navigateToRoute(RouterItem.homeRoute);
                        Navigator.of(context).pop();
                      },
                      isActive: ref.watch(routerProvider) ==
                          RouterItem.homeRoute.name,
                      icon: Icons.home),
                ),
                PopupMenuItem(
                  child: BarItem(
                      padding: const EdgeInsets.only(
                          right: 40, top: 10, bottom: 10, left: 10),
                      title: 'Contact Us',
                      onTap: () {
                        MyRouter(ref: ref, context: context)
                            .navigateToRoute(RouterItem.contactRoute);
                        Navigator.of(context).pop();
                      },
                      isActive: ref.watch(routerProvider) ==
                          RouterItem.contactRoute.name,
                      icon: Icons.contact_mail),
                ),
                //about
                PopupMenuItem(
                  child: BarItem(
                      padding: const EdgeInsets.only(
                          right: 40, top: 10, bottom: 10, left: 10),
                      title: 'About',
                      onTap: () {
                        MyRouter(ref: ref, context: context)
                            .navigateToRoute(RouterItem.aboutRoute);
                        Navigator.of(context).pop();
                      },
                      isActive: ref.watch(routerProvider) ==
                          RouterItem.aboutRoute.name,
                      icon: Icons.info),
                ),
                if (ref.watch(userProvider) == null ||
                    ref.watch(userProvider)!.id == null ||
                    ref.watch(userProvider)!.id!.isEmpty)
                  PopupMenuItem(
                    child: BarItem(
                        padding: const EdgeInsets.only(
                            right: 40, top: 10, bottom: 10, left: 10),
                        title: 'Login',
                        onTap: () {
                          MyRouter(ref: ref, context: context)
                              .navigateToRoute(RouterItem.loginRoute);
                          Navigator.of(context).pop();
                        },
                        isActive: ref.watch(routerProvider) ==
                            RouterItem.loginRoute.name,
                        icon: Icons.login),
                  ),
                if (ref.watch(userProvider) != null &&
                    ref.watch(userProvider)!.id!.isNotEmpty)
                  PopupMenuItem(
                    child: BarItem(
                        padding: const EdgeInsets.only(
                            right: 40, top: 10, bottom: 10, left: 10),
                        title: 'Dashboard',
                        onTap: () {
                          MyRouter(ref: ref, context: context).navigateToRoute(
                              RouterItem.departmentTablesRoute);
                          Navigator.of(context).pop();
                        },
                        isActive: ref.watch(routerProvider) ==
                            RouterItem.departmentTablesRoute.name,
                        icon: Icons.dashboard),
                  ),
                if (ref.watch(userProvider) != null &&
                    ref.watch(userProvider)!.id!.isNotEmpty)
                  PopupMenuItem(
                    child: BarItem(
                        padding: const EdgeInsets.only(
                            right: 40, top: 10, bottom: 10, left: 10),
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
                        },
                        icon: Icons.logout),
                  ),
              ],
              icon: const Icon(Icons.menu, color: Colors.white),
            )
          else
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BarItem(
                  title: 'Home',
                  onTap: () {
                    MyRouter(ref: ref, context: context)
                        .navigateToRoute(RouterItem.homeRoute);
                  },
                  isActive:
                      ref.watch(routerProvider) == RouterItem.homeRoute.name,
                ),

                const SizedBox(width: 20),
                BarItem(
                  title: 'Contact',
                  onTap: () {
                    MyRouter(ref: ref, context: context)
                        .navigateToRoute(RouterItem.contactRoute);
                  },
                  isActive:
                      ref.watch(routerProvider) == RouterItem.contactRoute.name,
                ),
                const SizedBox(width: 20),
                BarItem(
                  title: 'About',
                  onTap: () {
                    MyRouter(ref: ref, context: context)
                        .navigateToRoute(RouterItem.aboutRoute);
                  },
                  isActive:
                      ref.watch(routerProvider) == RouterItem.aboutRoute.name,
                ),
                //login
                const SizedBox(width: 20),
                ref.watch(userProvider) == null ||
                        ref.watch(userProvider)!.id == null ||
                        ref.watch(userProvider)!.id!.isEmpty
                    ? BarItem(
                        padding: const EdgeInsets.only(
                            right: 40, top: 10, bottom: 10, left: 10),
                        title: 'Login',
                        onTap: () {
                          MyRouter(ref: ref, context: context)
                              .navigateToRoute(RouterItem.loginRoute);
                        },
                        isActive: ref.watch(routerProvider) ==
                            RouterItem.loginRoute.name,
                      )
                    : PopupMenuButton(
                        color: primaryColor,
                        offset: const Offset(0, 70),
                        child: CircleAvatar(
                          backgroundColor: secondaryColor,
                          backgroundImage: () {
                            return const AssetImage(
                              Assets.imagesAdmin,
                            );
                          }(),
                        ),
                        itemBuilder: (context) {
                          return [
                            //dashboard
                            PopupMenuItem(
                              child: BarItem(
                                padding: const EdgeInsets.only(
                                    right: 40, top: 10, bottom: 10, left: 10),
                                title: 'Dashboard',
                                icon: Icons.dashboard,
                                onTap: () {
                                  MyRouter(ref: ref, context: context)
                                      .navigateToRoute(
                                          RouterItem.departmentTablesRoute);
                                  Navigator.of(context).pop();
                                },
                                isActive: ref.watch(routerProvider) ==
                                    RouterItem.departmentTablesRoute.name,
                              ),
                            ),

                            PopupMenuItem(
                              child: BarItem(
                                  padding: const EdgeInsets.only(
                                      right: 40, top: 10, bottom: 10, left: 10),
                                  icon: Icons.logout,
                                  title: 'Logout',
                                  onTap: () {
                                    CustomDialog.showInfo(
                                      message:
                                          'Are you sure you want to logout?',
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
                        })
                //register
              ],
            ))
          // Nav items
        ],
      ),
    );
  }
}
