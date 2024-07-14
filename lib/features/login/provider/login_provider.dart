import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/config/routes/router.dart';
import 'package:timetable_data/config/routes/router_info.dart';
import 'package:timetable_data/core/widget/custom_dialog.dart';
import 'package:timetable_data/features/department/data/department_model.dart';
import 'package:timetable_data/features/login/services/auth_services.dart';

final loginObsecureTextProvider = StateProvider<bool>((ref) => true);

final loginProvider = StateNotifierProvider<LoginProvider, DepartmentModel>(
    (ref) => LoginProvider());

class LoginProvider extends StateNotifier<DepartmentModel> {
  LoginProvider()
      : super(
            DepartmentModel(createdAt: DateTime.now().millisecondsSinceEpoch));

  void setId(String value) {
    state = state.copyWith(id: () => value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: () => value);
  }

  void loginUser(
      {required WidgetRef ref, required BuildContext context}) async {
    CustomDialog.showLoading(message: 'Logging in.....');
    var (message, user) = await AuthServices.findDepartment(
        id: state.id!, password: state.password!);
    if (user != null) {
      MyStorage.saveData('user', user.toJson());
      ref.read(userProvider.notifier).setUser(user);
      MyRouter(context: context, ref: ref).navigateToNamed(
          item: RouterItem.departmentTablesRoute, pathParms: {'id': user.id!});
      CustomDialog.dismiss();
      CustomDialog.showToast(message: message);
    } else {
      CustomDialog.dismiss();
      CustomDialog.showError(message: message);
    }
  }

  void setUser(DepartmentModel userData) {
    state = userData;
  }
}

final userProvider = StateNotifierProvider<UserProvider, DepartmentModel?>(
    (ref) => UserProvider());

class UserProvider extends StateNotifier<DepartmentModel?> {
  UserProvider() : super(null) {
    getUser();
  }

  void removeUser() {
    state = null;
  }

  void setUser(DepartmentModel user) {
    state = user;
  }

  void getUser() {
    var user = MyStorage.getData('user');
    if (user != null) {
      state = DepartmentModel.fromJson(user);
    }
  }

  void logOut(WidgetRef ref, BuildContext context) {
    CustomDialog.dismiss();
    MyStorage.removeData('user');
    state = null;
    MyRouter(context: context, ref: ref).navigateToRoute(
      RouterItem.homeRoute,
    );
  }
}
