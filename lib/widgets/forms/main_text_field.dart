import 'package:flutter/material.dart';

class MainTextField extends StatefulWidget {
  final String name;
  final Icon icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool enabled;
  final String? initialValue;

  const MainTextField({
    required this.name,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.controller,
    this.enabled = true,
    this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:
                focusNode.hasFocus ? const Color(0xE6FF9877) : Colors.black38,
            blurRadius: 25,
            offset: const Offset(0, 5),
          )
        ],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: TextField(
        focusNode: focusNode,
        cursorColor: Colors.black38,
        obscureText: widget.obscureText,
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        enabled: widget.enabled,
        // initialValue: widget.initialValue,
        maxLines: null,
        decoration: InputDecoration(
          prefixIcon: IconTheme(
            data: const IconThemeData(
              color: Color(0xFF5B5B5B),
            ),
            child: widget.icon,
          ),
          hintText: widget.name,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
