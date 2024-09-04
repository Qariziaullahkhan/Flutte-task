import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:flutter_task/screens/login_screen.dart';
import 'package:gap/gap.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
backgroundColor: Colors.white,
child: ListView(
  children: [
    DrawerHeader(
       padding: EdgeInsets.zero,
      child: Container(
        color: Theme.of(context).primaryColor,
         padding: const EdgeInsets.only(left: 20),

        child:  Column(
 mainAxisAlignment: MainAxisAlignment.center,
  crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const  CircleAvatar(
            radius: 50,
              backgroundImage: AssetImage("assets/images/zia.jpg"),
            ),
            Gap(10),
            Text(FirebaseAuth.instance.currentUser!.email!,style:const TextStyle(color: Colors.white),)
          ],
        ),

    ),
    ),
    ListTile(
        leading: const Icon(Icons.home),
        
        title: Text("Home"),
        onTap: () {
          Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                  return const HomeScreen();
                                }));
        },
       ),
         ListTile(
        leading: const Icon(Icons.person),
        title: Text("Profile"),
        onTap: () {
          //  Navigator.of(context).push(
          //                           MaterialPageRoute(builder: (context) {
          //                         return const Profile_Screen();
          //                       }));
        
        },
       ),
       ListTile(
        leading: const Icon(Icons.logout),
        title: Text("Log Out"),
        onTap: () {
           showDialog(context: context, builder: (context){
            return AlertDialog(
                title:  Text('Confirmation'),
                        content:  Text('Are you sure to Logout ?'),
                        actions: [
                          TextButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: const Text("No")),
                               TextButton(
                              onPressed: () async {
                                Navigator.pop(context);

                                await FirebaseAuth.instance.signOut();

                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginScreen();
                                }));
                              },
                              child: const Text('Yes')),

                        ],
            );
          });
              
        },
       ),
        ListTile(
        leading: const Icon(Icons.settings),
        title: Text("Settings"),
        onTap: () {
          Navigator.of(context);
        },
       ),
  ],
),
    );
  }
}