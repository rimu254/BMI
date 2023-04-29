import 'package:bmi_calculator/pages/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';
import 'bottom_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  final GlobalKey<FormState> signInFormField = GlobalKey();
  bool _passwordVisible = false;
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Login ",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kinactiveCardColor,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Form(
        key: signInFormField,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 70.w,
                  child: Text(
                    "Enter your account details to access the application",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 2.h),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.4)
                      ]),
                  child: TextFormField(
                    controller: emailTextController,
                    validator: (val) => val!.isEmpty || !val.contains("@")
                        ? "enter a valid email"
                        : null,
                    cursorColor: Colors.grey,
                    style: TextStyle(fontSize: 20.0, color: kinactiveCardColor),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      hintText: "Enter your email...",
                      hintStyle:
                          TextStyle(fontSize: 20.0, color: kinactiveCardColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.4)
                      ]),
                  child: TextFormField(
                    controller: passwordTextController,
                    validator: (value) {
                      // add your custom validation here.
                      if (value!.isEmpty) {
                        return 'Please enter valid password';
                      }
                      if (value.length < 6) {
                        return 'Must be more than 6 charaters';
                      }
                      ;
                    },
                    style: TextStyle(fontSize: 20.0, color: kinactiveCardColor),
                    obscureText: !_passwordVisible,
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      hintText: "Password...",
                      hintStyle:
                          TextStyle(fontSize: 20.0, color: kinactiveCardColor),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  color: kbottomContainerColor,
                  child: MaterialButton(
                    minWidth: 90.w,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      if (signInFormField.currentState!.validate()) {
                        setState(() {
                          loader = true;
                        });

                        await validateUser(emailTextController.text,
                            passwordTextController.text);
                      }
                    },
                    child: loader
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Colors.grey,
                          ))
                        : Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  color: kbottomContainerColor,
                  child: MaterialButton(
                    minWidth: 90.w,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      Get.to(() => SignUpScreen());
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  validateUser(email, password) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      userDocId.value = user.user!.uid;

      FirebaseFirestore.instance
          .collection('users')
          .doc(userDocId.value)
          .get()
          .then((value) async {
        setState(() {
          EmailConst.value = value.data()!['email'];
          NameConst.value = value.data()!['displayName'];
        });

        setState(() {
          loader = false;
        });
        // return AwesomeDialog(
        //   context: context,
        //   dialogType: DialogType.success,
        //   btnOkOnPress: () {
        Get.offAll(() => BottomNavigation());
        //   },
        //   desc: 'Successfully LoggedIn...',
        // ).show();
      });
    } catch (error) {
      setState(() {
        loader = false;
      });

      // return AwesomeDialog(
      //   context: context,
      //   dialogType: DialogType.error,
      //   btnOkOnPress: () {},
      //   desc: '${error.toString().replaceRange(0, 14, '').split(']')[1]}',
      // ).show();
    }
  }
}
