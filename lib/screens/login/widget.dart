import 'package:app_chess/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? pretfixIcon;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.pretfixIcon,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode focusNode = FocusNode();
  bool focus = false;
  @override
  void initState() {
    // TODO: implement initState
    focusNode.addListener(() {
      focus = focusNode.hasFocus;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65, // Standard height for the text field
      child: TextField(
        focusNode: focusNode,
        controller: widget.controller,
        obscureText: widget.obscureText,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          // hintText: hintText,
          labelText: widget.hintText,
          labelStyle: focus
              ? context.textTheme.titleMedium
              : context.textTheme.titleSmall,
          // hintTextDirection: TextD,
          // hintFadeDuration:Duration(),
          hintStyle: TextStyle(
            color: context.theme.primaryColor,
            fontSize: 16,
          ),
          prefixIcon: Container(
              padding: const EdgeInsets.all(12), // Adjust padding for icon size
              child: widget.pretfixIcon),
          suffixIcon: widget.suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28), // Rounded corners
            borderSide: BorderSide(
              color: context.theme.primaryColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(
              color: context.theme.primaryColor,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

// Example usage:
class ExampleUsage extends StatelessWidget {
  ExampleUsage({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomTextField(
        controller: _controller,
        hintText: 'Username',
      ),
    );
  }
}
