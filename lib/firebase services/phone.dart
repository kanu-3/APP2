import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task2/firebase services/verifycode.dart';
import 'package:task2/util/util.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  final phoneNumberController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool loading = false;

  void verifyPhoneNumber() async {
    setState(() {
      loading = true;
    });

    _auth.verifyPhoneNumber(
      phoneNumber: phoneNumberController.text,
      verificationCompleted: (e)  {
        
        setState(() {
          loading = false;
        });
       
      },
      verificationFailed: (e) {
        setState(() {
          loading = false;
        });
        Util().toastMessage(e.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          loading = false;
        });
        
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyCode(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (e) {
        Util().toastMessage(e.toString());
        setState(() {
          loading = false;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login with Phone"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.phone),
                    hintText: "+91 xxxxxxx593",
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
            ),
             SizedBox(height: 20),
            ElevatedButton(
              onPressed: loading ? null : verifyPhoneNumber,
              child: loading
                  ?  CircularProgressIndicator(color: Colors.white)
                  :  Text("Send code"),
            ),
          ],
        ),
      ),
    );
  }
}
