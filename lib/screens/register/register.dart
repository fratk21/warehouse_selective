import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:warehouse_selective/navigator.dart';
import 'package:warehouse_selective/services/auth_service.dart';
import 'package:warehouse_selective/utils/utils.dart';

import '../../components/background.dart';
import '../../constants/constants.dart';
import '../../widgets/inputText.dart';
import '../login/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController phone = TextEditingController();
  String? phoneNumber;
  auth_services _servis = auth_services();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: const Text(
                "REGISTER",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2196F3),
                    fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: username,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: black),
                    ),
                    labelText: "Username",
                    labelStyle: TextStyle(color: Colors.black),
                    suffixIcon: Icon(
                      Icons.person,
                      color: Color(0xFF2196F3),
                    )),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: black),
                    ),
                    labelText: "E-mail",
                    labelStyle: TextStyle(color: Colors.black),
                    suffixIcon: Icon(
                      Icons.mail,
                      color: Color(0xFF2196F3),
                    )),
              ),
            ),
            //  SizedBox(height: size.height * 0.03),
            // Container(
            //   alignment: Alignment.center,
            //   margin: EdgeInsets.symmetric(horizontal: 40),
            //   color: Colors.transparent,
            //   child: Form(
            //     child: IntlPhoneField(
            //       autofocus: true,
            //       invalidNumberMessage: 'Invalid Phone Number!',
            //       textAlignVertical: TextAlignVertical.center,
            //       onChanged: (phone) => phoneNumber = phone.completeNumber,
            //       initialCountryCode: 'TR',
            //       flagsButtonPadding: const EdgeInsets.only(right: 10),
            //       showDropdownIcon: false,
            //       keyboardType: TextInputType.phone,
            //     ),
            //   ),
            // ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: password,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2196F3)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: black),
                    ),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.black),
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF2196F3),
                    )),
                obscureText: true,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () async {
                  if (username.text.isEmpty ||
                      password.text.isEmpty ||
                      email.text.isEmpty) {
                  } else {
                    if (password.text.length < 6) {
                      showsnackbar(context, "Şifre 6 karakterden küçük olamaz",
                          AnimatedSnackBarType.error);
                    } else {
                      String? res = await _servis.register(
                          username.text, email.text, password.text, phone.text);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => navigator_screen(),
                          ));
                    }
                  }
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.all(0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                    ))),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: const LinearGradient(
                          colors: [Color(0xFF2196F3), Color(0xFF009688)])),
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "SIGN UP",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()))
                },
                child: const Text(
                  "Already Have an Account? Sign in",
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold, color: black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
