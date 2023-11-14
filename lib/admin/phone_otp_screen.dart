import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:login_system/admin/verify_screen.dart';
import 'package:login_system/widgets/PrimayButton.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);
  static String verify = '';

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  var phone = '';
  @override
  void initState() {
    // countryController.text = "+92";
    super.initState();
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');

    setState(() {
      number = number;
    });
  }

  @override
  void dispose() {
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/appicon.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              // Container(
              //   height: 55,
              //   decoration: BoxDecoration(
              //       border: Border.all(width: 1, color: Colors.black),
              //       borderRadius: BorderRadius.circular(10)),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       SizedBox(
              //         width: 40,
              //         child: TextField(
              //           controller: countryController,
              //           keyboardType: TextInputType.number,
              //           decoration: const InputDecoration(
              //             border: InputBorder.none,
              //           ),
              //         ),
              //       ),
              //       const Text(
              //         "|",
              //         style: TextStyle(fontSize: 33, color: Colors.grey),
              //       ),
              //       const SizedBox(
              //         width: 10,
              //       ),
              //       Expanded(
              //           child: TextField(
              //         onChanged: (value) {
              //           phone = value;
              //         },
              //         controller: phoneController,
              //         keyboardType: TextInputType.phone,
              //         decoration: const InputDecoration(
              //           border: InputBorder.none,
              //           hintText: "Phone",
              //         ),
              //       ))
              //     ],
              //   ),
              // ),
              Container(
                padding: EdgeInsets.only(left: 6),
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                child: InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                  ),
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: TextStyle(color: Colors.black),
                  textFieldController: countryController,
                  formatInput: true,
                  keyboardType: TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: InputBorder.none,
                  onSaved: (PhoneNumber number) {
                    print('On Saved: $number');
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              PrimaryButton(
                  TapAction: () async {
                    try {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber: countryController.text + phone,
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          MyPhone.verify = verificationId;
                          Get.to(() => const MyVerify());
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                      Get.to(() => const MyVerify());
                    } catch (e) {
                      Get.snackbar('Enter phone number', '');
                    }
                  },
                  text: "Send the code",
                  color: Colors.black,
                  icon: Icons.account_circle)
            ],
          ),
        ),
      ),
    );
  }

  void validateAndContinue() {
    if (countryController.text.isEmpty) {
      Get.snackbar('Enter phone number', '');
      return;
    }
  }
}
