import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabeledTextField extends StatefulWidget {
  const LabeledTextField(
      {Key? key,
      required this.label,
      this.isPasswordField = false,
      this.controller})
      : super(key: key);

  final String label;

  final bool isPasswordField;

  final TextEditingController? controller;

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,
            style: GoogleFonts.prompt(
                fontSize: 14.0, color: const Color(0xFF8A8A8A))),
        const SizedBox(
          height: 4.0,
        ),
        widget.isPasswordField
            ? SizedBox(
              height: 40.0,
              child: TextFormField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1.0),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF8A8A8A), width: 1.0),
                      ),
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })

                      // hintText: 'Mobile Number',
                      ),
                  obscureText: _isObscure,
                  enableSuggestions: false,
                  autocorrect: false,
                  style: const TextStyle(color: Colors.black),
                ),
            )
            : SizedBox(
              height: 40.0,
              child: TextFormField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1.0),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF8A8A8A), width: 1.0),
                    ),

                    // hintText: 'Mobile Number',
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
            )
      ],
    );
  }
}


