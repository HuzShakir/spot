import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot/auth/firebaseauth.dart';
import 'package:spot/pages/root_app.dart';
import 'package:spot/screens/home_screen.dart';
import 'package:spot/screens/register_screen.dart';
import 'package:spot/utils/colors.dart';
import 'package:spot/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var _isLoading = false;
  var comeonbaby = "uhfwuhwefw";

  void loginUser() async {
    log("ehfwef9hwef");
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    print(res);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => RootApp()
          ),
          (route) => false);

      setState(() {
        _isLoading = false;
        comeonbaby = res;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      // showSnackBar(context, res);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 120),
          Text(_isLoading ? comeonbaby : "Nathi chaltu"),
          SvgPicture.asset('assets/spotify-1.svg', height: 55),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          TextFieldInput(
              hintText: "Enter your email",
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress),
          const SizedBox(height: 25),
          TextFieldInput(
              hintText: "Enter your password",
              isbool: true,
              textEditingController: _passwordController,
              textInputType: TextInputType.visiblePassword),
          const SizedBox(height: 25),
          InkWell(
            onTap: () => loginUser(),
            child: Container(
              child: Text("Log In"),
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                  color: Color.fromRGBO(30, 215, 96, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            child: Container(),
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Text("Don't have an account?"),
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
              GestureDetector(
                  onTap: () {
                    print("tdtdydtt4ttet friends welcome to my youtube channel have ziye register par");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterScreen()));
                  },
                  child: Container(
                    child: Text("Sign Up.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                    padding: EdgeInsets.symmetric(vertical: 8),
                  ))
            ],
          )
        ],
      ),
    )));
  }
}
