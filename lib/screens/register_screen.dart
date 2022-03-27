import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot/auth/firebaseauth.dart';
import 'package:spot/pages/root_app.dart';
import 'package:spot/screens/home_screen.dart';
import 'package:spot/screens/login_screen.dart';
import 'package:spot/utils/colors.dart';
import 'package:spot/widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  var checkstatus = "";
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void registerUser() async {
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text);
    if (res == "success") {
       Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => RootApp(),
          ),
        
      );
    }
    
    setState(() {
      checkstatus = res;
    });
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
          Text(checkstatus),
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
              hintText: "Enter your Username",
              textEditingController: _usernameController,
              textInputType: TextInputType.text),
          const SizedBox(height: 25),
          TextFieldInput(
              hintText: "Enter your password",
              isbool: true,
              textEditingController: _passwordController,
              textInputType: TextInputType.visiblePassword),
          const SizedBox(height: 25),
          InkWell(
            child: Container(
              child: Text("Register"),
              width: double.infinity,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                  color: Color.fromRGBO(30, 215, 96, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )),
            ),
            onTap: () => {registerUser()},
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
                child: Text("Already have an account?"),
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
              GestureDetector(
                  onTap: () {
                    print("Have login screen par pacho zai se");
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Container(
                    child: Text("Log in.",
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
