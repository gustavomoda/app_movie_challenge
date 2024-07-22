import 'package:flutter/material.dart';

@immutable
class ValueTextField {
  const ValueTextField({required this.text, required this.errorMessage});

  final bool text;
  final String? errorMessage;

  ValueTextField copyWith({bool? text, String? errorMessage}) => ValueTextField(
        text: text ?? this.text,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ValueTextField &&
          runtimeType == other.runtimeType &&
          text == other.text &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => text.hashCode ^ errorMessage.hashCode;
}
