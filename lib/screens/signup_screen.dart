import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/login_screen.dart';
import 'package:flutter_task/utility/flutter_toast.dart';
import 'package:flutter_task/widgets/custom_appbar.dart';
import 'package:flutter_task/widgets/custom_button.dart';
import 'package:flutter_task/widgets/custom_textfield.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:ndialog/ndialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
    final  namecontroller = TextEditingController();
  final  emailcontroller = TextEditingController();

  final  passwordcontroller = TextEditingController();
  final  confirmpasswordcontroller =  TextEditingController();
  String? selectedGender;
  String Gender = "Male";
  var _formkey = GlobalKey<FormState>();
  bool rememeberMe = false;
  bool _isvisiblity = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          
        centerTitle: true,
        backgroundColor: Colors.pink,
        title: const Text("SignUp screen",
        style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(

          left: 20, right: 30, top: 20,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomeTextField(
                  
                  controller: namecontroller,
                   hinttext: "userName", icons: Icons.person,
                
                  validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter some text";
                            }
                            return null;
                          },),
              ),
            
               Padding(
                 padding: const EdgeInsets.only(bottom: 20),
                 child: CustomeTextField(controller: emailcontroller, hinttext: "Email", icons: Icons.email,
                               
                  validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "please Enter some text";
                            }
                            return null;
                          },),
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
            
                      const Gap(20),
                     
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Enter a Password";
                          }
                          return null;
                        },
                        controller: confirmpasswordcontroller,
                        
                        obscureText: _isvisiblity,
                      
                        decoration: InputDecoration(
                            hintText: " Confirm Password",
                            labelText: " Confirm Password",
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
                      const Gap(20),
                      CustomeButton(
                        manisize: const Size(200, 57),
                        onpressed: ()async{

                                       if (!_formkey.currentState!.validate()) {
                      return;
                    }
                   
                  // signupProvider.isLoading = true; 
                  // await signupProvider.signup(
                  //   signupProvider.name,
                  //   signupProvider.email,
                  //   signupProvider.password,
                  // );

                    String Name = namecontroller.text.trim();
                    String Email = emailcontroller.text.trim();
                    String Password = passwordcontroller.text.trim();
                    String Confirmpassword =
                        confirmpasswordcontroller.text.trim();

                    if (Name.isEmpty ||
                        Email.isEmpty ||
                        Password.isEmpty ||
                        Confirmpassword.isEmpty) {
                      Utils.toastmessage(
                          "Please all the fields", Colors.indigo);
                      return;
                    }
                   
                    if (Password.length < 8) {
                      Utils.toastmessage(
                          "please enter your password at least 8 characters",
                          Colors.redAccent);
                      return;
                    }
                    if (Password != Confirmpassword) {
                      Utils.toastmessage("Password do not match", Colors.red);
                      return;
                    }
                    if( !EmailValidator.validate(Email)){
                        Fluttertoast.showToast(msg: 'Invalid Email Address', backgroundColor: Colors.red, gravity: ToastGravity.CENTER);
                        return;
                      }

                    ProgressDialog progressDialog = ProgressDialog(context,
                        title: const Text("Signing up"),
                        message: const Text("Please provide"));
                    progressDialog.show();
                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      UserCredential? userCredential =
                          await auth.createUserWithEmailAndPassword(
                              email: Email, password: Password);
                      if (userCredential.user != null) {
                        FirebaseFirestore firebaseFirestore =
                            FirebaseFirestore.instance;
                        await firebaseFirestore
                            .collection("users")
                            .doc(userCredential.user!.uid)
                            .set({
                          "Name": Name,
                          "Email": Email,
                          // "Phone": Phone,
                          
                          "Password": Password,
                          "Confirmpassword": Confirmpassword,
                          "uid": userCredential.user!.uid,
                          "CreatedOn": DateTime.now().microsecondsSinceEpoch
                        });
                      
                        if (_formkey.currentState!.validate())
                          int createdOn = DateTime.now().microsecondsSinceEpoch;
                        Utils.toastmessage("Succesful", Colors.purple);
                      

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      } else {
                        progressDialog.dismiss();
                        Utils.toastmessage("Failed", Colors.red);
                      }
                    } on FirebaseAuthException catch (e) {
                      progressDialog.dismiss();
                   
                      if (e.code == "Email is already use in") {
                        Utils.toastmessage(
                            "Email is already- user", Colors.deepPurple);
                      } else {
                        if (e.code == "weak password") {
                          Utils.toastmessage("Weak Password", Colors.red);
                        }
                      }
                    } catch (e) {
                      progressDialog.dismiss();
                      Utils.toastmessage("Something Went wrong", Colors.red);
                    }

                        },
                       text: "Sign Up", colors: Colors.red),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account ?"),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                              },
                              child: const Text(
                                "Login in",
                                style: TextStyle(fontSize: 15, color: Colors.indigo),
                              )),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
      
    );
  }
}