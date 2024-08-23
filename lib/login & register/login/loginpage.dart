import 'package:flutter/material.dart';
import 'package:newfirebase/login%20&%20register/login/login_controler.dart';
import 'package:newfirebase/login%20&%20register/register/register_page.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Sign up',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 1, 196, 76))),
              customTextFormField(
                  controller: LoginControler().usernameTXT,
                  hint: '@gmail.com',
                  label: 'Username',
                  leadingIcon: Icons.person,
                  validator: (value) => emptyValidation(value: value)),
              customTextFormField(
                  controller: LoginControler().passwordTXT,
                  hint: '****',
                  label: 'Password',
                  leadingIcon: Icons.password,
                  obscureText: true,
                  validator: (value) => emptyValidation(value: value)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Register_Page()),
                        );
                      },
                      child: const Text('Not a user')),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //Add your action
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Sign Up')),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

// Custom TextFormField
Widget customTextFormField({
  required String label,
  required String hint,
  required String? Function(String?)? validator,
  required IconData leadingIcon,
  required TextEditingController controller,
  double borderRadius = 10.0, // Default obscureText
  bool obscureText = false, // Default obscureText
  Color borderColor = Colors.grey, // Default border color
  Color focusedBorderColor = Colors.redAccent, // Default focus border color
  double borderWidth = 0.3, // Default border width set to 0.3
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        isDense: true,
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(
          leadingIcon,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderColor, width: borderWidth),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      validator: validator,
    ),
  );
}

// Your Validation Method
String? emptyValidation({String? value}) {
  if (value == null || value.isEmpty) {
    return 'Field Empty!';
  }
  return null;
}
