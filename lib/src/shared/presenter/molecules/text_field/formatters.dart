import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class YearTextInputFormatter implements TextInputFormatter {
  final MaskedInputFormatter formatter = MaskedInputFormatter('####');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) =>
      formatter.formatEditUpdate(oldValue, newValue);
}
