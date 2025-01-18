import 'package:e_commerce/constants/utils.dart';
import 'package:e_commerce/features/address/services/address_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_commerce/common/widgets/custom_textfield.dart';
import 'package:e_commerce/constants/global_variables.dart';
import 'package:e_commerce/providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({
    Key? key,
    required this.totalAmount,
  }) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _addressFormKey = GlobalKey<FormState>();

  String addressToBeUsed = "";
  final AddressServices addressServices = AddressServices();

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    pincodeController.dispose();
    cityController.dispose();
  }

  void onPlaceOrder(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        cityController.text.isNotEmpty;

    if (isForm) {
      if (_addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
      } else {
        showSnackBar(context, 'Please fill out all fields.');
        return;
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Please enter an address.');
      return;
    }

    // Call the addressServices to place the order
    addressServices.saveUserAddress(context: context, address: addressToBeUsed);
    addressServices.placeOrder(
      context: context,
      address: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );

    showSnackBar(context, 'Order placed successfully!');
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          address,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'OR',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: _addressFormKey,
                child: Column(
                  children: [
                    CustomTextfield(
                      controller: flatBuildingController,
                      hintText: 'Flat, House no, Building',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: areaController,
                      hintText: 'Area, Street',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextfield(
                      controller: cityController,
                      hintText: 'Town/City',
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => onPlaceOrder(address),
                style: ElevatedButton.styleFrom(
                  backgroundColor: GlobalVariables.secondaryColor,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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





// ________________________________________________________________ --------------------------------------------
// ________________________________________________________________ --------------------------------------------
// ________________________________________________________________ --------------------------------------------
// ________________________________________________________________ --------------------------------------------
// ________________________________________________________________ --------------------------------------------
// ________________________________________________________________ --------------------------------------------
// ________________________________________________________________ --------------------------------------------
// ________________________________________________________________ --------------------------------------------
// ________________________________________________________________ --------------------------------------------
// ________________________________________________________________ --------------------------------------------
// ________________________________________________________________ --------------------------------------------
// ________________________________________________________________ --------------------------------------------













// import 'package:e_commerce/constants/utils.dart';
// import 'package:e_commerce/features/address/services/address_services.dart';
// import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
// import 'package:provider/provider.dart';
// import 'package:e_commerce/common/widgets/custom_textfield.dart';
// import 'package:e_commerce/constants/global_variables.dart';
// import 'package:e_commerce/providers/user_provider.dart';

// class AddressScreen extends StatefulWidget {
//   static const String routeName = '/address';
//   final String totalAmount;
//   const AddressScreen({
//     Key? key,
//     required this.totalAmount,
//   }) : super(key: key);

//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   final TextEditingController flatBuildingController = TextEditingController();
//   final TextEditingController areaController = TextEditingController();
//   final TextEditingController pincodeController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final _addressFormKey = GlobalKey<FormState>();

//   String addressToBeUsed = "";
//   List<PaymentItem> paymentItems = [];
//   final AddressServices addressServices = AddressServices();

//   @override
//   void initState() {
//     super.initState();
//     paymentItems.add(
//       PaymentItem(
//         amount: widget.totalAmount,
//         label: 'Total Amount',
//         status: PaymentItemStatus.final_price,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     flatBuildingController.dispose();
//     areaController.dispose();
//     pincodeController.dispose();
//     cityController.dispose();
//   }

//   void onGooglePayResult(res) {
//     if (Provider.of<UserProvider>(context, listen: false)
//         .user
//         .address
//         .isEmpty) {
//       addressServices.saveUserAddress(
//           context: context, address: addressToBeUsed);
//     }
//     addressServices.placeOrder(
//       context: context,
//       address: addressToBeUsed,
//       totalSum: double.parse(widget.totalAmount),
//     );
//   }

//   void payPressed(String addressFromProvider) {
//     addressToBeUsed = "";

//     bool isForm = flatBuildingController.text.isNotEmpty ||
//         areaController.text.isNotEmpty ||
//         pincodeController.text.isNotEmpty ||
//         cityController.text.isNotEmpty;

//     if (isForm) {
//       if (_addressFormKey.currentState!.validate()) {
//         addressToBeUsed =
//             '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
//       } else {
//         throw Exception('Please enter all the values!');
//       }
//     } else if (addressFromProvider.isNotEmpty) {
//       addressToBeUsed = addressFromProvider;
//     } else {
//       showSnackBar(context, 'ERROR');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var address = context.watch<UserProvider>().user.address;

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: GlobalVariables.appBarGradient,
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               if (address.isNotEmpty)
//                 Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black12,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           address,
//                           style: const TextStyle(
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'OR',
//                       style: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               Form(
//                 key: _addressFormKey,
//                 child: Column(
//                   children: [
//                     CustomTextfield(
//                       controller: flatBuildingController,
//                       hintText: 'Flat, House no, Building',
//                     ),
//                     const SizedBox(height: 10),
//                     CustomTextfield(
//                       controller: areaController,
//                       hintText: 'Area, Street',
//                     ),
//                     const SizedBox(height: 10),
//                     CustomTextfield(
//                       controller: pincodeController,
//                       hintText: 'Pincode',
//                     ),
//                     const SizedBox(height: 10),
//                     CustomTextfield(
//                       controller: cityController,
//                       hintText: 'Town/City',
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//               // Use FutureBuilder to load payment configuration
//               FutureBuilder<PaymentConfiguration>(
//                 future: PaymentConfiguration.fromAsset('gpay.json'),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text('Error loading configuration');
//                   } else if (!snapshot.hasData) {
//                     return const Text('No payment configuration found');
//                   } else {
//                     PaymentConfiguration config = snapshot.data!;

//                     return Column(
//                       children: [
//                         GooglePayButton(
//                           onPressed: () => payPressed(address),
//                           paymentConfiguration: config,
//                           onPaymentResult: onGooglePayResult,
//                           paymentItems: paymentItems,
//                           height: 50,

//                           theme: GooglePayButtonTheme.dark,

//                           // width: 50,
//                           type: GooglePayButtonType.buy,
//                           margin: const EdgeInsets.only(top: 15),
//                           loadingIndicator: const Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:e_commerce/constants/utils.dart';
// import 'package:e_commerce/features/address/services/address_services.dart';
// import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
// import 'package:provider/provider.dart';
// import 'package:e_commerce/common/widgets/custom_textfield.dart';
// import 'package:e_commerce/constants/global_variables.dart';
// import 'package:e_commerce/providers/user_provider.dart';

// class AddressScreen extends StatefulWidget {
//   static const String routeName = '/address';
//   final String totalAmount;
//   const AddressScreen({
//     Key? key,
//     required this.totalAmount,
//   }) : super(key: key);

//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   final TextEditingController flatBuildingController = TextEditingController();
//   final TextEditingController areaController = TextEditingController();
//   final TextEditingController pincodeController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final _addressFormKey = GlobalKey<FormState>();

//   String addressToBeUsed = "";
//   List<PaymentItem> paymentItems = [];
//   final AddressServices addressServices = AddressServices();

//   @override
//   void initState() {
//     super.initState();
//     paymentItems.add(
//       PaymentItem(
//         amount: widget.totalAmount,
//         label: 'Total Amount',
//         status: PaymentItemStatus.final_price,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     flatBuildingController.dispose();
//     areaController.dispose();
//     pincodeController.dispose();
//     cityController.dispose();
//   }

//   void onApplePayResult(res) {
//     if (Provider.of<UserProvider>(context, listen: false)
//         .user
//         .address
//         .isEmpty) {
//       addressServices.saveUserAddress(
//           context: context, address: addressToBeUsed);
//     }
//     addressServices.placeOrder(
//       context: context,
//       address: addressToBeUsed,
//       totalSum: double.parse(widget.totalAmount),
//     );
//   }

//   void onGooglePayResult(res) {
//     if (Provider.of<UserProvider>(context, listen: false)
//         .user
//         .address
//         .isEmpty) {
//       addressServices.saveUserAddress(
//           context: context, address: addressToBeUsed);
//     }
//     addressServices.placeOrder(
//       context: context,
//       address: addressToBeUsed,
//       totalSum: double.parse(widget.totalAmount),
//     );
//   }

//   void payPressed(String addressFromProvider) {
//     addressToBeUsed = "";

//     bool isForm = flatBuildingController.text.isNotEmpty ||
//         areaController.text.isNotEmpty ||
//         pincodeController.text.isNotEmpty ||
//         cityController.text.isNotEmpty;

//     if (isForm) {
//       if (_addressFormKey.currentState!.validate()) {
//         addressToBeUsed =
//             '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
//       } else {
//         throw Exception('Please enter all the values!');
//       }
//     } else if (addressFromProvider.isNotEmpty) {
//       addressToBeUsed = addressFromProvider;
//     } else {
//       showSnackBar(context, 'ERROR');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var address = context.watch<UserProvider>().user.address;

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: GlobalVariables.appBarGradient,
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               if (address.isNotEmpty)
//                 Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black12,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           address,
//                           style: const TextStyle(
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'OR',
//                       style: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               Form(
//                 key: _addressFormKey,
//                 child: Column(
//                   children: [
//                     CustomTextfield(
//                       controller: flatBuildingController,
//                       hintText: 'Flat, House no, Building',
//                     ),
//                     const SizedBox(height: 10),
//                     CustomTextfield(
//                       controller: areaController,
//                       hintText: 'Area, Street',
//                     ),
//                     const SizedBox(height: 10),
//                     CustomTextfield(
//                       controller: pincodeController,
//                       hintText: 'Pincode',
//                     ),
//                     const SizedBox(height: 10),
//                     CustomTextfield(
//                       controller: cityController,
//                       hintText: 'Town/City',
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//               // Use FutureBuilder to load payment configuration
//               FutureBuilder<PaymentConfiguration>(
//                 future: PaymentConfiguration.fromAsset('assets/applepay.json'),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const CircularProgressIndicator();
//                   } else if (snapshot.hasError) {
//                     return Text('Error loading configuration');
//                   } else if (!snapshot.hasData) {
//                     return const Text('No payment configuration found');
//                   } else {
//                     PaymentConfiguration config = snapshot.data!;

//                     return Column(
//                       children: [
//                         ApplePayButton(
//                           width: double.infinity,
//                           style: ApplePayButtonStyle.whiteOutline,
//                           type: ApplePayButtonType.buy,
//                           paymentConfiguration: config,
//                           onPaymentResult: onApplePayResult,
//                           paymentItems: paymentItems,
//                           margin: const EdgeInsets.only(top: 15),
//                           height: 50,
//                           onPressed: () => payPressed(address),
//                         ),
//                         const SizedBox(height: 10),
//                         GooglePayButton(
//                           onPressed: () => payPressed(address),
//                           paymentConfiguration: config,
//                           onPaymentResult: onGooglePayResult,
//                           paymentItems: paymentItems,
//                           height: 50,
//                           type: GooglePayButtonType.buy,
//                           margin: const EdgeInsets.only(top: 15),
//                           loadingIndicator: const Center(
//                             child: CircularProgressIndicator(),
//                           ),
//                         ),
//                       ],
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class AddressScreen extends StatefulWidget {
//   static const String routeName = '/address';
//   final String totalAmount;
//   const AddressScreen({super.key, required this.totalAmount});

//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// import 'package:e_commerce/constants/utils.dart';
// import 'package:e_commerce/features/address/services/address_services.dart';
// import 'package:flutter/material.dart';
// import 'package:pay/pay.dart';
// import 'package:provider/provider.dart';
// import 'package:e_commerce/common/widgets/custom_textfield.dart';
// import 'package:e_commerce/constants/global_variables.dart';
// import 'package:e_commerce/providers/user_provider.dart';

// class AddressScreen extends StatefulWidget {
//   static const String routeName = '/address';
//   final String totalAmount;
//   const AddressScreen({super.key, required this.totalAmount});

//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   final TextEditingController flatBuildingController = TextEditingController();
//   final TextEditingController areaController = TextEditingController();
//   final TextEditingController pincodeController = TextEditingController();
//   final TextEditingController cityController = TextEditingController();
//   final _addressFormKey = GlobalKey<FormState>();

//   String addressToBeUsed = "";
//   List<PaymentItem> paymentItems = [];
//   final AddressServices addressServices = AddressServices();

//   @override
//   void initState() {
//     super.initState();
//     paymentItems.add(
//       PaymentItem(
//         amount: widget.totalAmount,
//         label: 'Total Amount',
//         status: PaymentItemStatus.final_price,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     flatBuildingController.dispose();
//     areaController.dispose();
//     pincodeController.dispose();
//     cityController.dispose();
//   }

//   void onApplePayResult(res) {
//     if (Provider.of<UserProvider>(context, listen: false)
//         .user
//         .address
//         .isEmpty) {
//       addressServices.saveUserAddress(
//           context: context, address: addressToBeUsed);
//     }
//     addressServices.placeOrder(
//       context: context,
//       address: addressToBeUsed,
//       totalSum: double.parse(widget.totalAmount),
//     );
//   }

//   void onGooglePayResult(res) {
//     if (Provider.of<UserProvider>(context, listen: false)
//         .user
//         .address
//         .isEmpty) {
//       addressServices.saveUserAddress(
//           context: context, address: addressToBeUsed);
//     }
//     addressServices.placeOrder(
//       context: context,
//       address: addressToBeUsed,
//       totalSum: double.parse(widget.totalAmount),
//     );
//   }

//   void payPressed(String addressFromProvider) {
//     addressToBeUsed = "";

//     bool isForm = flatBuildingController.text.isNotEmpty ||
//         areaController.text.isNotEmpty ||
//         pincodeController.text.isNotEmpty ||
//         cityController.text.isNotEmpty;

//     if (isForm) {
//       if (_addressFormKey.currentState!.validate()) {
//         addressToBeUsed =
//             '${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pincodeController.text}';
//       } else {
//         throw Exception('Please enter all the values!');
//       }
//     } else if (addressFromProvider.isNotEmpty) {
//       addressToBeUsed = addressFromProvider;
//     } else {
//       showSnackBar(context, 'ERROR');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     var address = context.watch<UserProvider>().user.address;

//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(60),
//         child: AppBar(
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: GlobalVariables.appBarGradient,
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               if (address.isNotEmpty)
//                 Column(
//                   children: [
//                     Container(
//                       width: double.infinity,
//                       decoration: BoxDecoration(
//                         border: Border.all(
//                           color: Colors.black12,
//                         ),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           address,
//                           style: const TextStyle(
//                             fontSize: 18,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const Text(
//                       'OR',
//                       style: TextStyle(
//                         fontSize: 18,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               Form(
//                 key: _addressFormKey,
//                 child: Column(
//                   children: [
//                     CustomTextfield(
//                       controller: flatBuildingController,
//                       hintText: 'Flat, House no, Building',
//                     ),
//                     const SizedBox(height: 10),
//                     CustomTextfield(
//                       controller: areaController,
//                       hintText: 'Area, Street',
//                     ),
//                     const SizedBox(height: 10),
//                     CustomTextfield(
//                       controller: pincodeController,
//                       hintText: 'Pincode',
//                     ),
//                     const SizedBox(height: 10),
//                     CustomTextfield(
//                       controller: cityController,
//                       hintText: 'Town/City',
//                     ),
//                     const SizedBox(height: 10),
//                   ],
//                 ),
//               ),
//               // ApplePayButton(
//               //   width: double.infinity,
//               //   style: ApplePayButtonStyle.whiteOutline,
//               //   type: ApplePayButtonType.buy,
//               //   paymentConfiguration:
//               //       PaymentConfiguration.fromAsset('assets/applepay.json'),
//               //   onPaymentResult: onApplePayResult,
//               //   paymentItems: paymentItems,
//               //   margin: const EdgeInsets.only(top: 15),
//               //   height: 50,
//               //   onPressed: () => payPressed(address),
//               // ),
//               // const SizedBox(height: 10),
//               // GooglePayButton(
//               //   onPressed: () => payPressed(address),
//               //   paymentConfiguration:
//               //       PaymentConfiguration.fromAsset('gpay.json'),
//               //   onPaymentResult: onGooglePayResult,
//               //   paymentItems: paymentItems,
//               //   height: 50,
//               //   type: GooglePayButtonType.buy,
//               //   margin: const EdgeInsets.only(top: 15),
//               //   loadingIndicator: const Center(
//               //     child: CircularProgressIndicator(),
//               //   ),
//               // ),

//               // ApplePayButton(
//               //   width: double.infinity,
//               //   style: ApplePayButtonStyle.whiteOutline,
//               //   type: ApplePayButtonType.buy,
//               //   paymentConfigurationAsset: 'applepay.json',
//               //   onPaymentResult: onApplePayResult,
//               //   paymentItems: paymentItems,
//               //   margin: const EdgeInsets.only(top: 15),
//               //   height: 50,
//               //   onPressed: () => payPressed(address),
//               // ),
//               const SizedBox(height: 10),
//               // GooglePayButton(
//               //   onPressed: () => payPressed(address),
//               //   paymentConfigurationAsset: 'assets/gpay.json',
//               //   onPaymentResult: onGooglePayResult,
//               //   paymentItems: paymentItems,
//               //   height: 50,

//               //   // style: GooglePayButtonStyle.black,

//               //   type: GooglePayButtonType.pay,
//               //   margin: const EdgeInsets.only(top: 15),
//               //   loadingIndicator: const Center(
//               //     child: CircularProgressIndicator(),
//               //   ),
//               // ),
//               // GooglePayButton(
//               //   onPaymentResult: onGooglePayResult,
//               //   paymentItems: paymentItems,
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
