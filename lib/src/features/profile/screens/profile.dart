import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yesmachinery/src/features/authentication/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:yesmachinery/src/features/profile/models/user_profile.dart';
import 'package:yesmachinery/src/features/profile/screens/profile_form.dart';
import 'package:yesmachinery/src/global_widget.dart/common_image_view.dart';
import '../controller/profile_controller.dart';
import 'package:yesmachinery/src/utils/api_endpoints.dart';

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final ProfileController profilecontroller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    UserProfile userInfo = UserProfile.fromJson(profilecontroller.userProfile);
    String rootPath = ApiEndPoints.imageRootPath;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
            () => profilecontroller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CommonImageView(url: rootPath + userInfo.imageUrl)),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userInfo.username,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        userInfo.useremail,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        userInfo.designation,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 20),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.lightGreen,
                          minimumSize: const Size(150.0, 40.0),
                        ),
                        onPressed: () async {
                          final SharedPreferences? prefs = await _prefs;
                          prefs?.clear();
                          Get.offAll(LoginScreen());
                        },
                        child: Text("LOG OUT", style: Theme.of(context).textTheme.button),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                          child: Text('Change Password ?', style: Theme.of(context).textTheme.bodyText1),
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return ProfileForm(key: UniqueKey());
                            }));
                          })
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
