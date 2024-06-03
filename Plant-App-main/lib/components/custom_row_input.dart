import 'package:flutter/material.dart';

class CustomRowText extends StatelessWidget {
 final String? text;
  final TextEditingController? controller;
  final bool? readOnly;
  final TextInputType? keyboardType;
  const CustomRowText(
      {super.key,
      this.text,
      this.controller,
      this.readOnly,
      this.keyboardType});
  @override
  Widget build(BuildContext context) {
   return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(text ?? '')),
          Expanded(
            flex: 4,
            child: TextFormField(
              textAlign: TextAlign.center,
              controller: controller,
              readOnly: readOnly ?? false,
              keyboardType: keyboardType ?? TextInputType.text,
              validator: (value) =>
                  value!.isEmpty ? 'Không được để trống' : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                //contentPadding: EdgeInsets.all(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}