import 'package:flutter/material.dart';
import 'package:yesmachinery/src/features/authentication/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40.0,
                ),
                Image.asset(
                  "assets/logo.png",
                  height: size.height * 0.2,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Discover machines and possibilities",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: loginController.emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter email address';
                            } else if (!GetUtils.isEmail(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(Icons.email_rounded),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Obx(() {
                          return TextFormField(
                            controller: loginController.passwordController,
                            obscureText: loginController.isVisible.value,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: const Icon(Icons.key_rounded),
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  loginController.onVisibilityPresses();
                                },
                                icon: loginController.isVisible.value
                                    ? const Icon(Icons.remove_red_eye_sharp)
                                    : const Icon(Icons.visibility_off),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Obx(() {
                          return loginController.isPostLoading.value
                              ? const CircularProgressIndicator()
                              : OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.lightGreen,
                                    minimumSize: const Size(200.0, 50.0),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      loginController.loginWithEmail();
                                    }
                                  },
                                  child: Text("LOG IN", style: Theme.of(context).textTheme.button),
                                );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
