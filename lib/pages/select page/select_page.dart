import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupchat/ChatBot/chat_bot.dart';
import 'package:groupchat/Food%20Donation/food_donation.dart';
import 'package:groupchat/Government/home_page.dart';
import 'package:groupchat/helper/helper_function.dart';
import 'package:groupchat/item%20donation/home_item_donation.dart';
import 'package:groupchat/library/app.dart';
import 'package:groupchat/pages/auth/login_page.dart';
import 'package:groupchat/pages/home_page.dart';
import 'package:groupchat/pages/profile_page.dart';
import 'package:groupchat/services/auth_service.dart';
import 'package:groupchat/services/data_base_service.dart';
import 'package:groupchat/widgets/widgets.dart';

import '../../gadget donation/home_donate.dart';

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  @override

// fetching the user data from firebase
  String userName = "";
  String email = "";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // string manipulation
  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
    // getting the list of snapshots in our stream
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        
        title: const Padding(
          padding:  EdgeInsets.only(left: 51),
          child:  Text(
            "NAMASTE",
            style: TextStyle(
                color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            Icon(
              Icons.account_circle,
              size: 150,
              color: Colors.grey[700],
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              userName,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 2,
            ),
            
            ListTile(
              onTap: () {
                nextScreenReplace(
                    context,
                    ProfilePage(
                      userName: userName,
                      email: email,
                    ));
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.group),
              title: const Text(
                "Profile",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListTile(
              onTap: () async {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              await authService.signOut();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false);
                            },
                            icon: const Icon(
                              Icons.done,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      );
                    });
              },
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              leading: const Icon(Icons.exit_to_app),
              title: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 20.0,
          children: [
            

            
           
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(15)),
                height: 100,
                width: 100,
                child: Column(children: [
                  Image.asset('assets/recieve.png', width: 120, height: 120),
                  const Text(
                    'Donate ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeItem()),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(15)),
                height: 100,
                width: 100,
                child: Column(children: [
                  Image.asset('assets/recieve.png', width: 200, height: 120),
                  const Text(
                    'WishList ',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ]),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(15)),
                height: 100,
                width: 100,
                child: Column(children: [
                  Image.asset('assets/community.jpg', width: 160, height: 120),
                  const Text(
                    'Community',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ]),
              ),
            ),
            
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyApp()),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(15)),
                height: 100,
                width: 100,
                child: Column(children: [
                  Image.asset('assets/library.jpg', width: 200, height: 120),
                  const Text(
                    'E-Library',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FoodDonation()),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(15)),
                height: 100,
                width: 100,
                child: Column(children: [
                  Image.asset('assets/food.jpg', width: 120, height: 120),
                  const Text(
                    'Food Donation',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ]),
              ),
            ),
            
            
            
            
            
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home_page()),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(15)),
                height: 100,
                width: 100,
                child: Column(children: [
                  Image.asset('assets/govt.png', width: 160, height: 120),
                  const Text(
                    'Government Schemes',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ]),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatBot()),
                );
              },
              child: Container(
                padding: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(15)),
                height: 100,
                width: 100,
                child: Column(children: [
                  Image.asset('assets/chatbot.jpg', width: 170, height: 120),
                  const Text(
                    'ChatBot',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ]),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
