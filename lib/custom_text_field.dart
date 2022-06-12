import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String contentTitle;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Function onTap;
  final bool isRead;
  const CustomTextField(
      {Key? key,
      required this.contentTitle,
      required this.controller,
      required this.focusNode,
      required this.onTap,
      required this.isRead})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.contentTitle),
        TextField(
          readOnly: widget.isRead,
          onTap: () {
            widget.onTap();
          },
          focusNode: widget.focusNode,
          inputFormatters: [
            //    UpperCaseTextFormatter(),
            FilteringTextInputFormatter.deny(RegExp('[- ]'))
          ],
          controller: widget.controller,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ],
    );
  }
}
