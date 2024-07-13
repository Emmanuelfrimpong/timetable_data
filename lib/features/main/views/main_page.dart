import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/config/routes/router.dart';
import 'package:timetable_data/config/routes/router_info.dart';
import 'package:timetable_data/core/widget/custom_dialog.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';
import 'package:timetable_data/generated/assets.dart';
import 'package:timetable_data/utils/styles.dart';

class MainPage extends ConsumerWidget {
  const MainPage({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var styles = Styles(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(
            Assets.imagesLogo,
            height: 70,
          ),
        ),
        actions: [
          if (styles.largerThanMobile)
            buildLargeScreen(context, ref)
          else
            buildSmallScreen(context, ref),
          const SizedBox(
            width: 10,
          )
        ],
      ),
      body: child,
    );
  }

  Widget buildLargeScreen(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);
    var router = MyRouter(contex: context, ref: ref);
    return Row(
      children: [
        NavItem(
            title: 'Home',
            isSelected: ref.watch(routerProvider) == RouterItem.homeRoute.name,
            onPress: () {
              router.navigateToRoute(RouterItem.homeRoute);
            }),
        const SizedBox(
          width: 10,
        ),
        NavItem(
            title: 'Contact Us',
            isSelected:
                ref.watch(routerProvider) == RouterItem.contactRoute.name,
            onPress: () {
              router.navigateToRoute(RouterItem.contactRoute);
            }),
        const SizedBox(
          width: 10,
        ),
        NavItem(
            title: 'About',
            isSelected: ref.watch(routerProvider) == RouterItem.aboutRoute.name,
            onPress: () {
              router.navigateToRoute(RouterItem.aboutRoute);
            }),
        const SizedBox(
          width: 10,
        ),
        if (user == null)
          NavItem(
              title: 'Admin Login',
              isSelected:
                  ref.watch(routerProvider) == RouterItem.loginRoute.name,
              onPress: () {
                router.navigateToRoute(RouterItem.loginRoute);
              })
        else
          PopupMenuButton<int>(
              offset: const Offset(0, 50),
              itemBuilder: (context) => [
                    const PopupMenuItem(
                        padding: EdgeInsets.only(right: 25, left: 10),
                        value: 0,
                        child: Row(
                          children: [
                            Icon(Icons.dashboard),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Dashboard'),
                          ],
                        )),
                    const PopupMenuItem(
                        padding: EdgeInsets.only(right: 25, left: 10),
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.logout),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Log Out'),
                          ],
                        ))
                  ],
              child: const CircleAvatar(
                radius: 20,
                backgroundColor: primaryColor,
                child: Icon(Icons.person,color: Colors.white,),
              ),
              onSelected: (index) {
                if (index == 0) {
                  router.navigateToNamed(
                      item: RouterItem.departmentRoute, pathParms: {'id': user.id!}
                  );
                } else {
                  CustomDialog.showInfo(
                      message: 'Are you sure you want to log out',
                      onPressed: () {
                        ref.read(userProvider.notifier).logOut(ref, context);
                      },
                      buttonText: 'Log Out',
                      buttonText2: 'Cancel');
                }
              }),
      ],
    );
  }

  Widget buildSmallScreen(BuildContext context, WidgetRef ref) {
    var user = ref.watch(userProvider);
    var router = MyRouter(contex: context, ref: ref);
    return PopupMenuButton(
        offset: const Offset(0, 50),
        itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 0,
                  child: Padding(
                    padding: EdgeInsets.only(right: 25, left: 10),
                    child: Row(
                      children: [
                        Icon(Icons.home),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Home'),
                      ],
                    ),
                  )),
              //contact
              const PopupMenuItem(
                  value: 1,
                  child: Padding(
                    padding: EdgeInsets.only(right: 25, left: 10),
                    child: Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Contact Us'),
                      ],
                    ),
                  )),
              //about
              const PopupMenuItem(
                  value: 2,
                  child: Padding(
                    padding: EdgeInsets.only(right: 25, left: 10),
                    child: Row(
                      children: [
                        Icon(Icons.info),
                        SizedBox(
                          width: 10,
                        ),
                        Text('About Us'),
                      ],
                    ),
                  )),
              //login
              if (user == null)
                const PopupMenuItem(
                    value: 3,
                    child: Padding(
                      padding: EdgeInsets.only(right: 25, left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.login),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Admin Login'),
                        ],
                      ),
                    ))
              else
                //dashboard
                const PopupMenuItem(
                    value: 4,
                    child: Padding(
                      padding: EdgeInsets.only(right: 25, left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.dashboard),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Dashboard'),
                        ],
                      ),
                    )),
              if (user != null)
                const PopupMenuItem(
                    value: 5,
                    child: Padding(
                      padding: EdgeInsets.only(right: 25, left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.logout),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Log Out'),
                        ],
                      ),
                    )),
            ],
        onSelected: (index) {
          if (index == 0) {
            router.navigateToRoute(RouterItem.homeRoute);
          } else if (index == 1) {
            router.navigateToRoute(RouterItem.contactRoute);
          } else if (index == 2) {
            router.navigateToRoute(RouterItem.aboutRoute);
          } else if (index == 3) {
            router.navigateToRoute(RouterItem.loginRoute);
          } else if (index == 4) {
             router.navigateToNamed(
                item: RouterItem.departmentRoute, pathParms: {'id': user!.id!});
          } else {
            CustomDialog.showInfo(
                message: 'Are you sure you want to log out',
                onPressed: () {
                  ref.read(userProvider.notifier).logOut(ref, context);
                },
                buttonText: 'Log Out',
                buttonText2: 'Cancel');
          }
        });
  }
}

class NavItem extends ConsumerStatefulWidget {
  const NavItem(
      {super.key,
      required this.title,
      this.icon,
      this.padding,
      this.isSelected = false,
      required this.onPress});
  final String title;
  final bool isSelected;
  final VoidCallback onPress;
  final IconData? icon;
  final EdgeInsets? padding;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NavItemState();
}

class _NavItemState extends ConsumerState<NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color:
                      widget.isSelected ? secondaryColor : Colors.transparent,
                  width: 3))),
      child: InkWell(
        onTap: widget.onPress,
        onHover: (value) {
          setState(() {
            _isHovered = !_isHovered;
          });
        },
        child: Padding(
          padding: widget.padding ??
              const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            children: [
              if (widget.icon != null)
                Icon(
                  widget.icon,
                  color: widget.isSelected ? secondaryColor : Colors.grey,
                ),
              if (widget.icon != null)
                const SizedBox(
                  width: 5,
                ),
              Text(
                widget.title,
                style: TextStyle(
                    color: widget.isSelected ? secondaryColor : Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: widget.isSelected ? 18 : 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
