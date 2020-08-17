import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:async/async.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:math';

void main() {
  runApp(otpLogin());
}

class otpLogin extends StatefulWidget {
  @override
  _otpLoginState createState() => _otpLoginState();
}

class _otpLoginState extends State<otpLogin> {
  String moboNo;

  String mobUrl =
      "https://2factor.in/API/V1/b5153269-aaf0-11ea-9fa5-0200cd936042/SMS/+91";

  int otp;

  int enteredOtp;

  String status="";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Login With Auth",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: kTextFieldDecoration.copyWith(
                    hintText: "Enter Your Phone number here"),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  moboNo = value;
                },
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                color: Colors.blue,
                child: Text("Generate OTP"),
                onPressed: () async {
                  otp = (new Random().nextDouble()*9000+1000).toInt();

                  print(otp);
                  await http.get("$mobUrl$moboNo/$otp/");
                  //print();
                },
              ),
              TextField(
                decoration: kTextFieldDecoration.copyWith(
                    hintText: "Enter Your OTP here"),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  enteredOtp = int.parse(value);
                },
              ),
              FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  color: Colors.blue,
                  child: Text("Verify OTP"),
                  onPressed: () {
                    setState(() {
                      if(enteredOtp==otp){
                         status="Login Successful";
                      }
                      else{
                        status="Login Failed! Please Retry";
                      }
                    });
                  }),
              Text(
                "$status"
              )
            ],
          ),
        ),
      ),
    );
  }
}

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(color: Colors.black),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(borderSide: BorderSide()
      //borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
