import 'package:bmi_calculator/pages/profile_page.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'input_page.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({
    Key? key,
  }) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  // getData() {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userDocId.value)
  //       .get()
  //       .then((value) async {
  //     setState(() {
  //       EmailConst.value = value.data()!['email'];
  //       NameConst.value = value.data()!['displayName'];
  //       profileUrlConst.value = value.data()!['imageUrl'];
  //     });
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //  getData();
  }

  @override
  int _selectedIndex = 0;
  static final List<Widget> _pages = <Widget>[
    InputPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.0),
              spreadRadius: 5,
              blurRadius: 2,
              // offset: Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: kbottomContainerColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.home,
                      color: _selectedIndex == 0
                          ? Color(0xFFd2fafb)
                          : kinactiveCardColor),
                  Text("Home",
                      style: TextStyle(
                          fontFamily: 'FredokaOne',
                          fontSize: 20.0,
                          color: _selectedIndex == 0
                              ? Color(0xFFd2fafb)
                              : kinactiveCardColor)),
                ],
              ),
              label: ("home"),
            ),
            BottomNavigationBarItem(
              icon: Column(
                children: [
                  Icon(Icons.person,
                      color: _selectedIndex == 1
                          ? Color(0xFFd2fafb)
                          : kinactiveCardColor),
                  Text("Profile",
                      style: TextStyle(
                          fontFamily: 'FredokaOne',
                          fontSize: 20.0,
                          color: _selectedIndex == 1
                              ? Color(0xFFd2fafb)
                              : kinactiveCardColor)),
                ],
              ),
              label: ("profile"),
            ),
          ],
          onTap: onItemTapped,
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
