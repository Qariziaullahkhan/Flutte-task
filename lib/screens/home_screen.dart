import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/login_screen.dart';
import 'package:flutter_task/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      
           drawer:const CustomDrawer(),
//
       appBar:  AppBar(
        centerTitle: true,
          backgroundColor: Colors.red,
        title: const Text("Home screen",
        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
        ),
          
         actions: [
          
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Confirmation'),
                        content: const Text('Are you sure to Logout ?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('No')),
                          TextButton(
                              onPressed: () async {
                                Navigator.pop(context);

                                await FirebaseAuth.instance.signOut();

                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return const LoginScreen();
                                }));
                              },
                              child: const Text('Yes')),
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              )),
        ],
       
        
        
      ),
       floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.blue,
        onPressed: (){
             showDialog(context: context, builder: (context){
            return AlertDialog(
                title: const Text('Confirmation'),
                        content:  const Text('Are you sure to Logout ?'),
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
        label: const Text("Log out",style: TextStyle(color: Colors.white),),
      ),
    );
  }
}