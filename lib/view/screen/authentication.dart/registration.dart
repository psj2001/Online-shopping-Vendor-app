import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/vendor_auth_controller.dart';
import '../../../utils/app colors.dart';
import '../../../utils/widget/App button widget.dart';
import 'Loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  final VendorAuthController _authcontroller = VendorAuthController();
  late String email;

  late String fullName;

  late String password;
  bool isLoading = false;
  RegisterUser() async {
    setState(() {
      isLoading = true;
    });
    await _authcontroller
        .signUpVendor(
            context: context,
            email: email,
            fullName: fullName,
            password: password)
        .whenComplete(() {
      _formkey.currentState!.reset();
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primaryscaffoldcolor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Create Your Account",
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontSize: 23,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.bold,
                      color: Appcolors.primarytextxolor,
                    ),
                  ),
                  Text(
                    "To Explore the world exclusives",
                    style: GoogleFonts.getFont(
                      'Lato',
                      fontSize: 14,
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.bold,
                      color: const Color(
                        0xFF0d120e,
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/Illustration.png',
                    width: 200,
                    height: 200,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Email",
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your email';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Enter your email',
                        labelStyle: GoogleFonts.getFont(
                          'Nunito Sans',
                          letterSpacing: 0.1,
                          fontSize: 14,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            "assets/email.png",
                            width: 10,
                            height: 10,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Full Name",
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      fullName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Full name';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Enter your Full name',
                        labelStyle: GoogleFonts.getFont(
                          'Nunito Sans',
                          letterSpacing: 0.1,
                          fontSize: 14,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            "assets/user.jpeg",
                            width: 10,
                            height: 10,
                          ),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Password",
                      style: GoogleFonts.getFont(
                        'Nunito Sans',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'enter your password';
                      } else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        labelText: 'Enter your password',
                        labelStyle: GoogleFonts.getFont(
                          'Nunito Sans',
                          letterSpacing: 0.1,
                          fontSize: 14,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            "assets/password.png",
                            width: 10,
                            height: 10,
                          ),
                        ),
                        suffixIcon: const Icon(Icons.visibility)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  isLoading
                      ? const CircularProgressIndicator()
                      : AdvancedButton(
                          onPress: () async {
                            if (_formkey.currentState!.validate()) {
                              RegisterUser();
                              print(email);
                              print(fullName);
                              print(password);
                            } else {
                              print("Failed");
                            }
                          },
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an Account ?",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return Loginsreen();
                            },
                          ));
                        },
                        child: Text(
                          " Sign in",
                          style: GoogleFonts.roboto(
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
