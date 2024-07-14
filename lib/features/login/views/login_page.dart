import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timetable_data/core/widget/custom_button.dart';
import 'package:timetable_data/core/widget/custom_input.dart';
import 'package:timetable_data/features/login/provider/login_provider.dart';
import 'package:timetable_data/generated/assets.dart';
import 'package:timetable_data/utils/colors.dart';
import 'package:timetable_data/utils/styles.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  // final _emailController = TextEditingController();
  // final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    return Container(
      color: Colors.white,
      height: styles.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: styles.isMobile ? styles.height * .8 : null,
              alignment: Alignment.center,
              child: Card(
                  elevation: styles.smallerThanTablet ? 0 : 5,
                  child: Container(
                    width: styles.isMobile
                        ? double.infinity
                        : styles.width < 1200
                            ? styles.width * .75
                            : styles.width * .45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: styles.isMobile
                        ? builform() 
                        : Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 400,
                                  color: primaryColor,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(Assets.imagesLogoDart,
                                          height: 200),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: builform(),
                              ),
                            ],
                          ),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget builform() {
    var styles = Styles(context);
    var notifier = ref.read(loginProvider.notifier);
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Login ',
                style: styles.title(
                    color: primaryColor,
                    mobile: 35,
                    desktop: 45,
                    tablet: 32,
                    fontWeight: FontWeight.bold),
              ),
              const Divider(
                thickness: 3,
                color: secondaryColor,
              ),
              const SizedBox(height: 20),
              CustomTextFields(
                label: 'Department ID',
                prefixIcon: Icons.person,
                //controller: _emailController,
                hintText: 'Enter Department ID',
                isCapitalized: true,
                onSaved: (id) {
                  notifier.setId(id!);
                },
                validator: (email) {
                  if (email == null || email.isEmpty) {
                    return 'Department ID is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomTextFields(
                label: 'Password',
                prefixIcon: Icons.lock,
                hintText: 'Enter your password',
                //controller: _passwordController,
                obscureText: ref.watch(loginObsecureTextProvider),
                suffixIcon: IconButton(
                  icon: Icon(ref.watch(loginObsecureTextProvider)
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    ref.read(loginObsecureTextProvider.notifier).state =
                        !ref.read(loginObsecureTextProvider);
                  },
                ),
                keyboardType: TextInputType.visiblePassword,
                onSaved: (password) {
                  notifier.setPassword(password!);
                },
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return 'Password is required';
                  } else if (password.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Proceed',
                radius: 5,
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    //todo login user
                    _formKey.currentState!.save();
                    notifier.loginUser(ref: ref, context: context);
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
