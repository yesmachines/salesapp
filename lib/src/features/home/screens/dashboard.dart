import 'package:flutter/material.dart';
import 'package:yesmachinery/src/features/authentication/screens/login.dart';
import 'package:get/get.dart';
import 'package:yesmachinery/src/features/brands/screens/brand_list_screen.dart';
import 'package:yesmachinery/src/features/home/models/divisions.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:yesmachinery/src/features/home/controllers/dashboard_controller.dart';
import 'package:yesmachinery/src/features/home/screens/search.dart';
import 'package:yesmachinery/src/global_widget.dart/common_image_view.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardController dashboardcontroller = Get.put(DashboardController());
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await dashboardcontroller.fetchDivisions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        automaticallyImplyLeading: false, // simple as that!
        title: const Text('DASHBOARD'),
        centerTitle: true,
        elevation: 2.0,
        actions: [
          // Navigate to the Search Screen
          IconButton(
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search)),
          // TextButton(
          //     onPressed: () async {
          //       final SharedPreferences? prefs = await _prefs;
          //       prefs?.clear();
          //       Get.offAll(Login());
          //     },
          //     child: Icon(Icons.logout))
        ],
      ),
      body: Container(
        child: Obx(
          () => dashboardcontroller.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // number of items in each row
                      mainAxisSpacing: 20.0, // spacing between rows
                      crossAxisSpacing: 20.0, // spacing between columns
                      mainAxisExtent: 220.0),
                  padding: EdgeInsets.all(20.0), // padding around the grid
                  itemCount: dashboardcontroller.divisionList.length, // total number of items
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => BrandListScreen(divisionId: dashboardcontroller.divisionList[index].id));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CommonImageView(
                              width: double.infinity,
                              height: 150.0,
                              url: dashboardcontroller.divisionList[index].image,
                              fit: (index == 0 || index == 1) ? BoxFit.cover : BoxFit.contain,
                            ),
                            Text(
                              dashboardcontroller.divisionList[index].name,
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
