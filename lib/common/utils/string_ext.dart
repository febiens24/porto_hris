import 'package:flutter/material.dart';

import '../../app_loacalization.dart';

extension StringExtension on String {
  String t(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this);
  }
}

extension CapExtension on String {
  String get inCaps =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1)}' : '';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstofEach => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
}
