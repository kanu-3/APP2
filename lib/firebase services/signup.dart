import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task2/firebase%20services/login.dart';
import 'package:task2/util/util.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool loading=false;
  final formkey= GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  final _auth=FirebaseAuth.instance;

  @override
  void dispose(){
    super.dispose();
    emailcontroller.dispose();
    passwordController.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/bgimage1.jpg"),fit: BoxFit.cover),
          ),
          child: Center(
            
            child: Container(
              height: 600,width: 450,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Padding(
                  padding: const EdgeInsets.only(right:10.0,left:100),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: CircleAvatar(
                          radius: 40,
                          child: Icon(Icons.person_add,size: 50,),
                        ),
                      ),
                      Text("Sign up",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600),),
                    ],
                  ),
                ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                      key: formkey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                      controller: emailcontroller,
                      decoration: InputDecoration(
                        hintText: "Email",
                        helperText: "enter email: eg:kanu@gmail.com",
                        prefixIcon: Icon(Icons.email)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "email required";
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                              if (!emailRegex.hasMatch(value)) {
                                return "Enter a valid email address";
                              }
                        return null;
                      },
                    ),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: passwordController,
                      obscureText:true,
                      decoration: InputDecoration(
                        hintText: "Password",
                        helperText: "ensure the password is strong",
                        prefixIcon: Icon(Icons.lock_outline)
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "password required";
                        }
                        return null;
                      },
                    ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(onPressed: (){
                      if (formkey.currentState!.validate()){

                        setState(() {
                          loading = true;
                        });
                            _auth.createUserWithEmailAndPassword(
                              email: emailcontroller.text.toString(), 
                              password: passwordController.text.toString()).then((value){
                                setState(() {
                                 loading = false;
                                });
                                Util().toastMessage("Registration successful");
                              }).onError((error, stackTrace){
                                setState(() {
                                 loading = false;
                                });
                                  Util().toastMessage("Error: ${error.toString()}");
                              });
                      }
                    }, child: loading ? CircularProgressIndicator() : Text("Sign Up"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
                    
                        }, child: Text("Login"))
                      ],
                    ),
                  )
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}