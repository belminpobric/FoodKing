import 'dart:convert';
import 'package:flutter/material.dart';

class Authorization {
  static String? username;
  static String? password;
}

Image imageFromBase64String(String base64String,
    {double? width, double? height, BoxFit fit = BoxFit.cover}) {
  return Image.memory(
    base64Decode(base64String),
    width: width,
    height: height,
    fit: fit,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(
        Icons.person,
        size: 60,
        color: Colors.grey,
      );
    },
  );
}
