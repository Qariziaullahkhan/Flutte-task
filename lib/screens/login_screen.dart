import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/email_verify_screen.dart';
import 'package:flutter_task/screens/forgot_password_screen.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:flutter_task/screens/signup_screen.dart';
import 'package:flutter_task/utility/flutter_toast.dart';
import 'package:flutter_task/widgets/custom_button.dart';
import 'package:flutter_task/widgets/custom_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:ndialog/ndialog.dart';
import 'package:sign_button/create_button.dart';
import 'package:sign_button/sign_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool rememeberMe =false;
  var _formky = GlobalKey<FormState>();
  bool _isvisiblity = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: const Text("Logins screen",
        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
          child: Form(
            key: _formky,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomeTextField(
                  controller: emailcontroller,
                  hinttext: "Enter Your Email",
                  labletext: "Email",
                  icons: Icons.person,
          
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please Enter some text";
                    }
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(emailcontroller.text);
                    if (!emailValid) {
                      return "Please enter Vaild email";
                    }
                    return null;
                  },
                ),
                 
               
               TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter a Password";
                      }
                      return null;
                    },
                    controller: passwordcontroller,
                    obscureText: _isvisiblity,
                    
                    decoration: InputDecoration(
                        hintText: "Password",
                        labelText: "Password",
                        filled: true,
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isvisiblity = !_isvisiblity;
                              });
                            },
                            icon: _isvisiblity
                                ? const Icon(
                                    Icons.visibility,
                                    color: Colors.black,
                                  )
                                : const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  )),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                                   
                  ),
               const   Gap(20),
               CustomeButton(
                manisize: const Size(200, 57),
                onpressed: ()async{
                    String Email = emailcontroller.text.trim();
                    String Password = passwordcontroller.text.trim();

                    if (Email.isEmpty || Password.isEmpty) {
                      Utils.toastmessage(
                          "Please all the fields", Colors.indigo);
                      //show error toast
                      return;
                    }
                    if (Password.length < 8) {
                      Utils.toastmessage(
                          "password length is less than 8", Colors.red);
                      // show error taost
                      return;
                    }
                    ProgressDialog progressDialog = ProgressDialog(context,
                        title: const Text("Logging in up"),
                        message: const Text("please provide"));
                    progressDialog.show();

                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      UserCredential? userCredential =
                          await auth.signInWithEmailAndPassword(
                              email: Email, password: Password);
                      if (userCredential.user!.emailVerified) {
                        progressDialog.dismiss();

                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                          return const HomeScreen();
                        }));
                      } else {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return const EmailVerficationScreen();
                        }));
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        Utils.toastmessage("user not found", Colors.red);
                        Fluttertoast.showToast(
                            msg: "user not found", fontSize: 30);
                      } else {
                        if (e.code == "email-already-in-use") {
                          Fluttertoast.showToast(
                              msg: "${e.message} ", fontSize: 30);
                         Utils.toastmessage("Email already in use",Colors.red);
                        }
                      }
                    } catch (e) {
                      progressDialog.dismiss();
                      Utils.toastmessage("wrong password", Colors.red);
                     // Fluttertoast.showToast(msg: "wrong password");
                    }
                }, text: "Login ", colors: Colors.red),
                 const Gap(20),
            
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: rememeberMe,
                          onChanged: (value) {
                            setState(() {
                              rememeberMe = value!;
                            });
                          },
                        ),
                        const Text(
                          'Remember me ',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.normal),
                        ),
                        const Gap(5),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ForgotPasswordScreen()));
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style:
                                      TextStyle(fontSize: 15, color: Colors.lightBlueAccent),
                                )),
                          ),
                        ),
                      ],
                    ),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Dont't have an account ?"),
                        TextButton(onPressed: (){
        
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return const SignupScreen();
                          }));
                        }, 
                        child: const Text("Sign up",
                        style: TextStyle(fontSize: 15,color: Colors.blue),))
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: SignInButton(
                              buttonType: ButtonType.google, 
                          
                            onPressed: (){
                          
                            }),
                          ),
                        )
                      ],
                    )
              ],
              
              
            ),
            
          ),
        ),
      ),
      
    );
  }
}