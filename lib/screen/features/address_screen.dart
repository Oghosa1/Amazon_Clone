import 'package:amazon_ui/constants/global_variable.dart';
import 'package:amazon_ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:pay_with_paystack/pay_with_paystack.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address-screen';
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  // Paystack test configuration
  final String _paystackSecretKey =
      'sk_test_9e7a299f4ffc346a30bc6ce1b5227252b17d8a4d';
  final String _customerEmail = 'jarviz101@gmail.com';
  final String _currency = 'NGN';
  // ₦25,000.00 in minor units (kobo)
  final double _amountInMinorUnit = 2500000.0;
  final String _callbackUrl = 'https://www.google.com';

  final _flatController = TextEditingController();
  final _areaController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _flatController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void payStackClicked() async {
    final String reference = PayWithPayStack().generateUuidV4();
    try {
      await PayWithPayStack().now(
        context: context,
        secretKey: _paystackSecretKey,
        customerEmail: _customerEmail,
        reference: reference,
        currency: _currency,
        amount: _amountInMinorUnit,
        callbackUrl: _callbackUrl,
        transactionCompleted: (paymentData) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Payment successful!'),
              backgroundColor: Colors.green,
            ),
          );
        },
        transactionNotCompleted: (reason) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Payment failed: $reason'),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Payment error')));
    }
  }

  @override
  Widget build(BuildContext context) {
    String address = '101, ABC Street, XYZ City, 123456';
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: GlobalVariables.appBarGradient,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Current Address Section
              if (address.isNotEmpty) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(address, style: const TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 20),
                const Text('OR', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
              ],

              // Address Form
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _flatController,
                      hintText: 'Flat, House no, Building no',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _areaController,
                      hintText: 'Area, Street, Locality',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _pincodeController,
                      hintText: 'Pincode',
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: _cityController,
                      hintText: 'City',
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),

              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  payStackClicked();
                },
                child: const Text('Pay with Paystack'),
              ),
              //   const SizedBox(height: 12),
              //   // Google Pay Button
              //   FutureBuilder<PaymentConfiguration>(
              //     future: PaymentConfiguration.fromAsset('gpay.json'),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasError) {
              //         return Text(
              //           'Google Pay config error: ${snapshot.error}',
              //           style: const TextStyle(color: Colors.redAccent),
              //         );
              //       }
              //       if (!snapshot.hasData) {
              //         return const SizedBox.shrink();
              //       }
              //       const paymentItems = [
              //         PaymentItem(
              //           label: 'Total',
              //           amount: '25000.00',
              //           status: PaymentItemStatus.final_price,
              //         ),
              //       ];
              //       return GooglePayButton(
              //         paymentConfiguration: snapshot.data!,
              //         paymentItems: paymentItems,
              //         type: GooglePayButtonType.buy,
              //         onPaymentResult: (result) {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             const SnackBar(
              //               content: Text('Google Pay successful!'),
              //               backgroundColor: Colors.green,
              //             ),
              //           );
              //         },
              //         onError: (error) {
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             const SnackBar(
              //               content: Text('Google Pay failed'),
              //               backgroundColor: Colors.red,
              //             ),
              //           );
              //         },
              //       );
              //     },
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
