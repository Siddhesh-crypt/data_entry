import 'package:data_entry/ForgotPasswordPage.dart';
import 'package:data_entry/ViewPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:data_entry/utilities/constants.dart';
import 'SignUpPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _rememberMe = false;
  bool passToggle = true;
  final _formField = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _buildEmailTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextFormField(
            controller: emailController,
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
                hintStyle: kHintTextStyle),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter Email";
              }

              bool emailValid = RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~] + @[a-zA-Z0-9] +\.[a-zA-z] +")
                  .hasMatch(value);
              if (!emailValid) {
                return "Enter Valid Email";
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextFormField(
            controller: passwordController,
            obscureText: passToggle,
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
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      passToggle = !passToggle;
                    });
                  },
                  child: Icon(
                    passToggle ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white,
                  ),
                ),
                hintText: 'Enter Your Password',
                hintStyle: kHintTextStyle),
            validator: (value) {
              if (value!.isEmpty) {
                return "Enter the Password";
              } else if (passwordController.text.length < 6) {
                return "Password Should be not less than 6 character";
              }
            },
          ),
        )
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()));
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: Text(
            "Forgot Password?",
            style: kLabelStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
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
          }else{
            FirebaseAuth.instance.signInWithEmailAndPassword(
                email: emailController.text,
                password: passwordController.text).then((value) => {
              Fluttertoast.showToast(
                  msg: "You are Sign In",
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  toastLength: Toast.LENGTH_LONG,
                  timeInSecForIosWeb: 2
              ),
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPage()))
            });
          }
        },
        child: Text(
          'LOGIN',
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

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()))
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
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
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
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
                )),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 140),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      _buildEmailTF(),
                      SizedBox(
                        height: 30,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(),
                      _buildRememberMeCheckbox(),
                      _buildLoginBtn(),
                      SizedBox(
                        height: 30,
                      ),
                      _buildSignupBtn()
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
