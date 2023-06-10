import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:data_entry/FormPage.dart';
import 'package:data_entry/utilities/constants.dart';

import 'LoginPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final conformPaswordController = TextEditingController();

  Widget _buildNameTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Name',
          style: kLabelStyle,
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextField(
            controller: nameController,
            keyboardType: TextInputType.name,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintText: 'Enter Your Name',
                hintStyle: kHintTextStyle
            ),
          ),
        )
      ],
    );
  }
  Widget _buildEmailTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextFormField(
            controller: emailController,
            validator: (value){
              if(value == null || value.isEmpty){
                Fluttertoast.showToast(
                    msg: "Enter The Name",
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.red
                );
              }
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                hintText: 'Enter Your Email',
                hintStyle: kHintTextStyle
            ),
          ),
        )
      ],
    );
  }
  Widget _buildPasswordTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextFormField(
            controller: passwordController,
            validator: (value){
              if(value == null || value.isEmpty){
                Fluttertoast.showToast(
                    msg: "Enter The Email",
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.red
                );
              }
            },
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: 'Enter Your Password',
                hintStyle: kHintTextStyle
            ),
          ),
        )
      ],
    );
  }
  Widget _buildConformPasswordTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Conform Password',
          style: kLabelStyle,
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextFormField(
            controller: conformPaswordController,
            validator: (value){
              if(value == null || value.isEmpty){
                Fluttertoast.showToast(
                    msg: "Enter The Conform Password",
                    textColor: Colors.white,
                    toastLength: Toast.LENGTH_SHORT,
                    backgroundColor: Colors.red
                );
              }
            },
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                hintText: 'Enter Your Conform Password',
                hintStyle: kHintTextStyle
            ),
          ),
        )
      ],
    );
  }
  Widget _buildSignUpnBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white
        ),
        onPressed: () {
          final bool isValid = EmailValidator.validate(emailController.text.trim());
          if(!isValid){
            Fluttertoast.showToast(
                msg: "Pleace check the emial",
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 2
            );
          }
          if(passwordController.text == conformPaswordController.text){
            FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text).then((value){
              Fluttertoast.showToast(
                  msg: "Account Created",
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_LONG,
                  timeInSecForIosWeb: 2
              );
              Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage()));
            }).onError((error, stackTrace){
              print("Error ${error.toString()}");
              Fluttertoast.showToast(
                  msg: "${error.toString()}",
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_LONG,
                  timeInSecForIosWeb: 2,
                  gravity: ToastGravity.BOTTOM
              );
            });
          }else{
            Fluttertoast.showToast(
                msg: "Invalid Password",
                backgroundColor: Colors.red,
                textColor: Colors.white,
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 2
            );
          }


        },


        child: Text(
          'SIGNUP',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  Widget _buildLoginBtn() {
    return GestureDetector(
      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()  ))},
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Already have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap:() => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget> [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF73AEF5),
                        Color(0xFF61A4F1),
                        Color(0xFF478DE0),
                        Color(0xFF398AE5),
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    )
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 80
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget> [
                      Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),),
                      SizedBox(height: 30,),
                      _buildNameTF(),
                      SizedBox(height: 30,),
                      _buildEmailTF(),
                      SizedBox(height: 30,),
                      _buildPasswordTF(),
                      SizedBox(height: 30,),
                      _buildConformPasswordTF(),
                      SizedBox(height: 30,),
                      _buildSignUpnBtn(),
                      SizedBox(height: 30,),
                      _buildLoginBtn(),
                    ],
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
