import 'package:flutter/material.dart';
import 'package:yesmachinery/src/features/productdetails/models/product_detail.dart';
import 'package:yesmachinery/src/features/productdetails/screens/product_detail.dart';
import 'package:yesmachinery/src/features/products/screens/product_lists.dart';
import '../controllers/searchpage_controller.dart';
import 'package:get/get.dart';
// Search Page

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final SearchpageController searchpagecontroller = Get.put(SearchpageController());

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
  //     await searchpagecontroller.fetchAllProducts();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            // The search area here
            title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Center(
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                searchpagecontroller.filterProduct(_searchController.text);
              },
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.text = '';
                      searchpagecontroller.filterProduct('');
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
            ),
          ),
        )),
        body: Obx(() {
          return searchpagecontroller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: searchpagecontroller.foundProduct.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Get.to(() => ProductDetailsScreen(
                            productid: searchpagecontroller.foundProduct[index].id.toString(),
                            isyc: false, // todo need to be updated
                          ));
                    },
                    child: ListTile(
                      title: Text(
                        searchpagecontroller.foundProduct[index].name.toString(),
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(searchpagecontroller.foundProduct[index].brand.toString()),
                    ),
                  ),
                );
        }));
  }
}
