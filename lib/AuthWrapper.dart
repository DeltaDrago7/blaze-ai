import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../functions/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/user.dart';

class AuthWrapper extends StatelessWidget {
  final Widget child;
  final Widget fallBack;

  const AuthWrapper({required this.child, required this.fallBack, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot){
        if (snapshot.hasData){
          return VerifyEmailPage(child: child);
        }
        else{
          return fallBack;
        }
      },
    );
  }
}

class VerifyEmailPage extends StatefulWidget{
  final Widget child;
  const VerifyEmailPage({required this.child, super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool isLoadingUserData = false;

  Timer? timer;
  bool canResendEmail = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      print('calling Verify Email');
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
          (_) => checkEmailVerified(),
      );
    }
    else {
      _loadUserData(); // if already verified, fetch data immediately
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if(isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    print('calling Verify Email');
    try {
      final user = FirebaseAuth.instance.currentUser!;
      FirebaseAuth.instance.setSettings(appVerificationDisabledForTesting: true); //for testing
      print('sending....');
      await user.sendEmailVerification();
      print('....sent');
      setState(() => canResendEmail = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification email sent.')),
      );

      await Future.delayed(Duration(seconds: 10));
      setState(() => canResendEmail = true);
    } on FirebaseAuthException catch (e) {
      final message = e.code == 'too-many-requests'
          ? 'Too many requests. Please wait before trying again.'
          : e.message ?? 'Something went wrong.';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred.')),
      );
    }
  }

  Future<void> _loadUserData() async {
    print('==== _loadUserData ====');
    try {
      if(UserModel.user == null){
        UserModel.user = FirebaseAuth.instance.currentUser!;
      }
      if (UserModel.userData == null && UserModel.user != null) {
        setState(() => isLoadingUserData = true);
        await UserModel.fetchUserFields();
        UserModel.setUserRef();
      }
    } catch (e) {
      debugPrint("Error loading user data: $e");
    } finally {
      if (mounted) setState(() => isLoadingUserData = false);
    }
  }

  Widget build(BuildContext context) => isEmailVerified
      ? isLoadingUserData
        ? Scaffold(
            body: Container(
              width: screenWidth(context),
              height: screenHeight(context),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [mainColor, Colors.deepPurpleAccent,], // Define your gradient colors
                  stops: [0.1, 8.0], // 70% blue, 30% purple
                ),
              ),
              child: Center(child: Container(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(color: Colors.white,)
              ),),
            ),
          )
        : widget.child
      : Scaffold(
          body: Container(
            width: screenWidth(context),
            height: screenHeight(context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [mainColor, Colors.deepPurpleAccent,], // Define your gradient colors
                stops: [0.1, 8.0], // 70% blue, 30% purple
              ),
            ),
              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'A verification email has been sent to your email.',
                        style: GoogleFonts.montserrat(
                          fontSize: screenWidth(context) * 0.04,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24,),

                      AnimatedOpacity(
                        opacity: canResendEmail ? 1.0 : 0.5,
                        duration: Duration(milliseconds: 300),
                        child: SizedBox(
                          width: screenWidth(context),
                          height: buttonHeight,
                          child: TextButton.icon(
                            onPressed: canResendEmail ? sendVerificationEmail : null,
                            icon: Icon(Icons.email, size: 30),
                            label: Text(
                              "Resend Email",
                              style: TextStyle(color: Colors.black),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                        width: screenWidth(context),
                        height: buttonHeight,
                        child: TextButton(
                          onPressed: () {
                            //you can delete the user and his email if u want


                            //for now ill just sign him out
                            FirebaseAuth.instance.signOut();
                          },
                          child: Text("Cancel", style: TextStyle(color:  Colors.white,fontWeight: FontWeight.bold,fontSize: 16),),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
        );
}
