import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Extension on [String] for common validations.
extension StringValidation on String {
  bool get isValidEmail =>
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
          .hasMatch(this);

  bool get isValidPhone =>
      RegExp(r'^[0-9+()\-\s]{7,20}$').hasMatch(this);

  bool get isValidColombianPlate =>
      RegExp(r'^[A-Z]{3}\d{2}[A-Z]$').hasMatch(toUpperCase());

  bool get isValid2FACode => RegExp(r'^\d{6}$').hasMatch(this);
}

/// Extension on [DateTime] for formatting.
extension DateTimeFormatting on DateTime {
  /// Formats as `yyyy-MM-dd`
  String toApiDate() => DateFormat('yyyy-MM-dd').format(this);

  /// Formats as `dd/MM/yyyy`
  String toDisplayDate() => DateFormat('dd/MM/yyyy').format(this);

  /// Formats as `dd MMM yyyy` (e.g. "15 Mar 2026")
  String toReadableDate() => DateFormat('dd MMM yyyy', 'es').format(this);

  /// Formats as `dd MMM yyyy, hh:mm a`
  String toReadableDateTime() =>
      DateFormat('dd MMM yyyy, hh:mm a', 'es').format(this);
}

/// Extension on [TimeOfDay] for formatting.
extension TimeOfDayFormatting on TimeOfDay {
  /// Formats as `HH:mm`
  String toApiTime() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';

  /// Formats as readable time (e.g. "8:00 AM")
  String toDisplayTime(BuildContext context) =>
      MaterialLocalizations.of(context).formatTimeOfDay(
        this,
        alwaysUse24HourFormat: false,
      );
}

/// Extension on [BuildContext] for quick access to theme.
extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
            isError ? colorScheme.error : colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
