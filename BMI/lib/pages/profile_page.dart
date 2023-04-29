import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Profile'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 8.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.person_outline_rounded),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(NameConst.value),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              height: 8.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.person_outline_rounded),
                    SizedBox(
                      width: 2.w,
                    ),
                    Text(EmailConst.value),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(child: Text("History of BMI")),
            Container(
                height: 40.h,
                child: StreamBuilder<QuerySnapshot>(
                  stream: _fireStore
                      .collection('users')
                      .doc(userDocId.value)
                      .collection('results')
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.all(10),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> bmiData =
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(bmiData['bmi']),
                                    Text(bmiData['result']),
                                  ],
                                ),
                              ),
                            );
                          });
                    } else
                      return SizedBox.shrink();
                  },
                )),
          ],
        ),
      ),
    );
  }
}
