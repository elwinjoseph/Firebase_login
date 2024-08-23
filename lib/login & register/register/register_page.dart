import 'package:flutter/material.dart';
import 'package:newfirebase/login%20&%20register/register/register_controller.dart';

class Register_Page extends StatelessWidget {
  Register_Page({super.key});

  final _formKey = GlobalKey<FormState>();
  final RegistratioPageController controller = RegistratioPageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Registration',
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 1, 196, 76))),
              customTextFormField(
                  controller: controller.userTXT,
                  hint: '@gmail.com',
                  label: 'Username',
                  leadingIcon: Icons.person,
                  validator: (value) => emptyValidation(value: value)),
              customTextFormField(
                  controller: controller.passTXT,
                  hint: '****',
                  label: 'Password',
                  leadingIcon: Icons.password,
                  obscureText: true,
                  validator: (value) => emptyValidation(value: value)),
              customTextFormField(
                  controller: controller.conpassTXT,
                  hint: '****',
                  label: 'Confirm Password',
                  leadingIcon: Icons.password,
                  obscureText: true,
                  validator: (value) => emptyValidation(value: value)),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (controller.passTXT.text ==
                          controller.conpassTXT.text) {
                        controller.register(context: context);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              elevation: 16,
                              behavior: SnackBarBehavior.floating,
                              content: Text('password does not match')),
                        );
                      }
                    }
                  },
                  child: const Text('Sign Up'))
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
