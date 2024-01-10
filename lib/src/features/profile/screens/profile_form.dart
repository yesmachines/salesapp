import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../controller/update_profile_controller.dart';

class ProfileForm extends StatelessWidget {
  ProfileForm({Key? key}) : super(key: key);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  UpdateProfileController updateProfileController = Get.put(UpdateProfileController());
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey2,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: updateProfileController.nameController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "Full Name",
                            prefixIcon: Icon(Icons.account_box),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: updateProfileController.passwordController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: "Change Password",
                            prefixIcon: Icon(Icons.password_rounded),
                            border: OutlineInputBorder()),
                      ),

                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.lightGreen,),
                        child: Text(
                            "SAVE PROFILE",
                            style: Theme
                                .of(context)
                                .textTheme
                                .button
                        ),
                        onPressed: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey2.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            updateProfileController.saveUserProfileForm();

                          }
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
