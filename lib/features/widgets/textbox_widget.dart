import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextboxWidget extends StatelessWidget {
  const TextboxWidget({
    Key? key,
    required this.label,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.readOnly = true,
    this.maxLines,
    this.minLines,
    this.keyboardType,
    this.onTap,
    this.validator,
  }) : super(key: key);

  final String label;
  final String hintText;
  final bool? readOnly;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final int? maxLines, minLines;
  final TextInputType? keyboardType;
  final GestureTapCallback? onTap;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: textTheme.bodyMedium!.copyWith(
            color: const Color(0xffADADAD),
          ),
        ),
        SizedBox(
          height: 6.h,
        ),
        TextFormField(
          onTap: onTap,
          validator: validator,
          maxLines: maxLines,
          minLines: minLines,
          controller: controller,
          key: key,
          keyboardType: keyboardType,
          autofocus: false,
          style: textTheme.bodyMedium!.copyWith(
            color: Colors.black,
          ),
          decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(
              maxHeight: 32.h,
              maxWidth: 32.h,
            ),
            // filled: true,
            // fillColor: const Color(0xffF2F2F2),
            hintText: hintText,
            prefixIcon: prefixIcon,
            enabledBorder: const UnderlineInputBorder(),
            focusedBorder: const UnderlineInputBorder(),
            border: const UnderlineInputBorder(),
            hintStyle: textTheme.bodyMedium!.copyWith(
              color: Colors.black,
            ),
            // contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            // border: OutlineInputBorder(
            //   borderSide: const BorderSide(
            //     color: Color(0xffF2F2F2),
            //   ),
            //   borderRadius: BorderRadius.circular(6.0),
            // ),
            // errorBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(
            //     color: Color(0xffF2F2F2),
            //   ),
            //   borderRadius: BorderRadius.circular(6.0),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(
            //     color: Color(0xffF2F2F2),
            //   ),
            //   borderRadius: BorderRadius.circular(6.0),
            // ),
            // focusedErrorBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(
            //     color: Color(0xffF2F2F2),
            //   ),
            //   borderRadius: BorderRadius.circular(6.0),
            // ),
            // disabledBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(
            //     color: Color(0xffF2F2F2),
            //   ),
            //   borderRadius: BorderRadius.circular(6.0),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(
            //     color: Color(0xffF2F2F2),
            //   ),
            //   borderRadius: BorderRadius.circular(6.0),
            // ),
          ),
          readOnly: readOnly!,
        ),
      ],
    );
  }
}
