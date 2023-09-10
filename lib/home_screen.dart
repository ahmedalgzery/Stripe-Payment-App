// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:stripe/payment/payment_method.dart';
import 'package:stripe/widgets/text_form_filed.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  TextEditingController priceController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Stripe Payment'),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/payment.png',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.42,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultTextFormFiled(
                          controller: priceController,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter your price !';
                            }
                            return null;
                          },
                          type: TextInputType.number,
                          hintText: 'Amount',
                          prefix: Icons.monetization_on,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              PaymentManager.makePayment(
                                  int.parse(priceController.text), "USD");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 50)),
                          child: const Text(
                            'Pay',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
