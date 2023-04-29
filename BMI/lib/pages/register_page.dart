import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';
import 'login_page.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController =
      TextEditingController();
  final GlobalKey<FormState> signInFormField = GlobalKey();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool loader = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
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
                    "Create your account by filling in the information below to access the application",
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
                    controller: nameTextController,
                    validator: (val) =>
                        val!.isEmpty ? "enter a valid username" : null,
                    cursorColor: Colors.grey,
                    style: TextStyle(fontSize: 20.0, color: kinactiveCardColor),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      hintText: "Enter your name...",
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
                    controller: emailTextController,
                    validator: (val) => val!.isEmpty || !val.contains("@")
                        ? "enter a valid email"
                        : null,
                    style: TextStyle(fontSize: 20.0, color: kinactiveCardColor),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      hintText: "Enter your emial...",
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
                        return 'Must be more than 6 charater';
                      }
                      ;
                    },
                    obscureText: !_passwordVisible,
                    style: TextStyle(fontSize: 20.0, color: kinactiveCardColor),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      hintText: "Please enter your password...",
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
                    controller: confirmPasswordTextController,
                    validator: (val) {
                      if (val!.isEmpty) return 'Please enter valid password';
                      if (val != passwordTextController.text)
                        return 'Password mismatch';
                      return null;
                    },
                    obscureText: !_confirmPasswordVisible,
                    style: TextStyle(fontSize: 20.0, color: kinactiveCardColor),
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                      hintText: "Please confirm your password...",
                      hintStyle:
                          TextStyle(fontSize: 20.0, color: kinactiveCardColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _confirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _confirmPasswordVisible = !_confirmPasswordVisible;
                          });
                        },
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
                        await registerUser(
                            emailTextController.text,
                            passwordTextController.text,
                            nameTextController.text);
                      }
                    },
                    child: loader
                        ? Center(
                            child: CircularProgressIndicator(
                            color: Colors.grey,
                          ))
                        : Text(
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

  registerUser(emails, pass, name) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: emails, password: pass);
      await FirebaseAuth.instance.currentUser?.updateDisplayName(name);
      FirebaseFirestore.instance.collection('users').doc(user.user!.uid).set({
        'email': emails,
        'displayName': name,
        'id': user.user!.uid,
      });
      setState(() {
        loader = false;
      });

      // return AwesomeDialog(
      //   context: context,
      //   dialogType: DialogType.success,
      //   desc: 'Successfully registered,\n Please Log in ',
      //   btnOkOnPress: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
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
