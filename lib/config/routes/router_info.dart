class RouterItem {
  String path;
  String name;

  RouterItem({
    required this.path,
    required this.name,
  });

  static final loginRoute = RouterItem(
    path: '/login',
    name: 'login',
  );
  static final homeRoute = RouterItem(
    path: '/home',
    name: 'home',
  );
  //contact and about us
  static final contactRoute = RouterItem(
    path: '/contact',
    name: 'contact',
  );
  static final aboutRoute = RouterItem(
    path: '/about',
    name: 'about',
  );

  static final departmentTablesRoute = RouterItem(
    path: '/department/:id/tables',
    name: 'tables',
  );

  static final departmentProgramsRoute = RouterItem(
    path: '/department/:id/programs',
    name: 'programs',
  );

  static final departmentClassesRoute = RouterItem(
    path: '/department/:id/classes',
    name: 'classes',
  );

  static final departmenCoursesRoute = RouterItem(
    path:  '/department/:id/courses',
    name: 'courses',
  );

  static List<RouterItem> allRoutes = [
    loginRoute,
    homeRoute,
    contactRoute,
    aboutRoute,
    departmentTablesRoute,
    departmentProgramsRoute,
    departmentClassesRoute,
    departmenCoursesRoute,
  ];

  static RouterItem getRouteByPath(String fullPath) {
    return allRoutes.firstWhere((element) => element.path == fullPath);
  }
}
