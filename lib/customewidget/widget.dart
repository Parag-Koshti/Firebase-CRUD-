import 'package:flutter/material.dart';

class AppWidget {
  static Widget text({
    String? title,
    TextAlign? align,
    double? fontSize,
    String? family,
    Color? tColor,
    FontWeight? tWeight,
    int? maxLine,
    TextOverflow? overflowDot,
  }) {
    return Text(
      title!,
      textAlign: align ?? TextAlign.start,
      overflow: overflowDot,
      maxLines: maxLine,
      style: TextStyle(
        fontSize: fontSize ?? 12,
        fontWeight: tWeight ?? FontWeight.w300,
        color: tColor ?? Colors.purple.shade800,
      ),
    );
  }
}
