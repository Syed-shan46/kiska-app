import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kiska/common/cart/cart_item_card.dart';
import 'package:kiska/features/shop/controllers/address_controller.dart';
import 'package:kiska/features/shop/controllers/order_controller.dart';
import 'package:kiska/features/shop/models/address_model.dart';
import 'package:kiska/features/shop/screens/address/edit_address.dart';
import 'package:kiska/features/shop/screens/orders/success_screen.dart';
import 'package:kiska/providers/cart_provider.dart';
import 'package:kiska/utils/constants/sizes.dart';
import 'package:kiska/utils/helpers/box_decoration_helper.dart';
import 'package:kiska/utils/themes/app_colors.dart';
import 'package:kiska/utils/themes/theme_utils.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  final double? totalAmount;
  const CheckoutScreen({
    super.key,
    this.totalAmount,
  });

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  // Variables
  String environment = "SANDBOX";
  String appId = "";
  String merchantId = "PGTESTPAYUAT86";
  bool enableLogging = false;
  String checksum = "";
  String saltKey = "96434309-7796-489d-8924-ab56988a6076";
  String saltIndex = "1";
  String callbackUrl =
      "https://webhook.site/c1a1d4a1-7c7a-4e41-94d7-520d91829dc4";
  String body = "";
  String apiEndPoint = '/pg/v1/pay';
  Object? result = "";

  // Get checksum
  getCheckSum() {
    final amountInPaise = (widget.totalAmount! * 100).toInt();
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": "transaction_123",
      "merchantUserId": "90223250",
      "amount": amountInPaise,
      "mobileNumber": "9999999999",
      "callbackUrl": callbackUrl,
      "paymentInstrument": {
        "type": "PAY_PAGE",
        "targetApp": "com.phonepe.app",
      },
    };

    String base64Body =
        checksum = base64.encode(utf8.encode(json.encode(requestData)));

    checksum =
        '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';

    return base64Body;
  }

  // Address Fetching
  final AddressController addressController = AddressController();
  Address? _fetchedAddress; // To hold the fetched address

  // Fetch address
  Future<void> fetchAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      final user = jsonDecode(userJson);
      String userId = user['_id'];

      _fetchedAddress = await addressController.fetchAddressByUserId(userId);
      setState(() {}); // Trigger rebuild after fetching the address
    }
  }

  // PhonePe Status
  void phonePeInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void handleError(error) {
    result = {"error": error};
  }

  // PhonePe payment start
  void startPgTransaction() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    final _cartProvider = ref.read(cartProvider.notifier);
    final user = jsonDecode(userJson!);
    String userId = user['_id'];
    // Fetch or specify the address ID

    final OrderController _orderController = OrderController();

    var response = PhonePePaymentSdk.startTransaction(
      body,
      callbackUrl,
      checksum,
      apiEndPoint,
    );
    response.then(
      (val) => {
        setState(() {
          if (val != null) {
            String status = val['status'].toString();
            String error = val['error'].toString();

            if (status == 'SUCCESS') {
              Future.forEach(_cartProvider.getCartItems.entries, (entry) {
                var item = entry.value;
                _orderController.createOrders(
                  name: _fetchedAddress!.name,
                  phone: _fetchedAddress!.phone,
                  country: _fetchedAddress!.country,
                  city: _fetchedAddress!.city,
                  address: _fetchedAddress!.address,
                  id: userId,
                  productName: item.productName,
                  quantity: item.quantity,
                  category: item.category,
                  image: item.image[0],
                  totalAmount: item.totalPrice,
                  paymentStatus: 'Success',
                  delivered: false,
                  context: context,
                );
              });
              result = "Flow completed - status: Completed";
            } else {
              result = 'Flow complete- status: $status and error $error';
            }
          } else {
            result = "flow incomplete";
          }
        })
      },
    );
  }

  // Init Method
  @override
  void initState() {
    super.initState();
    fetchAddress();
    phonePeInit();
    body = getCheckSum().toString();
  }

  bool isSelected = false; // Track selection state

  @override
  Widget build(BuildContext context) {
    final cartData = ref.watch(cartProvider);
    final _cartProvider = ref.watch(cartProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Deliver to text
              aboveTitle(context, 'Deliver to:'),
              const SizedBox(height: 5),

              // Display Address Information
              if (_fetchedAddress == null)
                SizedBox(
                  height: 93.h,
                  child: LoadingAnimationWidget.hexagonDots(
                      color: AppColors.primaryColor, size: 20),
                )
              else
                Container(
                    padding: const EdgeInsets.all(16),
                    decoration: getDynamicBoxDecoration(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: ${_fetchedAddress!.name}'),
                              Text('Phone: ${_fetchedAddress!.phone}'),
                              Text('Address: ${_fetchedAddress!.address}'),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.to(() => EditAddress()),
                          icon: Icon(Iconsax.edit),
                        ),
                      ],
                    )),

              // Items

              SizedBox(height: MySizes.spaceBtwSections),
              aboveTitle(context, 'Your Items'),
              SizedBox(height: MySizes.spaceBtwItems / 2),
              CartItemCard(
                showQuantity: true,
                showButtons: false,
                cartData: cartData,
                cartProvider: _cartProvider,
              ),
              SizedBox(height: MySizes.spaceBtwSections),

              aboveTitle(context, 'Payment Method'),
              SizedBox(height: MySizes.spaceBtwItems / 2),

              GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = true;
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: ThemeUtils.dynamicTextColor(context)
                            .withOpacity(0.8)),
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Image on the left side
                      Center(
                        child: Image(
                          height: 25.h,
                          image: AssetImage('assets/images/user/payment.png'),
                        ),
                      ),

                      // Radio selection box on the right side
                      Radio<bool>(
                        value: true, // The selected state value for this radio
                        groupValue:
                            isSelected, // The current state of the selection
                        onChanged: (bool? value) {
                          // When tapped, this changes the selection state
                          setState(() {
                            isSelected = value!;
                          });
                        },
                        activeColor: AppColors
                            .primaryColor, // Color of the inner circle when selected
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: MySizes.spaceBtwItems),

              SizedBox(
                width: double.infinity,
                child: SizedBox(
                  height: 40.h,
                  child: ElevatedButton(
                    onPressed: () {
                      startPgTransaction();
                    },
                    child: Text(
                      'Start Payment',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: DynamicBg.sameBrightness(context)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Text aboveTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        color: ThemeUtils.dynamicTextColor(context),
      ),
    );
  }
}
