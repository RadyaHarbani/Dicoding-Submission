import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_exercise/pages/bottom_nav_component.dart';
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
  figmaFontSize(int fontSize) {
    return fontSize * 0.95;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> createUserWithEmailAndPassword() async {
    setState(() {
      isEmailSignUp;
    });
    try {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
    setState(() {
      isEmailSignUp = true;
    });
  }

  Future<void> signInWithGoogle() async {
    setState(() {
      isGoogleSignUp;
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
          content: Text('Google Sign-In error: $e'),
        ),
      );
    }
    setState(() {
      isGoogleSignUp = true;
    });
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
                          fontSize: figmaFontSize(28),
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF357658),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: cNameSignUp,
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
                    controller: cEmailSignUp,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(vertical: 3),
                      prefixIcon: Icon(
                        Icons.email_rounded,
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
                        return "Please enter a valid email";
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
                    controller: cPassSignUp,
                    obscureText: isVisiblePass,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(vertical: 3),
                      prefixIcon: Icon(
                        Icons.lock_rounded,
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
                      hintText: "Password",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: figmaFontSize(14),
                      ),
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
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextFormField(
                    controller: cConfirmPassSignUp,
                    obscureText: isVisibleConfirm,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(vertical: 3),
                      prefixIcon: Icon(
                        Icons.lock_rounded,
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
                      hintText: "Confirm Password",
                      hintStyle: GoogleFonts.poppins(
                        fontSize: figmaFontSize(14),
                      ),
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
                    cursorColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      } else if (value != cPassSignUp!.text) {
                        return "Password doesn't match";
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
                      createUserWithEmailAndPassword();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Container(
                      width: double.infinity,
                      height: isEmailSignUp ? 70 : 46,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xFF375A5A),
                      ),
                      child: Center(
                        child: isEmailSignUp
                            ? CircularProgressIndicator()
                            : Text(
                                "Daftar",
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
                    child: Container(
                      width: double.infinity,
                      height: isGoogleSignUp ? 70 : 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.transparent,
                        border: Border.all(
                          width: 1,
                          color: Color(0xFF0F110E),
                        ),
                      ),
                      child: isGoogleSignUp
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
                      "Already as User?",
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