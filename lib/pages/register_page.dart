import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exercise/component/bottom_nav_component.dart';
import 'package:flutter_exercise/component/custom_button.dart';
import 'package:flutter_exercise/component/custom_textfield.dart';
import 'package:flutter_exercise/component/or_widget.dart';
import 'package:flutter_exercise/helper/constant_app.dart';
import 'package:flutter_exercise/pages/login_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final _formField = GlobalKey<FormState>();
TextEditingController? cNameSignUp;
TextEditingController? cEmailSignUp;
TextEditingController? cPassSignUp;
TextEditingController? cConfirmPassSignUp;
bool isVisiblePass = true;
bool isVisibleConfirm = true;
bool isEmailSignUp = false;
bool isGoogleSignUp = false;

class _RegisterPageState extends State<RegisterPage> {
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      setState(() {
        isEmailSignUp = true;
      });
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: cEmailSignUp!.text,
        password: cPassSignUp!.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Successfully created an account"),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavComponent(),
        ),
        (route) => false,
      );
    } catch (e) {
      setState(() {
        isEmailSignUp = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      setState(() {
        isGoogleSignUp = true;
      });
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged in as ${googleUser.displayName}'),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavComponent(),
        ),
        (route) => false,
      );
    } catch (e) {
      setState(() {
        isGoogleSignUp = false;
      });
      print('Google Sign-In error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Google Sign-In error: $e'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    cNameSignUp = new TextEditingController();
    cEmailSignUp = new TextEditingController();
    cPassSignUp = new TextEditingController();
    cConfirmPassSignUp = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F7),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formField,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    left: 30,
                    right: 30,
                    bottom: 30,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset("assets/logos/logo_hug_horizontal.png")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    bottom: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hey there,",
                        style: GoogleFonts.poppins(),
                      ),
                      Text(
                        "Create an account",
                        style: GoogleFonts.poppins(
                          fontSize: ConstantApp().figmaFontSize(28),
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF357658),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomTextfield(
                  controller: cNameSignUp,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  prefixIcon: Icon(
                    Icons.person,
                    size: 20,
                    color: Color(0xFF7B7B7B),
                  ),
                  hintText: "Username",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your name";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: cEmailSignUp,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    size: 20,
                    color: Color(0xFF7B7B7B),
                  ),
                  hintText: "Email",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    } else if (!isValidEmail(value)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: cPassSignUp,
                  obscureText: isVisiblePass,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: Icon(
                    Icons.lock_rounded,
                    size: 20,
                    color: Color(0xFF7B7B7B),
                  ),
                  hintText: "Password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisiblePass = !isVisiblePass;
                      });
                    },
                    icon: isVisiblePass
                        ? Icon(
                            Icons.visibility_rounded,
                            size: 23,
                            color: Color(0xFF7B7B7B),
                          )
                        : Icon(
                            Icons.visibility_off_rounded,
                            size: 23,
                            color: Color(0xFF7B7B7B),
                          ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: cConfirmPassSignUp,
                  obscureText: isVisibleConfirm,
                  keyboardType: TextInputType.visiblePassword,
                  prefixIcon: Icon(
                    Icons.lock_rounded,
                    size: 20,
                    color: Color(0xFF7B7B7B),
                  ),
                  hintText: "Confirm Password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value != cPassSignUp!.text) {
                      return "Password doesn't match";
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisibleConfirm = !isVisibleConfirm;
                      });
                    },
                    icon: isVisibleConfirm
                        ? Icon(
                            Icons.visibility_rounded,
                            size: 23,
                            color: Color(0xFF7B7B7B),
                          )
                        : Icon(
                            Icons.visibility_off_rounded,
                            size: 23,
                            color: Color(0xFF7B7B7B),
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                  onTap: () {
                    if (_formField.currentState!.validate()) {
                      createUserWithEmailAndPassword();
                    }
                  },
                  isEmailOrGoogle: isEmailSignUp,
                  isColor: true,
                  child: Text(
                    "Register",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: ConstantApp().figmaFontSize(17),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                OrWidget(),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onTap: () {
                    signUpWithGoogle();
                  },
                  isEmailOrGoogle: isGoogleSignUp,
                  isColor: false,
                  child: Image.asset("assets/icons/google_icon.png"),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already as user?",
                      style: GoogleFonts.poppins(
                        color: Color(0xFF0F110E),
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      ),
                      child: Text(
                        "Sign In",
                        style: TextStyle(
                          color: Color(0xFF0F110E),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
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
