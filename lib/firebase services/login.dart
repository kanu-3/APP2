import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task2/firebase%20services/form.dart';
import 'package:task2/firebase%20services/phone.dart';
import 'package:task2/firebase%20services/signup.dart';
import 'package:task2/util/util.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey= GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordController = TextEditingController();
  final _auth=FirebaseAuth.instance;
  bool loading = false;

  @override
  void dispose(){
    super.dispose();
    emailcontroller.dispose();
    passwordController.dispose();
  }

  void login() async{
    setState(() {
        loading = true;
    });
    _auth.signInWithEmailAndPassword(email: emailcontroller.text, password: passwordController.text.toString()).then((value){
      Util().toastMessage("Login successful");
      setState(() {
        loading = false;
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Forms()));
    });
    }).onError((error,StackTrace){
      Util().toastMessage(error.toString());
      setState(() {
        loading = false;
    });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          child: Icon(Icons.person,size: 50,),
                        ),
                      ),
                      Text("Login",style: TextStyle(fontSize: 40,fontWeight: FontWeight.w600),),
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
                      prefixIcon: Icon(Icons.email)
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return "email required";
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
                      FocusScope.of(context).unfocus();
                          login();
                    }
                  }, child: loading ? CircularProgressIndicator() : Text("Login"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Signup()));
                      }, child: Text("Sign Up"))
                    ],
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPhone()));
                  },
                  splashColor: Colors.grey.withOpacity(0.7),
                  highlightColor: Colors.blue.withOpacity(0.5),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Text("login with phone number"),
                    ),
                  ),
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}