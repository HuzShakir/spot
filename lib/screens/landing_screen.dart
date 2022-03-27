import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spot/widgets/text_field.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
    SingleChildScrollView(
      child: Column(
        children:[
      Container(
        height: MediaQuery.of(context).size.height*0.35,
        child: 
      
      Stack(
        children: [
          Container(
            // height: 650,
        decoration: const BoxDecoration(
            image:DecorationImage(image:AssetImage("assets/landing.png"),fit: BoxFit.cover),
        )
      ),
        Container(
            // height: 650,
          decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.center,
            end:
                Alignment.bottomCenter, // 10% of the width, so there are ten blinds.
            colors: <Color>[
              Colors.transparent,
              Colors.black
            ], 
          )
        )
        )
        ],
      ),
      ),
      
      Container(
        
        child: 
        Padding(
          padding: EdgeInsets.all(20),
          
          child: Column(
          children: [
              SvgPicture.asset('assets/spotify-1.svg', height: 55),
            const SizedBox(height: 80),
              // Flexible(
              //   child: Container(),
              //   flex: 1,
              // ),
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
                onTap: () => {},
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
              // Flexible(
              //   child: Container(),
              //   flex: 1,
              // ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text("Don't have an account?"),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    GestureDetector(
                        child: Container(
                      child: Text("Sign Up.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ))
                  ],
                ),
              )
        
          ],
            ),
        ),
        ),
    
    
    
    
    
        ],
      ),
    );
  }
}
