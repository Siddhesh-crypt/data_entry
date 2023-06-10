import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'ViewPage.dart';
import 'utilities/constants.dart';
import 'information.dart';


class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();

  List<info> infoList = [];

  DatabaseReference dbref = FirebaseDatabase.instance.ref();

  Widget _buildIdTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('ID',
          style: kLabelStyle,
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextFormField(
            controller: idController,
            keyboardType: TextInputType.number,
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
                hintText: 'Enter Your Id',
                hintStyle: kHintTextStyle
            ),
          ),
        )
      ],
    );
  }
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
          child: TextFormField(
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
  Widget _buildAddressTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Address',
          style: kLabelStyle,
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextFormField(
            controller: addressController,
            keyboardType: TextInputType.streetAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                hintText: 'Enter Your Address',
                hintStyle: kHintTextStyle
            ),
          ),
        )
      ],
    );
  }
  Widget _buildAgeTF(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Age',
          style: kLabelStyle,
        ),
        SizedBox(height: 10,),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60,
          child: TextFormField(
            controller: ageController,
            keyboardType: TextInputType.number,
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
          if(idController.text.isNotEmpty && nameController.text.isNotEmpty &&
              addressController.text.isNotEmpty && ageController.text.isNotEmpty
          ){
            insertData(
              idController.text,
              nameController.text,
              addressController.text,
              ageController.text
            );

            Fluttertoast.showToast(
                msg: 'Insert Data Successfully',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16
            );

            idController.clear();
            nameController.clear();
            addressController.clear();
            ageController.clear();

          }else{
            Fluttertoast.showToast(
                msg: 'Fill the Complete Data',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16
            );
          }
        },


        child: Text(
          'INSERT DATA',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF73AEF5),
        title: Text("Data Entry", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30
        ),),
        centerTitle: false,
        actions: <Widget>[
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPage()));
          }, icon: Icon(Icons.keyboard_arrow_right_sharp, color: Colors.white, size: 50,))
        ],
      ),
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
                      vertical: 50
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget> [
                      _buildIdTF(),
                      SizedBox(height: 30,),
                      _buildNameTF(),
                      SizedBox(height: 30,),
                      _buildAddressTF(),
                      SizedBox(height: 30,),
                      _buildAgeTF(),
                      SizedBox(height: 30,),
                      _buildSignUpnBtn(),
                      SizedBox(height: 30,),

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

  void insertData(String id, String name, String address, String age){
    dbref.child("Information").push().set({
      "id": id,
      "name": name,
      "address": address,
      "age": age
    });
  }
}
