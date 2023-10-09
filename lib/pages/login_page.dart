import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exercise/pages/bottom_nav_component.dart';
import 'package:flutter_exercise/pages/register_page.dart';
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
  figmaFontSize(int fontSize) {
    return fontSize * 0.95;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> signInWithEmailAndPassword() async {
    setState(() {
      isEmailSignIn;
    });
    try {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('LogIn Failed'),
        ),
      );
    }
    setState(() {
      isEmailSignIn = true;
    });
  }

  Future<void> signInWithGoogle() async {
    setState(() {
      isGoogleSignIn;
    });
    try {
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
      print('Google Sign-In error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('LogIn Failed'),
        ),
      );
    }
    setState(() {
      isGoogleSignIn = true;
    });
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formField,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 30,
                    right: 30,
                    bottom: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset("assets/icons/arrow_back.png"),
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
                          fontSize: figmaFontSize(28),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: cNameSignIn,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(vertical: 3),
                      prefixIcon: Icon(
                        Icons.person,
                        size: 20,
                        color: Color(0xFF7B7B7B),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 1.5,
                        ),
                      ),
                      hintText: "Username",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: figmaFontSize(14),
                      ),
                    ),
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: cEmailSignIn,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 3),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(
                        Icons.email_rounded,
                        size: 20,
                        color: Color(0xFF7B7B7B),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 1.5,
                        ),
                      ),
                      hintText: "Email",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: figmaFontSize(14),
                      ),
                    ),
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email";
                      } else if (!isValidEmail(value)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: cPassSignIn,
                    obscureText: isVisibleSignIn,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 3),
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: Icon(
                        Icons.lock,
                        size: 20,
                        color: Color(0xFF7B7B7B),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 1.5,
                        ),
                      ),
                      hintText: "Password",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: figmaFontSize(14),
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
                    ),
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    if (_formField.currentState!.validate()) {
                      signInWithEmailAndPassword();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 600),
                      width: double.infinity,
                      height: isEmailSignIn ? 70 : 46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFF375A5A),
                      ),
                      child: Center(
                        child: isEmailSignIn
                            ? CircularProgressIndicator(
                                color: Colors.black,
                              )
                            : Text(
                                "Login",
                                style: GoogleFonts.poppins(
                                  color: Color(0xFFFAFAFA),
                                  fontSize: figmaFontSize(15),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Image.asset("assets/images/or_widget.png"),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    signInWithGoogle();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: AnimatedContainer(
                      width: double.infinity,
                      height: isGoogleSignIn ? 70 : 50,
                      duration: Duration(milliseconds: 600),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent,
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF0F110E),
                        ),
                      ),
                      child: isGoogleSignIn
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Colors.black,
                              ),
                            )
                          : Image.asset("assets/icons/google_icon.png"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New User?",
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
                          builder: (context) => RegisterPage(),
                        ),
                      ),
                      child: Text(
                        "Sign Up",
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
