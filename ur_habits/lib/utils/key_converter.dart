import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class KeyConverter implements JsonConverter<Key?, String?> {
  const KeyConverter();

  @override
  Key? fromJson(String? json) {
    return json == null ? null : ValueKey(json);
  }

  @override
  String? toJson(Key? key) {
    return key is ValueKey ? key.value.toString() : null;
  }
}
