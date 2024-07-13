import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timetable_data/about/views/about_page.dart';
import 'package:timetable_data/config/routes/router_info.dart';
import 'package:timetable_data/contact/views/contact_page.dart';
import 'package:timetable_data/features/department/data/department_model.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';
import 'package:timetable_data/features/login/views/login_page.dart';
import 'package:timetable_data/features/main/views/main_page.dart';
import '../../features/department/views/department_view.dart';
import '../../features/home/views/home_page.dart';
import 'package:universal_html/html.dart';

class MyRouter {
  final WidgetRef ref;
  final BuildContext contex;
  MyRouter({
    required this.ref,
    required this.contex,
  });
  router() => GoRouter(
          initialLocation: RouterItem.homeRoute.path,
          redirect: (context, state) {
            var route = state.fullPath;
            //check if widget is done building
            var user = MyStorage.getData('user');
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (route != null && route.isNotEmpty) {
                var item = RouterItem.getRouteByPath(route);
                ref.read(routerProvider.notifier).state = item.name;
              }
              if (user != null) {
                ref
                    .read(userProvider.notifier)
                    .setUser(DepartmentModel.fromJson(user));
              }
            });
            return null;
          },
          routes: [
            ShellRoute(
                builder: (context, state, child) {
                  return MainPage(
                    child: child,
                  );
                },
                routes: [
                  GoRoute(
                      path: RouterItem.homeRoute.path,
                      name: RouterItem.homeRoute.name,
                      builder: (context, state) {
                        return const HomePage();
                      }),

                  //login page
                  GoRoute(
                    path: RouterItem.loginRoute.path,
                    builder: (context, state) {
                      return const LoginPage();
                    },
                  ),

                  GoRoute(
                      path: RouterItem.contactRoute.path,
                      builder: (context, state) {
                        return const ContactPage();
                      }),

                  GoRoute(
                    path: RouterItem.aboutRoute.path,
                    name: RouterItem.aboutRoute.name,
                    builder: (context, state) {
                      return const AboutPage();
                    },
                  ),
                  GoRoute(
                      path: RouterItem.departmentRoute.path,
                      name: RouterItem.departmentRoute.name,
                      builder: (context, state) {
                        return const DetpartmentView();
                      }),
                ]),
          ]);

  void navigateToRoute(RouterItem item) {
    ref.read(routerProvider.notifier).state = item.name;
    contex.go(item.path);
  }

  void navigateToNamed(
      {required Map<String, String> pathParms,
      required RouterItem item,
      Map<String, dynamic>? extra}) {
    ref.read(routerProvider.notifier).state = item.name;
    contex.goNamed(item.name, pathParameters: pathParms, extra: extra);
  }
}

final routerProvider = StateProvider<String>((ref) {
  return RouterItem.homeRoute.name;
});

class MyStorage {
  static final Storage _localStorage = window.localStorage;
  static void saveData(String key, String value) {
    _localStorage[key] = value;
  }

  static String? getData(String key) {
    return _localStorage[key];
  }

  static void removeData(String key) {
    _localStorage.remove(key);
  }
}
