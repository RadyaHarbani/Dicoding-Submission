import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exercise/component/bottom_nav_component.dart';
import 'package:flutter_exercise/component/custom_button.dart';
import 'package:flutter_exercise/component/custom_textfield.dart';
import 'package:flutter_exercise/component/or_widget.dart';
import 'package:flutter_exercise/helper/constant_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _formField = GlobalKey<FormState>();
TextEditingController? cEmailSignIn;
TextEditingController? cPassSignIn;
TextEditingController? cNameSignIn;
bool isVisibleSignIn = true;
bool isEmailSignIn = false;
bool isGoogleSignIn = false;

class _LoginPageState extends State<LoginPage> {

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      setState(() {
        isEmailSignIn = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: cEmailSignIn!.text,
        password: cPassSignIn!.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('LogIn Success'),
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
      print('Login error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('LogIn Failed'),
        ),
      );
      setState(() {
        isEmailSignIn = false;
      });
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      setState(() {
        isGoogleSignIn = true;
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
        isGoogleSignIn = false;
      });
      print('Google Sign-In error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('LogIn Failed'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    cNameSignIn = new TextEditingController();
    cEmailSignIn = new TextEditingController();
    //radya.i4m@gmail.com
    cPassSignIn = new TextEditingController();
    //123456
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
                    top: 10,
                    left: 15,
                    right: 30,
                    bottom: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 18,
                        ),
                      ),
                      Image.asset("assets/logos/logo_hug_horizontal.png")
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    bottom: 40,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome Back! ",
                        style: GoogleFonts.poppins(
                          fontSize:ConstantApp(). figmaFontSize(28),
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF357658),
                        ),
                      ),
                      Text(
                        "Sign in to continue",
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ),
                CustomTextfield(
                  controller: cNameSignIn,
                  obscureText: false,
                  keyboardType: TextInputType.name,
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.person,
                    size: 20,
                    color: Color(0xFF7B7B7B),
                  ),
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
                  controller: cEmailSignIn,
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Email",
                  prefixIcon: Icon(
                    Icons.email_rounded,
                    size: 20,
                    color: Color(0xFF7B7B7B),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    } else if (!isValidEmail(value)) {
                      return "Please enter valid email";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  controller: cPassSignIn,
                  obscureText: isVisibleSignIn,
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.lock,
                    size: 20,
                    color: Color(0xFF7B7B7B),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isVisibleSignIn = !isVisibleSignIn;
                      });
                    },
                    icon: isVisibleSignIn
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
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 6) {
                      return "Password must be at least 6 characters";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                    onTap: () {
                      if (_formField.currentState!.validate()) {
                        signInWithEmailAndPassword();
                      }
                    },
                    isEmailOrGoogle: isEmailSignIn,
                    isColor: true,
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: ConstantApp(). figmaFontSize(17),
                        fontWeight: FontWeight.w500,
                      ),
                    )),
                SizedBox(
                  height: 30,
                ),
                OrWidget(),
                SizedBox(
                  height: 30,
                ),
                CustomButton(
                  onTap: () {
                    signInWithGoogle();
                  },
                  isEmailOrGoogle: isGoogleSignIn,
                  isColor: false,
                  child: Image.asset("assets/icons/google_icon.png"),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
