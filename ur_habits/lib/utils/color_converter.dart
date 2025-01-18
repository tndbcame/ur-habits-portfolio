// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorConverter implements JsonConverter<Color?, int?> {
  const ColorConverter();

  @override
  Color? fromJson(int? json) {
    return json == null ? null : Color(json);
  }

  @override
  int? toJson(Color? color) {
    return color?.value;
  }
}
