import 'package:flutter/material.dart';
import 'package:warehouse_selective/constants/constants.dart';
import 'package:warehouse_selective/services/auth_service.dart';

import '../../components/background.dart';
import '../register/register.dart';

class Forgot_Pass_Screen extends StatefulWidget {
  const Forgot_Pass_Screen({super.key});

  @override
  State<Forgot_Pass_Screen> createState() => _Forgot_Pass_ScreenState();
}

class _Forgot_Pass_ScreenState extends State<Forgot_Pass_Screen> {
  auth_services _servis = auth_services();
  TextEditingController _mail = TextEditingController();
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
              child: Text(
                "Reset Password",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: orange, fontSize: 36),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: _mail,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: orange),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: black),
                    ),
                    labelText: "E-mail",
                    labelStyle: TextStyle(color: Colors.black),
                    suffixIcon: Icon(
                      Icons.mail,
                      color: orange,
                    )),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  _servis.ResetPassword(_mail.text);
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
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      gradient: new LinearGradient(
                          colors: [Color.fromARGB(255, 255, 136, 34), yellow])),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Reset",
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
                      MaterialPageRoute(builder: (context) => RegisterScreen()))
                },
                child: Text(
                  "Don't Have an Account? Sign up",
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
