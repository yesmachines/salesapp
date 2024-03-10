import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controller/enquiry_controller.dart';

class EnquiryScreen extends StatefulWidget {
  final String product;
  final bool isYc;
  const EnquiryScreen({
    Key? key,
    required this.product,
    this.isYc = false,
  }) : super(key: key);

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState(product);
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  final String productName;
  _EnquiryScreenState(this.productName);

  EnquiryController enquiryController = Get.put(EnquiryController());
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    enquiryController.productController.text = productName;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Enquiry Form'),
        elevation: 2.0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Form(
              key: _formKey1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: enquiryController.productController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter product';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.black), // Set text color here
                      decoration: const InputDecoration(
                        labelText: "Product Name",
                        prefixIcon: Icon(Icons.production_quantity_limits),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black), // Set label color here
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: enquiryController.nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.black), // Set text color here
                      decoration: const InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: Icon(Icons.account_box),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black), // Set label color here
                      ),
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s]"))],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: enquiryController.companyController,
                      decoration: const InputDecoration(
                        labelText: "Company",
                        prefixIcon: Icon(Icons.business),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black), // Set label color here
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: enquiryController.emailController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter email address';
                        } else if (!GetUtils.isEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.black), // Set text color here
                      decoration: const InputDecoration(
                        labelText: "Customer Email",
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black), // Set label color here
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: enquiryController.phoneController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter phone number';
                        } else if (!RegExp(r"^[0-9]*$").hasMatch(value)) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.black), // Set text color here
                      decoration: const InputDecoration(
                        labelText: "Contact Number",
                        prefixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        labelStyle: TextStyle(color: Colors.black), // Set label color here
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      controller: enquiryController.messageController,
                      maxLines: null,
                      minLines: 2,
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(color: Colors.black), // Set text color here
                      decoration: const InputDecoration(
                        labelText: "Message",
                        prefixIcon: Icon(Icons.message),
                        border: OutlineInputBorder(),
                        hintText: "Enter your requirement here",
                        labelStyle: TextStyle(color: Colors.black), // Set label color here
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Obx(
                      () => enquiryController.isLoading.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.lightGreen,
                              ),
                              child: Text("SEND ENQUIRY", style: Theme.of(context).textTheme.button),
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey1.currentState!.validate()) {
                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                  enquiryController.sendEnquiryForm(isyc: widget.isYc);
                                }
                              },
                            ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
