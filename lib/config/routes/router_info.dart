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

  static final departmentRoute = RouterItem(
    path: '/department/:id',
    name: 'department',
  );

  static List<RouterItem> allRoutes = [
    loginRoute,
    homeRoute,
    departmentRoute,
    contactRoute,
    aboutRoute,
  ];

  static RouterItem getRouteByPath(String fullPath) {
    return allRoutes.firstWhere((element) => element.path == fullPath);
  }
}
