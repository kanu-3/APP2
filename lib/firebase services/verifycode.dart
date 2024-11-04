import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task2/firebase%20services/form.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;

  const VerifyCode({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final TextEditingController codeController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  String? errorMessage;

  @override
  void dispose() {
    codeController.dispose();
    super.dispose();
  }

  void verifyPhoneNumber() async {
    setState(() {
      loading = true;
      errorMessage = null; 
    });

    final code = codeController.text.trim();
    if (code.length != 6) {
      setState(() {
        loading = false;
        errorMessage = 'Please enter a valid 6-digit code';
      });
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: code,
      );

      await _auth.signInWithCredential(credential);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Forms()));
    } catch (e) {
      setState(() {
        loading = false;
        errorMessage = 'Verification failed: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Code"),
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
                  controller: codeController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.code),
                    hintText: "Enter 6 digit code",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (errorMessage != null) 
              Text(errorMessage!, style: TextStyle(color: Colors.red)),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: loading ? null : verifyPhoneNumber,
              child: loading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}
