import 'package:books_app__flutter/Dio.dart';
import 'package:books_app__flutter/login.dart';
import 'package:books_app__flutter/widgets/form%20components/iconBox.dart';
import 'package:books_app__flutter/widgets/form%20components/passwordFormFieldCustom.dart';
import 'package:books_app__flutter/widgets/form%20components/textFormFieldCustom.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class signupscreen extends StatefulWidget {
  const signupscreen({super.key});

  @override
  State<signupscreen> createState() => _signupscreenState();
}

class _signupscreenState extends State<signupscreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = true;
    isConfirmPasswordVisible = true;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signupBackend() async {
    try {
      final res = await dio.post(
        '/auth/signup',
        data: {
          'username': _usernameController.text,
          'name': _usernameController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
          'conformPassword': _confirmPasswordController.text,
        },
      );

      if (res.statusCode == 201) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Signup Successful'),
            content: Text(
              res.data['message'] ?? 'You have signed up successfully.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return loginscreen();
                      },
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
        _formKey.currentState!.reset();
      }
    } catch (e) {
      String errorMsg = 'Unknown error occurred';
      if (e is DioException) {
        if (e.response != null && e.response?.data != null) {
          errorMsg = e.response!.data['message'] ?? errorMsg;
        } else {
          errorMsg = e.message!;
        }
      }

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Signup Failed'),
          content: Text(errorMsg),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _submitSignup() {
    if (_formKey.currentState!.validate()) {
      _signupBackend();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Create Account to Get Started",
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 50),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    textFormFieldCustom(
                      controller: _usernameController,
                      keyboardType: TextInputType.text,
                      hintText: "Username",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        } else if (value.length < 4) {
                          return 'Username must be at least 4 characters long';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    textFormFieldCustom(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      hintText: "Email",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!RegExp(
                          r'^[^@]+@[^@]+\.[^@]+',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    SizedBox(height: 20),

                    passwordFormFieldCustom(
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "Password",
                      isPasswordVisible: isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      onTogglePasswordVisibility: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),

                    SizedBox(height: 20),

                    passwordFormFieldCustom(
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      hintText: "Confirm Password",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        } else if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      isPasswordVisible: isConfirmPasswordVisible,
                      onTogglePasswordVisibility: () {
                        setState(() {
                          isConfirmPasswordVisible = !isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _submitSignup();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: EdgeInsets.symmetric(vertical: 23.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 50),

              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 1,
                      endIndent: 10,
                    ),
                  ),
                  Text(
                    'or continue with',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey[400],
                      thickness: 1,
                      indent: 10,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 20),
                  iconBox(icon: Icons.facebook, color: Colors.blue),
                  SizedBox(width: 20),
                  iconBox(icon: Icons.mail_rounded, color: Colors.red),
                  SizedBox(width: 20),
                  iconBox(icon: Icons.apple, color: Colors.black),
                  SizedBox(width: 20),
                ],
              ),

              SizedBox(height: 50),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a Member?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return loginscreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Login Now',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
