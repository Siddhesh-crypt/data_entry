
import 'package:data_entry/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:data_entry/FormPage.dart';
import 'package:fluttertoast/fluttertoast.dart';


import 'information.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key});

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {

  List<info> infoList = [];

  final idController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final ageController = TextEditingController();

  DatabaseReference dbref = FirebaseDatabase.instance.ref();
  DatabaseReference del = FirebaseDatabase.instance.ref().child("Information");

  @override
  void initState(){
    super.initState();

    retriveInfodata();
  }

  void SignOut(){
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF73AEF5),
        title: const Text("View Data", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),),
        centerTitle: true,
        actions: <Widget>[
          IconButton(onPressed: (){
            SignOut();
          }, icon: Icon(Icons.settings_power, color: Colors.white, size: 30,))
        ],
        leading: IconButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage()));
        }, icon: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 30,),),
      ),
      body: SafeArea(
        child: Container(
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                for(int i = 0; i < infoList.length; i++)
                  infoWidget(infoList[i])
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => FormPage()));
        },
        backgroundColor: Colors.white,
        foregroundColor: Color(0xFF398AE5),
        child: Icon(Icons.add, size: 40,),
        elevation: 5,
        focusElevation: 10,
      ),
    );
  }

  void retriveInfodata() {
    dbref.child("Information").onChildAdded.listen((data) {
      InfoData infoData = InfoData.fromJson(data.snapshot.value as Map);
      info Info = info(key: data.snapshot.key, infoData: infoData);
      infoList.add(Info);
      setState(() {});
    });
  }

  Widget infoWidget(info infoList) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
      decoration: BoxDecoration(

        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade500,width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Id", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade700
              ),),
              Text("Name", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade700
              ),),
              Text("Address", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade700
              ),),
              Text("Age", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade700
              ),),
              FilledButton.tonalIcon(onPressed: (){
                Navigator.pop(context);
                String id = infoList.infoData!.id!.toString();
                String name = infoList.infoData!.name!.toString();
                String address = infoList.infoData!.address!.toString();
                String age = infoList.infoData!.age!.toString();
                showMyDilog(id, name, address, age);
              }, icon: Icon(Icons.upload_file), label: Text("Update"))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(""),
              Text("------>", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white
              ),),
              Text("------>", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                    color: Colors.white
              ),),
              Text("------>", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white
              ),),
              Text("------>", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white
              ),),
              Text("------>", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white,fontSize: 20),)
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(infoList.infoData!.id!, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade700
              ),),
              Text(infoList.infoData!.name!, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade700
              ),),
              Text(infoList.infoData!.address!, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade700
              ),),
              Text(infoList.infoData!.age!, style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.grey.shade700
              ),),
              FilledButton.tonalIcon(onPressed: (){
                dbref.child("Information").child(infoList.key!).remove();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPage()));
              }, icon: Icon(Icons.delete), label: Text("Delete"))
            ],
          ),
        ],
      ),
    );
  }

  Future<void> showMyDilog(String id, String name, String address, String age) async{
    idController.text = id;
    nameController.text = name;
    addressController.text = address;
    ageController.text = age;
    return showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        title: Text("Update Data"),
        content: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: idController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "id",
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "name",
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "address",
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(

                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: "age",
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("Cancle")),
          TextButton(onPressed: (){
            Navigator.pop(context);
            dbref.child("Information").child(idController.text).update({
              "id": idController.text.toLowerCase(),
              "name": nameController.text.toLowerCase(),
              "address": addressController.text.toLowerCase(),
              "age": ageController.text.toLowerCase()
            }).then((value) => null);
          }, child: Text("update"))
        ],
      );
    });
  }
}
